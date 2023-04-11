import 'comment.dart';
import 'ingredient.dart';
import 'step.dart';

class Recipe {
  final String id;
  final String title;
  final String description;
  // or just in firebase?
  final List<Ingredient> ingredients;
  // or just in firebase?
  final List<Step> steps;
  final Duration time;
  final String photoResult;
  final double averageRating;
  final int numberOfServing;
  // or just in firebase?
  final List<Comment> comments;
  final String author;

  Recipe({
    required this.id,
    required this.title,
    required this.description,
    required this.ingredients,
    required this.steps,
    required this.time,
    required this.photoResult,
    required this.averageRating,
    required this.numberOfServing,
    required this.comments,
    required this.author,
  });
}
