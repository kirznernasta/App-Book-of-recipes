import '../models/recipe.dart';
import '../services/firebase/database_provider.dart';
import 'base_repository.dart';

class RecipeRepository implements BaseRepository<Recipe> {
  final DatabaseProvider _databaseProvider;

  RecipeRepository({required DatabaseProvider databaseProvider})
      : _databaseProvider = databaseProvider;

  Stream<List<Recipe>> get recipesStream {
    return _databaseProvider.itemsStream(Recipe.folder).map((recipe) {
      final snapshot = recipe.snapshot;
      return snapshot.children
          .map((recipe) => Recipe.fromDatabaseMap(
              Map<String, dynamic>.from(recipe.value as Map)))
          .toList();
    });
  }

  @override
  Future<String?> add(Recipe recipe) {
    return _databaseProvider.insert(
      folderName: Recipe.folder,
      item: recipe.toDatabaseMap(),
    );
  }

  @override
  Future<void> delete(String recipeId) {
    return _databaseProvider.delete(
      folderName: Recipe.folder,
      id: recipeId,
    );
  }

  Future<Recipe?> receiveById(String recipeId) async {
    final snapshot = await _databaseProvider.queryById(
      folderName: Recipe.folder,
      id: recipeId,
    );
    if (snapshot.exists) {
      return Recipe.fromDatabaseMap(
          Map<String, dynamic>.from(snapshot.value as Map));
    }
    return null;
  }

  @override
  Future<List<Recipe>> receiveAll() async {
    final snapshot = await _databaseProvider.queryAll(Recipe.folder);
    if (snapshot.exists) {
      return snapshot.children
          .map((recipe) => Recipe.fromDatabaseMap(
              Map<String, dynamic>.from(recipe.value as Map)))
          .toList();
    } else {
      return [];
    }
  }

  Future<List<Recipe>> receiveAllPublished() async {
    final snapshot = await _databaseProvider.queryAll(Recipe.folder);
    if (snapshot.exists) {
      return snapshot.children
          .map((recipe) => Recipe.fromDatabaseMap(
              Map<String, dynamic>.from(recipe.value as Map)))
          .toList()
        ..where((recipe) => recipe.isPublished);
    } else {
      return [];
    }
  }

  Future<List<Recipe>> receiveAllUserRecipes(String username) async {
    final snapshot = await _databaseProvider.queryAll(Recipe.folder);
    if (snapshot.exists) {
      return snapshot.children
          .map((recipe) => Recipe.fromDatabaseMap(
              Map<String, dynamic>.from(recipe.value as Map)))
          .toList()
        ..where((recipe) => recipe.author == username);
    } else {
      return [];
    }
  }

  @override
  Future<void> update(Recipe recipe) {
    return _databaseProvider.update(
      folderName: Recipe.folder,
      item: recipe.toDatabaseMap(),
    );
  }
}
