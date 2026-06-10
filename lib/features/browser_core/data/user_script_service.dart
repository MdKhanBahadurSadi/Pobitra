import 'package:isar/isar.dart';
import '../../../core/database/database_service.dart';
import 'models/user_script_model.dart';

class UserScriptService {
  final Isar _isar = DatabaseService().isar;

  Future<List<UserScript>> getAllScripts() async {
    return await _isar.userScripts.where().findAll();
  }

  Future<List<UserScript>> getActiveScriptsForUrl(String url) async {
    final allActive = await _isar.userScripts.filter().isEnabledEqualTo(true).findAll();
    
    // Simple pattern matching for now
    return allActive.where((script) {
      if (script.urlPattern == null || script.urlPattern!.isEmpty || script.urlPattern == '*') {
        return true;
      }
      final pattern = script.urlPattern!.replaceAll('*', '.*');
      return RegExp(pattern).hasMatch(url);
    }).toList();
  }

  Future<void> addScript(String name, String source, {String? urlPattern}) async {
    final script = UserScript()
      ..name = name
      ..source = source
      ..isEnabled = true
      ..urlPattern = urlPattern
      ..createdAt = DateTime.now();

    await _isar.writeTxn(() async {
      await _isar.userScripts.put(script);
    });
  }

  Future<void> toggleScript(int id, bool enabled) async {
    final script = await _isar.userScripts.get(id);
    if (script != null) {
      script.isEnabled = enabled;
      await _isar.writeTxn(() async {
        await _isar.userScripts.put(script);
      });
    }
  }

  Future<void> deleteScript(int id) async {
    await _isar.writeTxn(() async {
      await _isar.userScripts.delete(id);
    });
  }
}
