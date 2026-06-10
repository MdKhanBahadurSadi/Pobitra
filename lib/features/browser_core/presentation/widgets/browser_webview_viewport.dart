import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pobitra_browser/features/ad_blocker/data/ad_blocker_service.dart';
import 'package:pobitra_browser/features/ad_blocker/presentation/bloc/ad_blocker_cubit.dart';
import 'package:pobitra_browser/core/utils/autofill_scripts.dart';
import 'package:pobitra_browser/features/password_manager/data/datasources/secure_credential_store.dart';
import 'package:pobitra_browser/features/password_manager/presentation/bloc/vault_cubit.dart';
import 'package:pobitra_browser/features/ai_assistant/data/datasources/vision_source.dart';
import 'package:pobitra_browser/features/ai_assistant/presentation/widgets/fact_check_badge.dart';
import 'package:pobitra_browser/core/services/download_manager.dart';
import 'package:pobitra_browser/core/theme/theme_cubit.dart';
import 'package:pobitra_browser/core/theme/app_theme.dart';
import 'package:pobitra_browser/features/browser_core/data/user_script_service.dart';
import 'dark_injector_service.dart';
import 'package:pobitra_browser/core/security/telemetry_guard.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'dart:ui' as ui;
import '../bloc/tab_cubit.dart';
import '../../data/models/tab_model.dart';

class BrowserWebViewViewport extends StatefulWidget {
  final TabModel tab;
  static InAppWebViewController? activeController;

  const BrowserWebViewViewport({super.key, required this.tab});

  @override
  BrowserWebViewViewportState createState() => BrowserWebViewViewportState();
}

class BrowserWebViewViewportState extends State<BrowserWebViewViewport> {
  InAppWebViewController? webViewController;
  PullToRefreshController? pullToRefreshController;
  final GlobalKey _repaintKey = GlobalKey();
  final VisionSource _visionSource = VisionSource();

  @override
  void initState() {
    super.initState();
    pullToRefreshController = kIsWeb
        ? null
        : PullToRefreshController(
            settings: PullToRefreshSettings(
              color: Colors.blue,
            ),
            onRefresh: () async {
              if (defaultTargetPlatform == TargetPlatform.android) {
                webViewController?.reload();
              } else if (defaultTargetPlatform == TargetPlatform.iOS) {
                webViewController?.loadUrl(
                  urlRequest: URLRequest(url: await webViewController?.getUrl()),
                );
              }
            },
          );
  }

  @override
  void didUpdateWidget(covariant BrowserWebViewViewport oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.tab.currentUrl != widget.tab.currentUrl) {
      webViewController?.loadUrl(
        urlRequest: URLRequest(url: WebUri(widget.tab.currentUrl)),
      );
    } else if (oldWidget.tab.lastReload != widget.tab.lastReload &&
        widget.tab.lastReload != null) {
      webViewController?.reload();
    }
  }

  void _handlePasswordForms(String domain, dynamic forms) async {
    final credentials = await SecureCredentialStore().getCredentialsForDomain(domain);
    if (credentials.isNotEmpty && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Saved passwords found for $domain'),
          action: SnackBarAction(
            label: 'Autofill',
            onPressed: () async {
              // Trigger biometric unlock before autofill
              await context.read<VaultCubit>().unlockVault();
              if (context.read<VaultCubit>().state.status == VaultStatus.unlocked) {
                final cred = credentials.first;
                await webViewController?.evaluateJavascript(
                  source: AutofillScripts.fillFormScript(cred.username, cred.password),
                );
              }
            },
          ),
        ),
      );
    }
  }

  void _showFactCheck(String text) async {
    showDialog(
      context: context,
      barrierColor: Colors.black54,
      builder: (context) => Center(
        child: FutureBuilder<String>(
          future: _visionSource.factCheck(text),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: FactCheckBadge(result: snapshot.data ?? 'Error'),
            );
          },
        ),
      ),
    );
  }

  void _analyzeImageAtUrl(String url) async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final bytes = response.bodyBytes;
        _showImageAnalysis(bytes);
      }
    } catch (e) {
      logger.log('Error fetching image for analysis: $e');
    }
  }

  void _showImageAnalysis(Uint8List bytes) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.5,
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          children: [
            const SizedBox(height: 12),
            Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.grey[400], borderRadius: BorderRadius.circular(2))),
            Expanded(
              child: FutureBuilder<String>(
                future: _visionSource.analyzeImage(bytes),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      children: [
                        ClipRRect(borderRadius: BorderRadius.circular(12), child: Image.memory(bytes, height: 150, fit: BoxFit.cover)),
                        const SizedBox(height: 16),
                        const Text('AI Image Analysis', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                        const SizedBox(height: 12),
                        Text(snapshot.data ?? 'No analysis available.', textAlign: TextAlign.center),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _applyForcedDarkMode(InAppWebViewController controller) async {
    if (!mounted) return;
    final themeMode = context.read<ThemeCubit>().state;
    if (themeMode == AppThemeMode.dark || themeMode == AppThemeMode.amoled) {
      await controller.evaluateJavascript(source: DarkInjectorService.forceDarkScript);
    }
  }

  void _applyUserScripts(InAppWebViewController controller, String url) async {
    final scripts = await UserScriptService().getActiveScriptsForUrl(url);
    for (final script in scripts) {
      await controller.evaluateJavascript(source: script.source);
    }
  }

  bool _showPiP = false;
  void _showPiPButton() {
    if (!_showPiP) {
      setState(() => _showPiP = true);
    }
  }

  Future<void> captureAndParseScreenshot() async {
    try {
      RenderRepaintBoundary boundary = _repaintKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 2.0);
      ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();

      final result = await _visionSource.parseScreenshot(pngBytes);
      if (mounted) {
        _showScreenshotActions(result);
      }
    } catch (e) {
      logger.log('Error capturing screenshot: $e');
    }
  }

  void _showScreenshotActions(Map<String, dynamic> result) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Screenshot Intelligence', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            const SizedBox(height: 12),
            Text(result['extracted_details'] ?? 'Content analyzed.'),
            const SizedBox(height: 16),
            if (result['has_bill'] == true)
              ListTile(
                leading: const Icon(Icons.receipt_long, color: Colors.blue),
                title: const Text('Save Bill Details'),
                onTap: () => Navigator.pop(context),
              ),
            if (result['has_contact'] == true)
              ListTile(
                leading: const Icon(Icons.person_add, color: Colors.green),
                title: const Text('Add to Contacts'),
                onTap: () => Navigator.pop(context),
              ),
            ListTile(
              leading: const Icon(Icons.copy),
              title: const Text('Copy Extracted Text'),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }

  double _dragStartX = 0;

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<ThemeCubit, AppThemeMode>(
          listener: (context, mode) {
            if (webViewController != null) {
              if (mode == AppThemeMode.dark || mode == AppThemeMode.amoled) {
                webViewController!.evaluateJavascript(source: DarkInjectorService.forceDarkScript);
              } else {
                webViewController!.evaluateJavascript(source: DarkInjectorService.removeDarkScript);
              }
            }
          },
        ),
      ],
      child: GestureDetector(
        onHorizontalDragStart: (details) {
        _dragStartX = details.globalPosition.dx;
      },
      onHorizontalDragEnd: (details) {
        if (details.primaryVelocity == null) return;
        
        final screenWidth = MediaQuery.of(context).size.width;
        const edgeThreshold = 40.0;

        // Edge Swipe Right (from left edge) -> Back
        if (details.primaryVelocity! > 500 && _dragStartX < edgeThreshold) {
          webViewController?.goBack();
        }
        // Edge Swipe Left (from right edge) -> Forward
        else if (details.primaryVelocity! < -500 && _dragStartX > screenWidth - edgeThreshold) {
          webViewController?.goForward();
        }
      },
      child: RepaintBoundary(
        key: _repaintKey,
        child: Stack(
          children: [
            InAppWebView(
              initialUrlRequest: URLRequest(url: WebUri(widget.tab.currentUrl)),
          initialSettings: InAppWebViewSettings(
            javaScriptEnabled: true,
            supportZoom: true,
            incognito: widget.tab.isIncognito,
            transparentBackground: true,
            isInspectable: kDebugMode,
            useOnDownloadStart: true,
            useShouldInterceptRequest: true,
            // Enhanced Sandbox for Incognito
            cacheEnabled: !widget.tab.isIncognito,
            databaseEnabled: !widget.tab.isIncognito,
            domStorageEnabled: !widget.tab.isIncognito,
            thirdPartyCookiesEnabled: !widget.tab.isIncognito,
            safeBrowsingEnabled: true,
          ),
          contextMenu: ContextMenu(
            menuItems: [
              ContextMenuItem(
                id: 1,
                title: "Fact Check with Pobitra AI",
                action: () async {
                  final selectedText = await webViewController?.getSelectedText();
                  if (selectedText != null && selectedText.isNotEmpty) {
                    _showFactCheck(selectedText);
                  }
                },
              ),
            ],
          ),
          onDownloadStartRequest: (controller, downloadStartRequest) async {
            final url = downloadStartRequest.url.toString();
            final fileName = downloadStartRequest.suggestedFilename ?? 'download';
            
            await DownloadManager().startDownload(url, fileName);
            
            if (mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Starting download: $fileName')),
              );
            }
          },
          onLongPressHitTestResult: (controller, hitTestResult) async {
            if (hitTestResult.type == InAppWebViewHitTestResultType.IMAGE_TYPE ||
                hitTestResult.type == InAppWebViewHitTestResultType.SRC_IMAGE_ANCHOR_TYPE) {
              final imageUrl = hitTestResult.extra;
              if (imageUrl != null) {
                _analyzeImageAtUrl(imageUrl);
              }
            }
          },
          shouldInterceptRequest: (controller, request) async {
          final adBlockerCubit = context.read<AdBlockerCubit>();
          if (!adBlockerCubit.state.isEnabled) return null;

          final url = request.url;
          if (AdBlockerService().shouldBlock(url.host)) {
            adBlockerCubit.incrementBlockedCount();
            return WebResourceResponse(
              contentType: 'text/plain',
              data: Uint8List(0),
            );
          }
          return null;
        },
        pullToRefreshController: pullToRefreshController,
        onWebViewCreated: (controller) {
          webViewController = controller;
          BrowserWebViewViewport.activeController = controller;

          controller.addJavaScriptHandler(
            handlerName: 'onVideoDetected',
            callback: (args) {
              if (mounted) {
                _showPiPButton();
              }
            },
          );

          controller.addJavaScriptHandler(
            handlerName: 'onPasswordFormDetected',
            callback: (args) async {
              final domain = args[0]['domain'];
              final forms = args[0]['forms'];
              
              if (forms.isNotEmpty) {
                _handlePasswordForms(domain, forms);
              }
            },
          );
        },
        onLoadStart: (controller, url) {
          if (url != null) {
            context.read<TabCubit>().updateTabUrl(
                  widget.tab.id,
                  url.toString(),
                  'Loading...',
                );
          }
        },
        onLoadStop: (controller, url) async {
          pullToRefreshController?.endRefreshing();
          if (url != null) {
            final title = await controller.getTitle();
            final favicon = (await controller.getFavicons()).firstOrNull?.url;
            context.read<TabCubit>().updateTabUrl(
                  widget.tab.id,
                  url.toString(),
                  title ?? 'No Title',
                  faviconUrl: favicon?.toString(),
                );
            
            // Inject autofill scanning script
            await controller.evaluateJavascript(source: AutofillScripts.scanFormsScript);

            // Handle Forced Dark Mode
            _applyForcedDarkMode(controller);

            // Handle User Scripts
            _applyUserScripts(controller, url.toString());

            // Video Detection for PiP
            await controller.evaluateJavascript(source: """
              (function() {
                const detectVideo = () => {
                  const videos = document.querySelectorAll('video');
                  if (videos.length > 0) {
                    window.flutter_inappwebview.callHandler('onVideoDetected');
                  }
                };
                detectVideo();
                const observer = new MutationObserver(detectVideo);
                observer.observe(document.body, { childList: true, subtree: true });
              })();
            """);
          }
        },
        onContentSizeChanged: (controller, oldContentSize, newContentSize) {
          _applyForcedDarkMode(controller);
        },
        onProgressChanged: (controller, progress) {
          if (progress == 100) {
            pullToRefreshController?.endRefreshing();
          }
          context.read<TabCubit>().updateProgress(widget.tab.id, progress / 100);
        },
      ),
      if (_showPiP)
        Positioned(
          right: 16,
          bottom: 100,
          child: FloatingActionButton.small(
            backgroundColor: Colors.blue.withOpacity(0.8),
            onPressed: () {
              // Trigger PiP View logic
              print("PiP Requested for video");
            },
            child: const Icon(Icons.picture_in_picture_alt, color: Colors.white),
          ),
        ),
      ],
    ),
  ),
);
}
}
