import 'base_model.dart';

class User extends BaseModel {
  final String name;
  final String email;
  final String image;
  final bool isAdmin;
  final List<String> favouriteRecipeIds;

  static const nameKey = 'name';
  static const emailKey = 'email';
  static const imageKey = 'image';
  static const isAdminKey = 'is_admin';
  static const favouriteRecipeIdsKey = 'favourite_recipe_ids';

  static const folder = 'users';

  User({
    required String id,
    required this.name,
    required this.email,
    required this.image,
    required this.isAdmin,
    required this.favouriteRecipeIds,
  }) : super(id: id, folderName: folder);

  factory User.fromDatabaseMap(Map<String, dynamic> map) => User(
        id: map[BaseModel.idKey],
        name: map[nameKey],
        email: map[emailKey],
        image: map[imageKey],
        isAdmin: map[isAdminKey],
        favouriteRecipeIds: List<String>.from(map[favouriteRecipeIdsKey] ?? []),
      );

  Map<String, dynamic> toDatabaseMap() => {
        BaseModel.idKey: id,
        nameKey: name,
        emailKey: email,
        imageKey: image,
        isAdminKey: isAdmin,
        favouriteRecipeIdsKey: favouriteRecipeIds,
      };

  User copyWith({
    String? newId,
    String? newName,
    String? newEmail,
    String? newImage,
    bool? admin,
    List<String>? newFavouriteRecipeIds,
  }) =>
      User(
        id: newId ?? id,
        name: newName ?? name,
        email: newEmail ?? email,
        image: newImage ?? image,
        isAdmin: admin ?? isAdmin,
        favouriteRecipeIds: newFavouriteRecipeIds ?? favouriteRecipeIds,
      );
}
