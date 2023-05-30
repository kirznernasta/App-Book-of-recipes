part of 'favourite_cubit.dart';

class FavouriteState {
  final List<Recipe> favouriteRecipes;
  final bool isInitialized;

  FavouriteState({
    this.favouriteRecipes = const [],
    this.isInitialized = false,
  });

  FavouriteState copyWith({
    List<Recipe>? newFavourites,
    bool? initialized,
  }) =>
      FavouriteState(
        favouriteRecipes: newFavourites ?? favouriteRecipes,
        isInitialized: initialized ?? isInitialized,
      );
}
