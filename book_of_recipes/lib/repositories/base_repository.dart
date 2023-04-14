abstract class BaseRepository<T> {
  List<T> receiveAll();
  void add(T item);
  void update(T item);
  void delete(T item);
}
