abstract class BaseModel {
  final String id;
  final String folderName;
  static const idKey = 'id';

  BaseModel({required this.id, required this.folderName});
}
