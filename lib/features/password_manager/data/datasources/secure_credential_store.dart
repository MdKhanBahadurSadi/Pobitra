import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../models/credential_model.dart';

class SecureCredentialStore {
  final FlutterSecureStorage _storage = const FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );

  /// Saves the credential encrypted. 
  /// Key format: [domain]_[username]
  Future<void> saveCredential(String domain, String username, String password) async {
    final credential = CredentialModel(
      domain: domain,
      username: username,
      password: password,
      createdAt: DateTime.now(),
    );
    
    final key = '${domain}_$username';
    await _storage.write(key: key, value: jsonEncode(credential.toJson()));
  }

  /// Returns all credentials for a specific domain.
  Future<List<CredentialModel>> getCredentialsForDomain(String domain) async {
    final allKeys = await _storage.readAll();
    final List<CredentialModel> results = [];
    
    allKeys.forEach((key, value) {
      if (key.startsWith('${domain}_')) {
        results.add(CredentialModel.fromJson(jsonDecode(value)));
      }
    });
    
    return results;
  }

  /// Deletes a specific credential.
  Future<void> deleteCredential(String domain, String username) async {
    final key = '${domain}_$username';
    await _storage.delete(key: key);
  }

  /// Returns all stored credentials.
  Future<List<CredentialModel>> getAllCredentials() async {
    final allValues = await _storage.readAll();
    return allValues.values
        .map((v) => CredentialModel.fromJson(jsonDecode(v)))
        .toList();
  }
}
