import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isar/isar.dart';
import '../../data/models/search_engine_model.dart';
import '../../../../core/database/database_service.dart';

class SearchEngineState {
  final List<SearchEngine> engines;
  final SearchEngine? defaultEngine;

  SearchEngineState({this.engines = const [], this.defaultEngine});

  SearchEngineState copyWith({
    List<SearchEngine>? engines,
    SearchEngine? defaultEngine,
  }) {
    return SearchEngineState(
      engines: engines ?? this.engines,
      defaultEngine: defaultEngine ?? this.defaultEngine,
    );
  }
}

class SearchEngineCubit extends Cubit<SearchEngineState> {
  final Isar _isar = DatabaseService().isar;

  SearchEngineCubit() : super(SearchEngineState());

  Future<void> loadEngines() async {
    final engines = await _isar.searchEngines.where().findAll();
    
    if (engines.isEmpty) {
      await _seedDefaultEngines();
      return loadEngines();
    }

    final defaultEngine = engines.firstWhere((e) => e.isDefault, orElse: () => engines.first);
    emit(state.copyWith(engines: engines, defaultEngine: defaultEngine));
  }

  Future<void> _seedDefaultEngines() async {
    await _isar.writeTxn(() async {
      await _isar.searchEngines.putAll([
        SearchEngine()
          ..engineName = 'Google'
          ..searchUrlPattern = 'https://www.google.com/search?q='
          ..isDefault = true,
        SearchEngine()
          ..engineName = 'DuckDuckGo'
          ..searchUrlPattern = 'https://duckduckgo.com/?q='
          ..isDefault = false,
        SearchEngine()
          ..engineName = 'Brave'
          ..searchUrlPattern = 'https://search.brave.com/search?q='
          ..isDefault = false,
      ]);
    });
  }

  Future<void> setDefaultEngine(int id) async {
    await _isar.writeTxn(() async {
      final all = await _isar.searchEngines.where().findAll();
      for (final engine in all) {
        engine.isDefault = engine.id == id;
        await _isar.searchEngines.put(engine);
      }
    });
    await loadEngines();
  }

  Future<void> addCustomEngine(String name, String pattern) async {
    final engine = SearchEngine()
      ..engineName = name
      ..searchUrlPattern = pattern
      ..isDefault = false;
    
    await _isar.writeTxn(() async {
      await _isar.searchEngines.put(engine);
    });
    await loadEngines();
  }
}
