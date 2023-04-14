class Recipe {
  final String id;
  final String title;
  final String description;
  final Duration time;
  final String photoResult;
  final double averageRating;
  final int numberOfServing;
  final String author;

  Recipe({
    required this.id,
    required this.title,
    required this.description,
    required this.time,
    required this.photoResult,
    required this.averageRating,
    required this.numberOfServing,
    required this.author,
  });
}
