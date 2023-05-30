import '../models/user.dart';
import '../services/firebase/database_provider.dart';
import 'base_repository.dart';

class UserRepository implements BaseRepository<User> {
  final DatabaseProvider _databaseProvider;

  UserRepository({required DatabaseProvider databaseProvider})
      : _databaseProvider = databaseProvider;

  Stream<User?> userStream(String userId) {
    return _databaseProvider
        .itemStream(folderName: User.folder, id: userId)
        .map((user) {
      final snapshot = user.snapshot;
      return User.fromDatabaseMap(
          Map<String, dynamic>.from(snapshot.value as Map));
    });
  }

  @override
  Future<void> add(User user) {
    return _databaseProvider.insert(
      folderName: User.folder,
      item: user.toDatabaseMap(),
    );
  }

  @override
  Future<void> delete(String userId) {
    return _databaseProvider.delete(
      folderName: User.folder,
      id: userId,
    );
  }

  @override
  Future<List<User>> receiveAll() async {
    final snapshot = await _databaseProvider.queryAll(User.folder);
    if (snapshot.exists) {
      return snapshot.children
          .map((user) => User.fromDatabaseMap(
              Map<String, dynamic>.from(user.value as Map)))
          .toList();
    } else {
      return [];
    }
  }

  Future<User?> receiveUserById(String userId) async {
    final snapshot = await _databaseProvider.queryById(
      folderName: User.folder,
      id: userId,
    );
    if (snapshot.exists) {
      return User.fromDatabaseMap(
        Map<String, dynamic>.from(snapshot.value as Map),
      );
    } else {
      return null;
    }
  }

  // TODO: remove method, replace with contains
  Future<List<User>> receiveAllWhereNameStarts(String name) async {
    final snapshot = await _databaseProvider.queryAll(User.folder);
    if (snapshot.exists) {
      return snapshot.children
          .map((user) => User.fromDatabaseMap(
              Map<String, dynamic>.from(user.value as Map)))
          .toList()
        ..where((user) => user.name.startsWith(name[0]));
    } else {
      return [];
    }
  }

  @override
  Future<void> update(User user) {
    return _databaseProvider.update(
      folderName: User.folder,
      item: user.toDatabaseMap(),
    );
  }
}
