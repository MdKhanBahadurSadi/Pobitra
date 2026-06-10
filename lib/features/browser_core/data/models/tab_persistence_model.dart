import 'package:isar/isar.dart';

part 'tab_persistence_model.g.dart';

@collection
class TabPersistence {
  Id id = Isar.autoIncrement;

  late String tabId;
  late String currentUrl;
  late String title;
  String? faviconUrl;
  late bool isIncognito;
  late int position;
  late bool isActive;
}
