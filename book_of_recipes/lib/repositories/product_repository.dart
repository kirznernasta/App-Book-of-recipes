import '../models/product.dart';
import '../services/firebase/database_provider.dart';
import 'base_repository.dart';

class ProductRepository implements BaseRepository<Product> {
  final DatabaseProvider _databaseProvider;

  ProductRepository({required DatabaseProvider databaseProvider})
      : _databaseProvider = databaseProvider;

  Stream<List<Product>> get productsStream {
    return _databaseProvider.itemsStream(Product.folder).map(
      (product) {
        final snapshot = product.snapshot;
        return snapshot.children
            .map((product) => Product.fromDatabaseMap(
                Map<String, dynamic>.from(product.value as Map)))
            .toList();
      },
    );
  }

  @override
  Future<void> add(Product product) {
    return _databaseProvider.insert(
      folderName: Product.folder,
      item: product.toDatabaseMap(),
    );
  }

  @override
  Future<void> delete(String productId) async {
    return _databaseProvider.delete(
      folderName: Product.folder,
      id: productId,
    );
  }

  @override
  Future<List<Product>> receiveAll() async {
    final snapshot = await _databaseProvider.queryAll(Product.folder);
    if (snapshot.exists) {
      return snapshot.children
          .map((product) => Product.fromDatabaseMap(
              Map<String, dynamic>.from(product.value as Map)))
          .toList();
    } else {
      return [];
    }
  }

  Future<Product?> receiveProductById(String productId) async {
    final snapshot = await _databaseProvider.queryById(
      folderName: Product.folder,
      id: productId,
    );
    if (snapshot.exists) {
      return Product.fromDatabaseMap(
        Map<String, dynamic>.from(snapshot.value as Map),
      );
    } else {
      return null;
    }
  }

  @override
  Future<void> update(Product product) {
    return _databaseProvider.update(
      folderName: Product.folder,
      item: product.toDatabaseMap(),
    );
  }
}
