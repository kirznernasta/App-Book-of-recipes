import '../models/unit.dart';
import '../services/firebase/database_provider.dart';
import 'base_repository.dart';

class UnitRepository implements BaseRepository<Unit> {
  final DatabaseProvider _databaseProvider;

  UnitRepository({required DatabaseProvider databaseProvider})
      : _databaseProvider = databaseProvider;

  Stream<List<Unit>> get unitStream {
    return _databaseProvider.itemsStream(Unit.folder).map(
      (unit) {
        final snapshot = unit.snapshot;
        return snapshot.children
            .map((product) => Unit.fromDatabaseMap(
                Map<String, dynamic>.from(product.value as Map)))
            .toList();
      },
    );
  }

  @override
  Future<void> add(Unit unit) {
    return _databaseProvider.insert(
      folderName: Unit.folder,
      item: unit.toDatabaseMap(),
    );
  }

  @override
  Future<void> delete(String unitId) {
    return _databaseProvider.delete(
      folderName: Unit.folder,
      id: unitId,
    );
  }

  @override
  Future<List<Unit>> receiveAll() async {
    final snapshot = await _databaseProvider.queryAll(Unit.folder);
    if (snapshot.exists) {
      return snapshot.children
          .map((unit) => Unit.fromDatabaseMap(
              Map<String, dynamic>.from(unit.value as Map)))
          .toList();
    } else {
      return [];
    }
  }

  @override
  Future<void> update(Unit unit) {
    return _databaseProvider.update(
      folderName: Unit.folder,
      item: unit.toDatabaseMap(),
    );
  }
}
