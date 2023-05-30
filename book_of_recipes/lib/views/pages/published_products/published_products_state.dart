part of 'published_products_cubit.dart';

class PublishedProductsState {
  final List<Product> _products;
  final String request;
  final int selectedIndex;

  PublishedProductsState({
    List<Product> products = const [],
    this.request = '',
    this.selectedIndex = -1,
  }) : _products = products;

  List<Product> get products => List<Product>.from(
        _products.where(
          (product) => product.name.contains(
            request,
          ),
        ),
      );

  PublishedProductsState copyWith({
    List<Product>? newProducts,
    String? newRequest,
    int? newSelectedIndex,
  }) =>
      PublishedProductsState(
        products: newProducts ?? _products,
        request: newRequest ?? request,
        selectedIndex: newSelectedIndex ?? selectedIndex,
      );
}
