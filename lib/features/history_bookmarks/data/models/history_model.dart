import 'package:isar/isar.dart';

part 'history_model.g.dart';

@collection
class History {
  Id id = Isar.autoIncrement;

  late String title;

  @Index()
  late String url;

  @Index()
  late DateTime visitedAt;

  String? faviconUrl;
}
