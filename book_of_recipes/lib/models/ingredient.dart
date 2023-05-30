import 'base_model.dart';

class Ingredient extends BaseModel {
  final String productName;
  final String productImage;
  final double amount;
  final String unitName;
  final String recipeId;

  static const productNameKey = 'product_name';
  static const productImageKey = 'product_image';
  static const amountKey = 'amount';
  static const unitNameKey = 'unit_name';
  static const recipeIdKey = 'recipe_id';

  static const folder = 'ingredients';

  Ingredient({
    required String id,
    required this.productName,
    required this.productImage,
    required this.amount,
    required this.unitName,
    required this.recipeId,
  }) : super(id: id, folderName: folder);

  factory Ingredient.fromDatabaseMap(Map<String, dynamic> map) => Ingredient(
        id: map[BaseModel.idKey],
        productName: map[productNameKey],
        productImage: map[productImageKey],
        amount: double.parse(map[amountKey].toString()),
        unitName: map[unitNameKey],
        recipeId: map[recipeIdKey],
      );

  Map<String, dynamic> toDatabaseMap() => {
        BaseModel.idKey: id,
        productNameKey: productName,
        productImageKey: productImage,
        amountKey: amount,
        unitNameKey: unitName,
        recipeIdKey: recipeId,
      };

  Ingredient copyWith({
    String? newId,
    String? newProductName,
    String? newProductImage,
    double? newAmount,
    String? newUnitName,
    String? newRecipeId,
  }) =>
      Ingredient(
        id: newId ?? id,
        productName: newProductName ?? productName,
        productImage: newProductImage ?? productImage,
        amount: newAmount ?? amount,
        unitName: newUnitName ?? unitName,
        recipeId: newRecipeId ?? recipeId,
      );
}
