import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

import '../../models/base_model.dart';

final _users = 'users';
final _recipes = 'recipes';
final _steps = 'steps';
final _products = 'products';

class StorageProvider<T extends BaseModel> {
  final Reference _storageReference;

  StorageProvider() : _storageReference = FirebaseStorage.instance.ref();

  Future<String> saveImage({
    required File file,
    required String folderName,
    required String id,
  }) async {
    final fileName = '${DateTime.now().toString()}.jpg';
    final reference = _storageReference.child('$folderName/$id/$fileName');
    final metadata = SettableMetadata(contentType: 'image/jpeg');
    final uploadTask = reference.putFile(file, metadata);
    final snapshot = await uploadTask.whenComplete(() {});
    return snapshot.ref.getDownloadURL();
  }

  Future<String> updateImage({
    required String folderName,
    required File file,
    required String id,
  }) async {
    final itemReference = _storageReference.child('$folderName/$id');

    final result = await itemReference.listAll();
    for (final ref in result.items) {
      await ref.delete();
    }

    final fileName = '${DateTime.now().toString()}.jpg';
    final reference = itemReference.child(fileName);
    final metadata = SettableMetadata(contentType: 'image/jpeg');

    final uploadTask = reference.putFile(file, metadata);
    final snapshot = await uploadTask.whenComplete(() {});
    return snapshot.ref.getDownloadURL();
  }
}
