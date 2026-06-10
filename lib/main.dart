import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:firebase_core/firebase_core.dart';
import 'app.dart';
import 'core/database/database_service.dart';
import 'core/security/auth_service.dart';
import 'core/security/telemetry_guard.dart';
import 'features/ad_blocker/data/ad_blocker_service.dart';

void main() async {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();

    // Initialize Firebase
    try {
      await Firebase.initializeApp();
      await AuthService().init();
      logger.log('Firebase initialized successfully');
    } catch (e) {
      logger.log('Failed to initialize Firebase: $e');
    }

    // Initialize Database
    try {
      await DatabaseService().init();
      logger.log('Database initialized successfully');
    } catch (e) {
      logger.log('Failed to initialize database: $e');
    }

    // Initialize AdBlocker
    try {
      await AdBlockerService().loadBlocklist();
      logger.log('AdBlocker blocklist loaded');
    } catch (e) {
      logger.log('Failed to load AdBlocker blocklist: $e');
    }

    // Initialize Downloader
    try {
      await FlutterDownloader.initialize(debug: true, ignoreSsl: true);
      logger.log('FlutterDownloader initialized');
    } catch (e) {
      logger.log('Failed to initialize FlutterDownloader: $e');
    }

    runApp(const PobitraApp());
  }, (error, stack) {
    logger.log('Uncaught error: $error', error: error, stackTrace: stack);
  });
}
