import '../models/step.dart';
import '../services/firebase/database_provider.dart';
import 'base_repository.dart';

class StepRepository implements BaseRepository<Step> {
  final DatabaseProvider _databaseProvider;

  StepRepository({required DatabaseProvider databaseProvider})
      : _databaseProvider = databaseProvider;

  Stream<List<Step>> get stepStream {
    return _databaseProvider.itemsStream(Step.folder).map(
      (step) {
        final snapshot = step.snapshot;
        return snapshot.children
            .map((step) => Step.fromDatabaseMap(
                Map<String, dynamic>.from(step.value as Map)))
            .toList();
      },
    );
  }

  @override
  Future<void> add(Step step) {
    return _databaseProvider.insert(
      folderName: Step.folder,
      item: step.toDatabaseMap(),
    );
  }

  @override
  Future<void> delete(String stepId) {
    return _databaseProvider.delete(
      folderName: Step.folder,
      id: stepId,
    );
  }

  @override
  Future<List<Step>> receiveAll() async {
    final snapshot = await _databaseProvider.queryAll(Step.folder);
    if (snapshot.exists) {
      return snapshot.children
          .map((step) => Step.fromDatabaseMap(
              Map<String, dynamic>.from(step.value as Map)))
          .toList();
    } else {
      return [];
    }
  }

  Future<List<Step>> receiveAllRecipeSteps(String recipeId) async {
    final snapshot = await _databaseProvider.queryAll(Step.folder);
    if (snapshot.exists) {
      return snapshot.children
          .map((step) => Step.fromDatabaseMap(
              Map<String, dynamic>.from(step.value as Map)))
          .toList()
        ..where((step) => step.recipeId == recipeId);
    } else {
      return [];
    }
  }

  @override
  Future<void> update(Step step) {
    return _databaseProvider.update(
      folderName: Step.folder,
      item: step.toDatabaseMap(),
    );
  }
}
