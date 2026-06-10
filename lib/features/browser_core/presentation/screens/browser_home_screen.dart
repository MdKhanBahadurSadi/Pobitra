import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/tab_cubit.dart';
import '../widgets/browser_webview_viewport.dart';
import '../widgets/smart_address_bar.dart';
import 'package:pobitra_browser/features/reader_mode/presentation/widgets/reader_view_overlay.dart';
import 'package:pobitra_browser/features/ai_assistant/presentation/widgets/ai_assistant_panel.dart';
import 'package:pobitra_browser/core/utils/dom_scraper.dart';

class BrowserHomeScreen extends StatefulWidget {
  const BrowserHomeScreen({super.key});

  @override
  State<BrowserHomeScreen> createState() => _BrowserHomeScreenState();
}

class _BrowserHomeScreenState extends State<BrowserHomeScreen> {
  bool _showTabOverview = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                const SmartAddressBar(),
                Expanded(
                  child: BlocBuilder<TabCubit, TabState>(
                    builder: (context, state) {
                      final activeTab = state.activeTab;
                      if (activeTab == null) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      return BrowserWebViewViewport(
                        key: ValueKey(activeTab.id),
                        tab: activeTab,
                      );
                    },
                  ),
                ),
              ],
            ),
            const ReaderViewOverlay(),
            if (_showTabOverview) _buildTabOverview(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openAiAssistant,
        backgroundColor: Colors.purple,
        child: const Icon(Icons.auto_awesome, color: Colors.white),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => BrowserWebViewViewport.activeController?.goBack(),
            ),
            IconButton(
              icon: const Icon(Icons.arrow_forward),
              onPressed: () => BrowserWebViewViewport.activeController?.goForward(),
            ),
            IconButton(
              icon: const Icon(Icons.layers),
              onPressed: () => setState(() => _showTabOverview = !_showTabOverview),
            ),
            IconButton(
              icon: const Icon(Icons.home),
              onPressed: () {
                final activeTab = context.read<TabCubit>().state.activeTab;
                if (activeTab != null) {
                  context.read<TabCubit>().updateTabUrl(
                        activeTab.id,
                        'https://www.google.com',
                        'Google',
                      );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  void _openAiAssistant() async {
    final controller = BrowserWebViewViewport.activeController;
    if (controller != null) {
      final textContent = await controller.evaluateJavascript(
        source: DomScraper.cleanTextScript,
      );
      if (mounted && textContent != null) {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (context) => AiAssistantPanel(
            pageContent: textContent.toString(),
          ),
        );
      }
    }
  }

  Widget _buildTabOverview() {
    return BlocBuilder<TabCubit, TabState>(
      builder: (context, state) {
        return Container(
          color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.95),
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Tabs (${state.tabs.length})',
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      context.read<TabCubit>().addNewTab('https://www.google.com');
                      setState(() => _showTabOverview = false);
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => setState(() => _showTabOverview = false),
                  ),
                ],
              ),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 0.8,
                  ),
                  itemCount: state.tabs.length,
                  itemBuilder: (context, index) {
                    final tab = state.tabs[index];
                    final isActive = tab.id == state.activeTabId;
                    return GestureDetector(
                      onTap: () {
                        context.read<TabCubit>().switchToTab(tab.id);
                        setState(() => _showTabOverview = false);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(12),
                          border: isActive
                              ? Border.all(color: Theme.of(context).primaryColor, width: 3)
                              : Border.all(color: Colors.grey.withOpacity(0.3)),
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  if (tab.faviconUrl != null)
                                    Image.network(tab.faviconUrl!, width: 16, height: 16)
                                  else
                                    const Icon(Icons.public, size: 16),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      tab.title,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.close, size: 16),
                                    onPressed: () => context.read<TabCubit>().closeTab(tab.id),
                                  ),
                                ],
                              ),
                            ),
                            const Spacer(),
                            Icon(Icons.web, size: 48, color: Colors.grey.withOpacity(0.5)),
                            const Spacer(),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
