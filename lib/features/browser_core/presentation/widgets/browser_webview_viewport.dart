import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pobitra_browser/features/ad_blocker/data/ad_blocker_service.dart';
import 'package:pobitra_browser/features/ad_blocker/presentation/bloc/ad_blocker_cubit.dart';
import '../bloc/tab_cubit.dart';
import '../../data/models/tab_model.dart';

class BrowserWebViewViewport extends StatefulWidget {
  final TabModel tab;
  static InAppWebViewController? activeController;

  const BrowserWebViewViewport({super.key, required this.tab});

  @override
  State<BrowserWebViewViewport> createState() => _BrowserWebViewViewportState();
}

class _BrowserWebViewViewportState extends State<BrowserWebViewViewport> {
  InAppWebViewController? webViewController;
  PullToRefreshController? pullToRefreshController;

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

  double _dragStartX = 0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
      child: InAppWebView(
        initialUrlRequest: URLRequest(url: WebUri(widget.tab.currentUrl)),
        initialSettings: InAppWebViewSettings(
          javaScriptEnabled: true,
          supportZoom: true,
          incognito: widget.tab.isIncognito,
          transparentBackground: true,
          isInspectable: kDebugMode,
          useOnDownloadStart: true,
          useShouldInterceptRequest: true,
        ),
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
          }
        },
        onProgressChanged: (controller, progress) {
          if (progress == 100) {
            pullToRefreshController?.endRefreshing();
          }
          context.read<TabCubit>().updateProgress(widget.tab.id, progress / 100);
        },
      ),
    );
  }
}
