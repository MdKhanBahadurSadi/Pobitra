import 'package:firebase_auth/firebase_auth.dart';
import 'dart:developer';

class AuthService {
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? get currentUser => _auth.currentUser;

  /// Initializes authentication by signing in anonymously if no user is present.
  Future<void> init() async {
    if (_auth.currentUser == null) {
      try {
        await _auth.signInAnonymously();
        log('Signed in anonymously with UID: ${_auth.currentUser?.uid}');
      } catch (e) {
        log('Failed to sign in anonymously: $e');
      }
    }
  }

  /// Checks if the user is authenticated.
  bool isAuthenticated() {
    return _auth.currentUser != null;
  }

  /// Stream of authentication state changes.
  Stream<User?> get authStateChanges => _auth.authStateChanges();
}
