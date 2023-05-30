import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/recipe.dart';
import '../../../repositories/recipe_repository.dart';

part 'published_recipes_state.dart';

class PublishedRecipesCubit extends Cubit<PublishedRecipesState> {
  final RecipeRepository _recipeRepository;
  late final StreamSubscription<List<Recipe>> _recipeSubscription;

  PublishedRecipesCubit({required RecipeRepository recipeRepository})
      : _recipeRepository = recipeRepository,
        super(PublishedRecipesState()) {
    _initSubscription();
  }

  void _initSubscription() {
    _recipeSubscription = _recipeRepository.recipesStream.listen(
      (recipes) {
        final publishedRecipes = List<Recipe>.from(
          recipes.where(
            (recipe) => recipe.isPublished,
          ),
        )..sort(
            (recipe1, recipe2) => recipe1.date.compareTo(
              recipe2.date,
            ),
          );
        emit(
          state.copyWith(
            newRecipes: publishedRecipes,
          ),
        );
      },
    );
  }

  Future<void> deleteRecipe(Recipe recipe) async {
    await _recipeRepository.delete(recipe.id);
  }

  void requestChanged(String value) => emit(
        state.copyWith(
          newRequest: value,
        ),
      );
}
