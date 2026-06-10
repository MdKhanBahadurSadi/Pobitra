import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/tab_model.dart';

class TabState {
  final List<TabModel> tabs;
  final String? activeTabId;

  TabState({
    this.tabs = const [],
    this.activeTabId,
  });

  TabModel? get activeTab {
    if (activeTabId == null) return null;
    return tabs.firstWhere((tab) => tab.id == activeTabId);
  }

  TabState copyWith({
    List<TabModel>? tabs,
    String? activeTabId,
  }) {
    return TabState(
      tabs: tabs ?? this.tabs,
      activeTabId: activeTabId ?? this.activeTabId,
    );
  }
}

class TabCubit extends Cubit<TabState> {
  TabCubit() : super(TabState());

  void addNewTab(String url, {bool isIncognito = false}) {
    final newTab = TabModel(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      currentUrl: url,
      title: 'New Tab',
      isIncognito: isIncognito,
    );

    final updatedTabs = List<TabModel>.from(state.tabs)..add(newTab);
    emit(state.copyWith(
      tabs: updatedTabs,
      activeTabId: newTab.id,
    ));
  }

  void closeTab(String id) {
    final updatedTabs = state.tabs.where((tab) => tab.id != id).toList();
    String? newActiveTabId = state.activeTabId;

    if (id == state.activeTabId) {
      newActiveTabId = updatedTabs.isNotEmpty ? updatedTabs.last.id : null;
    }

    emit(state.copyWith(
      tabs: updatedTabs,
      activeTabId: newActiveTabId,
    ));

    if (updatedTabs.isEmpty) {
      addNewTab('https://www.google.com');
    }
  }

  void switchToTab(String id) {
    emit(state.copyWith(activeTabId: id));
  }

  void updateTabUrl(String id, String url, String title, {String? faviconUrl}) {
    final updatedTabs = state.tabs.map((tab) {
      if (tab.id == id) {
        return tab.copyWith(
          currentUrl: url,
          title: title,
          faviconUrl: faviconUrl,
        );
      }
      return tab;
    }).toList();

    emit(state.copyWith(tabs: updatedTabs));
  }

  void updateProgress(String id, double progress) {
    final updatedTabs = state.tabs.map((tab) {
      if (tab.id == id) {
        return tab.copyWith(loadingProgress: progress);
      }
      return tab;
    }).toList();

    emit(state.copyWith(tabs: updatedTabs));
  }

  void reloadTab(String id) {
    final updatedTabs = state.tabs.map((tab) {
      if (tab.id == id) {
        return tab.copyWith(lastReload: DateTime.now());
      }
      return tab;
    }).toList();

    emit(state.copyWith(tabs: updatedTabs));
  }
}
