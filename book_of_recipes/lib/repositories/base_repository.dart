import '../models/base_model.dart';

abstract class BaseRepository<T extends BaseModel> {
  Future<List<T>> receiveAll();
  Future<void> add(T item);
  Future<void> update(T item);
  Future<void> delete(String id);
}
