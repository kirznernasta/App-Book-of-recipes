part of 'ingredient_managing_cubit.dart';

class IngredientManagingState {
  final String productName;
  final String productImage;
  final double amount;
  final String selectedUnit;
  final List<Unit> units;
  final List<String> existingProductNames;

  IngredientManagingState({
    this.productName = '',
    this.productImage = '',
    this.amount = 0,
    this.selectedUnit = 'g',
    this.units = const [],
    this.existingProductNames = const [],
  });

  bool get isCanApply => productName != '' && productImage != '' && amount != 0;

  bool get isIngredientAlreadyExist =>
      existingProductNames.contains(productName);

  IngredientManagingState copyWith({
    String? newProductName,
    String? newProductImage,
    double? newAmount,
    String? newSelectedUnit,
    List<Unit>? newUnits,
    List<String>? newExistingProductNames,
  }) =>
      IngredientManagingState(
        productName: newProductName ?? productName,
        productImage: newProductImage ?? productImage,
        amount: newAmount ?? amount,
        selectedUnit: newSelectedUnit ?? selectedUnit,
        units: newUnits ?? units,
        existingProductNames: newExistingProductNames ?? existingProductNames,
      );
}
