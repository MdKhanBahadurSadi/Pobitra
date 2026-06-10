import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/tab_model.dart';
import 'package:pobitra_browser/core/database/database_service.dart';
import '../../data/models/tab_persistence_model.dart';
import 'package:isar/isar.dart';

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
  final DatabaseService _db = DatabaseService();

  TabCubit() : super(TabState());

  Future<void> loadSession() async {
    final persistedTabs = await _db.isar.tabPersistences.where().sortByPosition().findAll();
    
    if (persistedTabs.isEmpty) {
      addNewTab('https://www.google.com');
      return;
    }

    final tabs = persistedTabs.map((t) => TabModel(
      id: t.tabId,
      currentUrl: t.currentUrl,
      title: t.title,
      faviconUrl: t.faviconUrl,
      isIncognito: t.isIncognito,
    )).toList();

    final activeTab = persistedTabs.firstWhere((t) => t.isActive, orElse: () => persistedTabs.first);

    emit(TabState(
      tabs: tabs,
      activeTabId: activeTab.tabId,
    ));
  }

  Future<void> _saveSession() async {
    final tabs = state.tabs;
    final activeId = state.activeTabId;

    await _db.isar.writeTxn(() async {
      await _db.isar.tabPersistences.clear();
      for (int i = 0; i < tabs.length; i++) {
        final tab = tabs[i];
        final persistence = TabPersistence()
          ..tabId = tab.id
          ..currentUrl = tab.currentUrl
          ..title = tab.title
          ..faviconUrl = tab.faviconUrl
          ..isIncognito = tab.isIncognito
          ..position = i
          ..isActive = tab.id == activeId;
        await _db.isar.tabPersistences.put(persistence);
      }
    });
  }

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
    _saveSession();
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
    } else {
      _saveSession();
    }
  }

  void switchToTab(String id) {
    emit(state.copyWith(activeTabId: id));
    _saveSession();
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
    _saveSession();
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
