import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/product.dart';
import '../../../repositories/product_repository.dart';

part 'published_products_state.dart';

class PublishedProductsCubit extends Cubit<PublishedProductsState> {
  final ProductRepository _productRepository;
  late final StreamSubscription<List<Product>> _productsSubscription;

  PublishedProductsCubit({required ProductRepository productRepository})
      : _productRepository = productRepository,
        super(PublishedProductsState()) {
    _initSubscription();
  }

  void _initSubscription() {
    _productsSubscription = _productRepository.productsStream.listen(
      (products) {
        final publishedProducts = List<Product>.from(
          products.where(
            (product) => product.isPublished,
          ),
        )..sort(
            (product1, product2) => product1.name.compareTo(
              product2.name,
            ),
          );
        emit(
          state.copyWith(
            newProducts: publishedProducts,
          ),
        );
      },
    );
  }

  Future<void> deleteProduct(int index) async {
    final productId = state._products[index].id;
    return await _productRepository.delete(productId);
  }

  void requestChanged(String value) => emit(
        state.copyWith(
          newRequest: value,
        ),
      );

  void toggleSelectedProduct(int index) => emit(
        state.copyWith(
          newSelectedIndex: index == state.selectedIndex ? -1 : index,
        ),
      );

  void resetSelectedProduct() => emit(
        state.copyWith(
          newSelectedIndex: -1,
          newRequest: '',
        ),
      );
}
