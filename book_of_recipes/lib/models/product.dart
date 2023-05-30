import 'base_model.dart';

class Product extends BaseModel {
  final String name;
  final String image;
  final bool isPublished;
  final bool isRequested;

  static const nameKey = 'name';
  static const imageKey = 'image';
  static const publishedKey = 'is_published';
  static const requestedKey = 'is_requested';

  static const folder = 'products';

  Product({
    required String id,
    required this.name,
    required this.image,
    required this.isPublished,
    required this.isRequested,
  }) : super(id: id, folderName: folder);

  factory Product.fromDatabaseMap(Map<String, dynamic> map) => Product(
        id: map[BaseModel.idKey],
        name: map[nameKey],
        image: map[imageKey],
        isPublished: map[publishedKey],
        isRequested: map[requestedKey],
      );

  Map<String, dynamic> toDatabaseMap() => {
        BaseModel.idKey: id,
        nameKey: name,
        imageKey: image,
        publishedKey: isPublished,
        requestedKey: isRequested,
      };

  Product copyWith({
    String? newId,
    String? newName,
    String? newImage,
    bool? published,
    bool? requested,
  }) =>
      Product(
        id: newId ?? id,
        name: newName ?? name,
        image: newImage ?? image,
        isPublished: published ?? isPublished,
        isRequested: requested ?? isRequested,
      );
}
