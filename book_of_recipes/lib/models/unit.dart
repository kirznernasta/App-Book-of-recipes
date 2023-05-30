import 'base_model.dart';

class Unit extends BaseModel {
  final String name;

  static const nameKey = 'name';

  static const folder = 'units';

  Unit({
    required String id,
    required this.name,
  }) : super(id: id, folderName: folder);

  factory Unit.fromDatabaseMap(Map<String, dynamic> map) => Unit(
        id: map[BaseModel.idKey],
        name: map[nameKey],
      );

  Map<String, dynamic> toDatabaseMap() => {
        BaseModel.idKey: id,
        nameKey: name,
      };

  Unit copyWith({
    String? newId,
    String? newName,
  }) =>
      Unit(
        id: newId ?? id,
        name: newName ?? name,
      );
}
