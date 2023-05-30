part of 'home_cubit.dart';

class HomeState {
  final List<Recipe> _recipes;
  final String request;
  final List<String> favoriteIds;
  final bool isInitialized;

  HomeState({
    List<Recipe> recipes = const [],
    this.request = '',
    this.favoriteIds = const [],
    this.isInitialized = false,
  }) : _recipes = recipes;

  List<Recipe> get recipes => List<Recipe>.from(
        _recipes.where(
          (recipe) => recipe.name.toLowerCase().contains(request.toLowerCase()),
        ),
      );

  bool isFavoriteRecipe(String recipeId) => favoriteIds.contains(recipeId);

  HomeState copyWith({
    List<Recipe>? newRecipes,
    String? newRequest,
    List<String>? newFavoriteIds,
    bool? initialized,
  }) =>
      HomeState(
        recipes: newRecipes ?? _recipes,
        request: newRequest ?? request,
        favoriteIds: newFavoriteIds ?? favoriteIds,
        isInitialized: initialized ?? isInitialized,
      );
}
