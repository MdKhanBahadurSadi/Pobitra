import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../data/datasources/cloud_sync_service.dart';
import 'package:pobitra_browser/core/database/database_service.dart';
import '../../data/models/bookmark_model.dart';
import '../../data/models/history_model.dart';
import 'package:isar/isar.dart';
import 'dart:developer';

enum SyncStatus { initial, syncing, success, failure }

class SyncState {
  final SyncStatus status;
  final String? errorMessage;

  SyncState({
    this.status = SyncStatus.initial,
    this.errorMessage,
  });

  SyncState copyWith({
    SyncStatus? status,
    String? errorMessage,
  }) {
    return SyncState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

class SyncCubit extends Cubit<SyncState> {
  final CloudSyncService _cloudSyncService;
  final DatabaseService _databaseService;
  
  StreamSubscription? _bookmarkSubscription;
  StreamSubscription? _historySubscription;

  SyncCubit(this._cloudSyncService, this._databaseService) : super(SyncState());

  /// Starts listening to remote changes and merges them into the local database.
  void startSync() {
    emit(state.copyWith(status: SyncStatus.syncing));

    // Listen to remote Bookmarks
    _bookmarkSubscription = _cloudSyncService.listenToChanges('bookmarks').listen(
      (snapshot) async {
        await _mergeRemoteBookmarks(snapshot.docs);
      },
      onError: (error) {
        log('Remote bookmarks sync error: $error');
      },
    );

    // Listen to remote History
    _historySubscription = _cloudSyncService.listenToChanges('history').listen(
      (snapshot) async {
        await _mergeRemoteHistory(snapshot.docs);
      },
      onError: (error) {
        log('Remote history sync error: $error');
      },
    );

    emit(state.copyWith(status: SyncStatus.success));
  }

  Future<void> _mergeRemoteBookmarks(List<QueryDocumentSnapshot> docs) async {
    final isar = _databaseService.isar;
    await isar.writeTxn(() async {
      for (var doc in docs) {
        final data = doc.data() as Map<String, dynamic>;
        final bookmark = Bookmark()
          ..id = int.parse(doc.id)
          ..title = data['title']
          ..url = data['url']
          ..parentFolder = data['parentFolder']
          ..createdAt = (data['createdAt'] as Timestamp).toDate();
        
        await isar.bookmarks.put(bookmark);
      }
    });
  }

  Future<void> _mergeRemoteHistory(List<QueryDocumentSnapshot> docs) async {
    final isar = _databaseService.isar;
    await isar.writeTxn(() async {
      for (var doc in docs) {
        final data = doc.data() as Map<String, dynamic>;
        final history = History()
          ..id = int.parse(doc.id)
          ..title = data['title']
          ..url = data['url']
          ..visitedAt = (data['visitedAt'] as Timestamp).toDate()
          ..faviconUrl = data['faviconUrl'];
        
        await isar.historys.put(history);
      }
    });
  }

  /// Pushes a local bookmark to the cloud.
  Future<void> pushBookmark(Bookmark bookmark) async {
    try {
      await _cloudSyncService.syncItem('bookmarks', bookmark.id.toString(), {
        'title': bookmark.title,
        'url': bookmark.url,
        'parentFolder': bookmark.parentFolder,
        'createdAt': Timestamp.fromDate(bookmark.createdAt),
      });
    } catch (e) {
      log('Failed to push bookmark: $e');
    }
  }

  /// Pushes a local history item to the cloud.
  Future<void> pushHistory(History history) async {
    try {
      await _cloudSyncService.syncItem('history', history.id.toString(), {
        'title': history.title,
        'url': history.url,
        'visitedAt': Timestamp.fromDate(history.visitedAt),
        'faviconUrl': history.faviconUrl,
      });
    } catch (e) {
      log('Failed to push history: $e');
    }
  }

  @override
  Future<void> close() {
    _bookmarkSubscription?.cancel();
    _historySubscription?.cancel();
    return super.close();
  }
}
