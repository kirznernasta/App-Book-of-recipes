import 'base_model.dart';

class Step extends BaseModel {
  final int number;
  final String description;
  final String image;
  final String recipeId;

  static const numberKey = 'number';
  static const descriptionKey = 'description';
  static const imageKey = 'image';
  static const recipeIdKey = 'recipe_id';

  static const folder = 'steps';

  Step({
    required String id,
    required this.number,
    required this.description,
    required this.image,
    required this.recipeId,
  }) : super(id: id, folderName: folder);

  factory Step.fromDatabaseMap(Map<String, dynamic> map) => Step(
        id: map[BaseModel.idKey],
        number: map[numberKey],
        description: map[descriptionKey],
        image: map[imageKey],
        recipeId: map[recipeIdKey],
      );

  Map<String, dynamic> toDatabaseMap() => {
        BaseModel.idKey: id,
        numberKey: number,
        descriptionKey: description,
        imageKey: image,
        recipeIdKey: recipeId,
      };

  Step copyWith({
    String? newId,
    int? newNumber,
    String? newDescription,
    String? newImage,
    String? newRecipeId,
  }) =>
      Step(
        id: newId ?? id,
        number: newNumber ?? number,
        description: newDescription ?? description,
        image: newImage ?? image,
        recipeId: newRecipeId ?? recipeId,
      );
}
