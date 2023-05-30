import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/recipe.dart';
import '../../../models/user.dart';
import '../../../repositories/recipe_repository.dart';
import '../../../repositories/user_repository.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final UserRepository _userRepository;
  final RecipeRepository _recipeRepository;
  late final StreamSubscription<List<Recipe>> _recipeSubscription;
  late final StreamSubscription<User?> _streamSubscription;

  HomeCubit({
    required UserRepository userRepository,
    required RecipeRepository recipeRepository,
  })  : _userRepository = userRepository,
        _recipeRepository = recipeRepository,
        super(HomeState()) {
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

  void init(String userId) {
    _initUserSubscription(userId);
  }

  void requestChanged(String value) => emit(
        state.copyWith(
          newRequest: value,
        ),
      );

  void setFavorites(User user) => emit(
        state.copyWith(
          newFavoriteIds: user.favouriteRecipeIds,
        ),
      );

  Future<void> toggleFavorite(User user, String recipeId) async {
    final favorites = user.favouriteRecipeIds;
    late final List<String> newFavorites;
    if (favorites.contains(recipeId)) {
      newFavorites = List<String>.from(favorites..remove(recipeId));
      await _userRepository.update(
        user.copyWith(
          newFavouriteRecipeIds: newFavorites,
        ),
      );
    } else {
      newFavorites = List<String>.from(favorites..add(recipeId));
      await _userRepository.update(
        user.copyWith(
          newFavouriteRecipeIds: newFavorites,
        ),
      );
    }
  }

  void _initUserSubscription(String userId) {
    if (!state.isInitialized) {
      _streamSubscription = _userRepository.userStream(userId).listen(
        (user) async {
          if (user != null) {
            final favouritesIds = user.favouriteRecipeIds;

            emit(
              state.copyWith(
                newFavoriteIds: favouritesIds,
              ),
            );
          }
        },
      );
      emit(
        state.copyWith(
          initialized: true,
        ),
      );
    }
  }
}
