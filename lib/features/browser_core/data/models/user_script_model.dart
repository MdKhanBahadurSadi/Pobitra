import 'package:isar/isar.dart';

part 'user_script_model.g.dart';

@collection
class UserScript {
  Id id = Isar.autoIncrement;

  late String name;
  late String source;
  late bool isEnabled;
  
  /// URL pattern to match for script injection (e.g. "*google.com*")
  String? urlPattern;

  @Index(type: IndexType.value)
  late DateTime createdAt;
}
