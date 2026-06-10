// Manual Command to generate Isar schemas:
// flutter pub run build_runner build --delete-conflicting-outputs

import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import '../../features/history_bookmarks/data/models/bookmark_model.dart';
import '../../features/history_bookmarks/data/models/history_model.dart';
import '../../features/ai_assistant/data/models/ai_session_model.dart';
import '../../features/browser_core/data/models/tab_persistence_model.dart';
import '../../features/browser_core/data/models/user_script_model.dart';
import '../../features/browser_core/data/models/search_engine_model.dart';

class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();
  factory DatabaseService() => _instance;
  DatabaseService._internal();

  late Isar _isar;

  Isar get isar => _isar;

  /// Initializes the Isar database with all required schemas.
  Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();
    
    _isar = await Isar.open(
      [
        BookmarkSchema,
        HistorySchema,
        AiSessionSchema,
        TabPersistenceSchema,
        UserScriptSchema,
        SearchEngineSchema,
      ],
      directory: dir.path,
      inspector: true, // Enable Isar Inspector for debugging in dev
    );
  }

  /// Closes the Isar instance.
  Future<void> close() async {
    await _isar.close();
  }
}
