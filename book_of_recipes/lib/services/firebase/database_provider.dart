import 'dart:io';

import 'package:firebase_database/firebase_database.dart';

import '../../models/base_model.dart';
import 'authentication.dart';
import 'storage_provider.dart';

class DatabaseProvider {
  final DatabaseReference _databaseReference;
  final StorageProvider _storageProvider;
  final Authentication authentication;

  DatabaseProvider({
    required this.authentication,
    required StorageProvider storageProvider,
  })  : _databaseReference = FirebaseDatabase.instance.ref(),
        _storageProvider = storageProvider;

  Stream<DatabaseEvent> itemsStream(String folderName) =>
      _databaseReference.child(folderName).onValue;

  Stream<DatabaseEvent> itemStream({
    required String folderName,
    required String id,
  }) =>
      _databaseReference.child('$folderName/$id').onValue;

  Future<DataSnapshot> queryAll(String folderName) {
    final itemsReference = _databaseReference.child(folderName);
    return itemsReference.get();
  }

  Future<DataSnapshot> queryById({
    required String folderName,
    required String id,
  }) {
    final itemReference = _databaseReference.child('$folderName/$id');
    return itemReference.get();
  }

  Future<String?> insert({
    required String folderName,
    required Map<String, dynamic> item,
  }) async {
    final folderReference = _databaseReference.child(folderName);
    if (item.containsKey('image')) {
      if (item['image'] != '') {
        final url = await _storageProvider.saveImage(
          file: File(item['image']),
          folderName: folderName,
          id: item[BaseModel.idKey],
        );
        item['image'] = url;
      }
    }
    late final DatabaseReference itemReference;
    if (item['id'] == '') {
      itemReference = folderReference.push();
      item[BaseModel.idKey] = itemReference.key;
    } else {
      itemReference = folderReference.child(item['id']);
    }

    await itemReference.set(item);
    return itemReference.key;
  }

  Future<void> update({
    required String folderName,
    required Map<String, dynamic> item,
  }) async {
    if (item.containsKey('image')) {
      final itemNewImage = item['image'] as String;
      if (!itemNewImage.startsWith('https://firebasestorage.googleapis.com')) {
        final newImageUrl = await _storageProvider.updateImage(
          folderName: folderName,
          file: File(itemNewImage),
          id: item[BaseModel.idKey],
        );
        item['image'] = newImageUrl;
      }
    }
    final itemReference =
        _databaseReference.child('$folderName/${item[BaseModel.idKey]}');
    return itemReference.update(item);
  }

  Future<void> delete({
    required String folderName,
    required String id,
  }) {
    final itemReference = _databaseReference.child('$folderName/$id');
    //delete all connections
    return itemReference.remove();
  }
}
