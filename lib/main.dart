import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'app.dart';
import 'core/database/database_service.dart';
import 'features/ad_blocker/data/ad_blocker_service.dart';

void main() async {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();

    // Initialize Database
    try {
      await DatabaseService().init();
      log('Database initialized successfully');
    } catch (e) {
      log('Failed to initialize database: $e');
    }

    // Initialize AdBlocker
    try {
      await AdBlockerService().loadBlocklist();
      log('AdBlocker blocklist loaded');
    } catch (e) {
      log('Failed to load AdBlocker blocklist: $e');
    }

    // Initialize Downloader
    try {
      await FlutterDownloader.initialize(debug: true, ignoreSsl: true);
      log('FlutterDownloader initialized');
    } catch (e) {
      log('Failed to initialize FlutterDownloader: $e');
    }

    runApp(const PobitraApp());
  }, (error, stack) {
    log('Uncaught error: $error', stackTrace: stack);
  });
}
