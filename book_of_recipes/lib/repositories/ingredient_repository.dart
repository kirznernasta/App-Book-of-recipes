import '../models/ingredient.dart';
import '../services/firebase/database_provider.dart';
import 'base_repository.dart';

class IngredientRepository implements BaseRepository<Ingredient> {
  final DatabaseProvider _databaseProvider;

  IngredientRepository({required DatabaseProvider databaseProvider})
      : _databaseProvider = databaseProvider;

  Stream<List<Ingredient>> get ingredientStream {
    return _databaseProvider.itemsStream(Ingredient.folder).map(
      (ingredient) {
        final snapshot = ingredient.snapshot;
        return snapshot.children
            .map((ingredient) => Ingredient.fromDatabaseMap(
                Map<String, dynamic>.from(ingredient.value as Map)))
            .toList();
      },
    );
  }

  @override
  Future<void> add(Ingredient ingredient) {
    return _databaseProvider.insert(
      folderName: Ingredient.folder,
      item: ingredient.toDatabaseMap(),
    );
  }

  @override
  Future<void> delete(String ingredientId) {
    return _databaseProvider.delete(
      folderName: Ingredient.folder,
      id: ingredientId,
    );
  }

  @override
  Future<List<Ingredient>> receiveAll() async {
    final snapshot = await _databaseProvider.queryAll(Ingredient.folder);
    if (snapshot.exists) {
      return snapshot.children
          .map((ingredient) => Ingredient.fromDatabaseMap(
              Map<String, dynamic>.from(ingredient.value as Map)))
          .toList();
    } else {
      return [];
    }
  }

  Future<List<Ingredient>> receiveAllFromRecipe(String recipeId) async {
    final snapshot = await _databaseProvider.queryAll(Ingredient.folder);
    if (snapshot.exists) {
      return snapshot.children
          .map((ingredient) => Ingredient.fromDatabaseMap(
              Map<String, dynamic>.from(ingredient.value as Map)))
          .toList()
        ..where((ingredient) => ingredient.recipeId == recipeId);
    } else {
      return [];
    }
  }

  @override
  Future<void> update(Ingredient ingredient) {
    return _databaseProvider.update(
      folderName: Ingredient.folder,
      item: ingredient.toDatabaseMap(),
    );
  }
}
