part of 'shopping_list_cubit.dart';

class ShoppingListState {
  final List<Product> shoppingProducts;

  ShoppingListState({
    this.shoppingProducts = const [],
  });

  ShoppingListState copyWith({
    List<Product>? newShoppingProducts,
  }) =>
      ShoppingListState(
        shoppingProducts: newShoppingProducts ?? shoppingProducts,
      );
}
