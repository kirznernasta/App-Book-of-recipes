import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/recipe.dart';
import '../../../models/user.dart';
import '../../../repositories/recipe_repository.dart';
import '../../../repositories/user_repository.dart';

part 'favourite_state.dart';

class FavouriteCubit extends Cubit<FavouriteState> {
  final UserRepository _userRepository;
  final RecipeRepository _recipeRepository;
  late final StreamSubscription<User?> _streamSubscription;

  FavouriteCubit(
      {required UserRepository userRepository,
      required RecipeRepository recipeRepository})
      : _userRepository = userRepository,
        _recipeRepository = recipeRepository,
        super(FavouriteState());

  void init(String userId) {
    _initSubscription(userId);
  }

  void _initSubscription(String userId) {
    if (!state.isInitialized) {
      _streamSubscription = _userRepository.userStream(userId).listen(
        (user) async {
          if (user != null) {
            final favouritesIds = user.favouriteRecipeIds;
            var recipes = <Recipe>[];

            for (final id in favouritesIds) {
              final recipe = await _recipeRepository.receiveById(id);
              if (recipe != null) {
                recipes.add(recipe);
              }
            }
            emit(
              state.copyWith(
                newFavourites: recipes,
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
