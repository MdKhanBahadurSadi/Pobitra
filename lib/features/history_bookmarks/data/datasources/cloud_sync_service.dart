import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:developer';

class CloudSyncService {
  static final CloudSyncService _instance = CloudSyncService._internal();
  factory CloudSyncService() => _instance;
  CloudSyncService._internal();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _appId = 'pobitra-app';

  String? get _userId => FirebaseAuth.instance.currentUser?.uid;

  CollectionReference _getCollection(String collectionName) {
    if (_userId == null) throw Exception('User not authenticated');
    
    return _firestore
        .collection('artifacts')
        .doc(_appId)
        .collection('users')
        .doc(_userId)
        .collection(collectionName);
  }

  /// Syncs a single item to Firestore.
  Future<void> syncItem(String collectionName, String id, Map<String, dynamic> data) async {
    try {
      await _getCollection(collectionName).doc(id).set(data);
    } catch (e) {
      log('Error syncing item to $collectionName: $e');
      rethrow;
    }
  }

  /// Deletes an item from Firestore.
  Future<void> deleteItem(String collectionName, String id) async {
    try {
      await _getCollection(collectionName).doc(id).delete();
    } catch (e) {
      log('Error deleting item from $collectionName: $e');
      rethrow;
    }
  }

  /// Listens to remote changes in a collection.
  Stream<QuerySnapshot> listenToChanges(String collectionName) {
    try {
      return _getCollection(collectionName).snapshots();
    } catch (e) {
      log('Error listening to $collectionName: $e');
      return const Stream.empty();
    }
  }
}
