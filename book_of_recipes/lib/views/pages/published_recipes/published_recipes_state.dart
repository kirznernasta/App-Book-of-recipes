part of 'published_recipes_cubit.dart';

class PublishedRecipesState {
  final List<Recipe> _recipes;
  final String request;

  PublishedRecipesState({
    List<Recipe> recipes = const [],
    this.request = '',
  }) : _recipes = recipes;

  List<Recipe> get recipes => List<Recipe>.from(
        _recipes.where(
          (recipe) => recipe.name.toLowerCase().contains(request.toLowerCase()),
        ),
      );

  PublishedRecipesState copyWith({
    List<Recipe>? newRecipes,
    String? newRequest,
  }) =>
      PublishedRecipesState(
        recipes: newRecipes ?? _recipes,
        request: newRequest ?? request,
      );
}
