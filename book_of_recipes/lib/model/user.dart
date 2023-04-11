import 'recipe.dart';

class User {
  final String id;
  final String name;
  final String email;
  final String password;
  // or just in firebase ?
  final List<Recipe> favouriteRecipes;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.favouriteRecipes,
  });
}
