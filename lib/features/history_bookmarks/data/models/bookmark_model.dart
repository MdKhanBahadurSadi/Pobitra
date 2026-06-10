import 'package:isar/isar.dart';

part 'bookmark_model.g.dart';

@collection
class Bookmark {
  Id id = Isar.autoIncrement;

  @Index()
  late String title;

  @Index(unique: true, replace: true)
  late String url;

  String? parentFolder;

  late DateTime createdAt;
}
