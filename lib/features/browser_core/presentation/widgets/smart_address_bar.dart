import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:convert';
import '../bloc/tab_cubit.dart';
import 'package:pobitra_browser/features/reader_mode/presentation/bloc/reader_mode_cubit.dart';
import 'package:pobitra_browser/features/reader_mode/data/models/reader_content.dart';
import 'package:pobitra_browser/core/utils/reader_scraper.dart';
import 'browser_webview_viewport.dart';

class SmartAddressBar extends StatefulWidget {
  const SmartAddressBar({super.key});

  @override
  State<SmartAddressBar> createState() => _SmartAddressBarState();
}

class _SmartAddressBarState extends State<SmartAddressBar> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
        if (!_isFocused) {
          // Reset to domain view when losing focus
          final activeTab = context.read<TabCubit>().state.activeTab;
          if (activeTab != null) {
            _controller.text = _getDisplayUrl(activeTab.currentUrl);
          }
        } else {
          // Show full URL on focus
          final activeTab = context.read<TabCubit>().state.activeTab;
          if (activeTab != null) {
            _controller.text = activeTab.currentUrl;
            _controller.selection = TextSelection(
              baseOffset: 0,
              extentOffset: _controller.text.length,
            );
          }
        }
      });
    });
  }

  String _getDisplayUrl(String url) {
    try {
      final uri = Uri.parse(url);
      return uri.host.replaceFirst('www.', '');
    } catch (_) {
      return url;
    }
  }

  void _handleSubmitted(String value) {
    if (value.isEmpty) return;

    String targetUrl;
    final urlPattern = RegExp(
        r'^(https?:\/\/)?([\w\d-]+\.)+[\w-]+(\/[\w\d-.\/?%&=]*)?$');

    if (urlPattern.hasMatch(value)) {
      targetUrl = value.startsWith('http') ? value : 'https://$value';
    } else {
      targetUrl = 'https://www.google.com/search?q=${Uri.encodeComponent(value)}';
    }

    final activeTab = context.read<TabCubit>().state.activeTab;
    if (activeTab != null) {
      // In a real app, we'd trigger a navigation in the WebView.
      // For this implementation, we update the state which the WebView listens to.
      context.read<TabCubit>().updateTabUrl(activeTab.id, targetUrl, 'Loading...');
    }
    _focusNode.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TabCubit, TabState>(
      builder: (context, state) {
        final activeTab = state.activeTab;
        if (activeTab == null) return const SizedBox.shrink();

        if (!_isFocused) {
          _controller.text = _getDisplayUrl(activeTab.currentUrl);
        }

        final isLoading = activeTab.loadingProgress < 1.0;

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            border: Border(bottom: BorderSide(color: Theme.of(context).dividerColor)),
          ),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                    color: Theme.of(context).hoverColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextField(
                    controller: _controller,
                    focusNode: _focusNode,
                    onSubmitted: _handleSubmitted,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      hintText: 'Search or enter URL',
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(vertical: 10),
                      prefixIcon: Icon(
                        activeTab.isIncognito ? Icons.security : Icons.lock_outline,
                        size: 16,
                      ),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.chrome_reader_mode, size: 20),
                        onPressed: () async {
                          final controller = BrowserWebViewViewport.activeController;
                          if (controller != null) {
                            final result = await controller.evaluateJavascript(
                              source: ReaderScraper.extractScript,
                            );
                            if (result != null) {
                              final content = ReaderContent.fromJson(jsonDecode(result));
                              if (context.mounted) {
                                context.read<ReaderModeCubit>().enterReaderMode(content);
                              }
                            }
                          }
                        },
                      ),
                    ),
                    style: const TextStyle(fontSize: 14),
                  ),
                ),
              ),
              IconButton(
                icon: isLoading ? const Icon(Icons.close) : const Icon(Icons.refresh),
                onPressed: () {
                  if (isLoading) {
                    // Stop loading - for now we just reload as a simple stop is harder to trigger via state
                    context.read<TabCubit>().reloadTab(activeTab.id);
                  } else {
                    context.read<TabCubit>().reloadTab(activeTab.id);
                  }
                },
              ),
              Stack(
                alignment: Alignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.tab),
                    onPressed: () {
                      // Navigate to Tab Manager
                    },
                  ),
                  Positioned(
                    right: 8,
                    top: 8,
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 14,
                        minHeight: 14,
                      ),
                      child: Text(
                        '${state.tabs.length}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }
}
