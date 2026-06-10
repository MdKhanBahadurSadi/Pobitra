import 'package:isar/isar.dart';

part 'search_engine_model.g.dart';

@collection
class SearchEngine {
  Id id = Isar.autoIncrement;

  @Index(unique: true)
  late String engineName;

  late String searchUrlPattern;

  late bool isDefault;

  String? iconUrl;
}
