import 'dart:io';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:developer';

class DownloadManager {
  static final DownloadManager _instance = DownloadManager._internal();
  factory DownloadManager() => _instance;
  DownloadManager._internal();

  Future<void> init() async {
    // Already initialized in main.dart, but good to have a placeholder for service-specific setup
  }

  Future<String?> startDownload(String url, String fileName) async {
    try {
      if (Platform.isAndroid) {
        final status = await Permission.storage.request();
        if (!status.isGranted) {
          log('Storage permission denied');
          return null;
        }
      }

      final directory = Platform.isAndroid
          ? await getExternalStorageDirectory()
          : await getApplicationDocumentsDirectory();

      if (directory == null) return null;

      final taskId = await FlutterDownloader.enqueue(
        url: url,
        savedDir: directory.path,
        fileName: fileName,
        showNotification: true,
        openFileFromNotification: true,
        saveInPublicStorage: true,
      );

      return taskId;
    } catch (e) {
      log('Download error: $e');
      return null;
    }
  }

  Future<void> retryDownload(String taskId) async {
    try {
      await FlutterDownloader.retry(taskId: taskId);
    } catch (e) {
      log('Retry error: $e');
    }
  }

  // Implementation of exponential backoff would typically happen in a background 
  // isolate or a recurring task that checks failed downloads.
}
