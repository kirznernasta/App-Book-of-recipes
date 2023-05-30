import 'base_model.dart';

class Recipe extends BaseModel {
  final String name;
  final String description;
  final Duration cookingTime;
  final DateTime date;
  final String photoResult;
  final int numberOfServing;
  final String author;
  final bool isPublished;
  final bool isRequested;

  static const nameKey = 'name';
  static const descriptionKey = 'description';
  static const cookingTimeKey = 'cooking_time';
  static const dateKey = 'date';
  static const photoResultKey = 'image';
  static const numberOfServingKey = 'number_of_serving';
  static const authorKey = 'author';
  static const publishedKey = 'is_published';
  static const requestedKey = 'is_requested';

  static const folder = 'recipes';

  Recipe({
    required String id,
    required this.name,
    required this.description,
    required this.cookingTime,
    required this.date,
    required this.photoResult,
    required this.numberOfServing,
    required this.author,
    required this.isPublished,
    required this.isRequested,
  }) : super(id: id, folderName: folder);

  factory Recipe.fromDatabaseMap(Map<String, dynamic> map) => Recipe(
        id: map[BaseModel.idKey],
        name: map[nameKey],
        description: map[descriptionKey],
        cookingTime: Duration(minutes: map[cookingTimeKey]),
        date: DateTime.parse(map[dateKey]),
        photoResult: map[photoResultKey],
        numberOfServing: map[numberOfServingKey],
        author: map[authorKey],
        isPublished: map[publishedKey],
        isRequested: map[requestedKey],
      );

  Map<String, dynamic> toDatabaseMap() => {
        BaseModel.idKey: id,
        nameKey: name,
        descriptionKey: description,
        cookingTimeKey: cookingTime.inMinutes,
        dateKey: date.toString(),
        photoResultKey: photoResult,
        numberOfServingKey: numberOfServing,
        authorKey: author,
        publishedKey: isPublished,
        requestedKey: isRequested,
      };

  Recipe copyWith({
    String? newId,
    String? newTitle,
    String? newDescription,
    Duration? newCookingTime,
    DateTime? newDate,
    String? newPhotoResult,
    int? newNumberOfServing,
    String? newAuthor,
    bool? published,
    bool? requested,
  }) =>
      Recipe(
        id: newId ?? id,
        name: newTitle ?? name,
        description: newDescription ?? description,
        cookingTime: newCookingTime ?? cookingTime,
        date: newDate ?? date,
        photoResult: newPhotoResult ?? photoResult,
        numberOfServing: newNumberOfServing ?? numberOfServing,
        author: newAuthor ?? author,
        isPublished: published ?? isPublished,
        isRequested: requested ?? isRequested,
      );
}
