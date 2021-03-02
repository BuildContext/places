/// Интерфейс для репозитория мест "Хочу посетить"
abstract class FavoritesRepository {
  /// Возвращает список id мест "Хочу посетить"
  Future<Set<int>> getList();

  /// Добавляет место с [id] в список "Хочу посетить"
  Future<void> add(int id);

  /// Удаляет место с [id] из списка "Хочу посетить"
  Future<void> remove(int id);

  /// Возвращает включено ли место [id] в список "Хочу посетить"
  Future<bool> isFavorite(int id);
}
