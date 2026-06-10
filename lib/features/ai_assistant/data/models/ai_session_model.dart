import 'package:isar/isar.dart';

part 'ai_session_model.g.dart';

@collection
class AiSession {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String tabUrl;

  late String pageTextContext;

  late List<String> conversationHistoryJson;

  late DateTime lastAccessed;
}
