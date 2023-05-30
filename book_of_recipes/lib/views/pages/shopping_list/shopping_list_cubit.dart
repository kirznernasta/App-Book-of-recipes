import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../models/product.dart';
import '../../../repositories/product_repository.dart';

part 'shopping_list_state.dart';

class ShoppingListCubit extends Cubit<ShoppingListState> {
  final ProductRepository _productRepository;

  ShoppingListCubit({required ProductRepository productRepository})
      : _productRepository = productRepository,
        super(ShoppingListState()) {
    _init();
  }

  Future<void> _init() async {
    final prefs = await SharedPreferences.getInstance();
    final items = prefs.getStringList('items') ?? [];

    var products = <Product>[];

    for (final item in items) {
      final product = await _productRepository.receiveProductById(item);
      if (product != null) {
        products.add(product);
      }
    }

    emit(
      state.copyWith(
        newShoppingProducts: products,
      ),
    );
  }

  Future<void> addProductToList(Product product) async {
    final prefs = await SharedPreferences.getInstance();
    var items = prefs.getStringList('items') ?? [];
    var products = state.shoppingProducts;
    if (!products.contains(product)) {
      items.add(product.id);
      products.add(product);
    }
    await prefs.setStringList('items', items);

    emit(
      state.copyWith(
        newShoppingProducts: products,
      ),
    );
  }

  Future<void> removeProductFromList(Product product) async {
    final prefs = await SharedPreferences.getInstance();
    var items = prefs.getStringList('items') ?? [];
    items.remove(product.id);
    await prefs.setStringList('items', items);
    emit(
      state.copyWith(
        newShoppingProducts: List<Product>.of(
          state.shoppingProducts..remove(product),
        ),
      ),
    );
  }
}
