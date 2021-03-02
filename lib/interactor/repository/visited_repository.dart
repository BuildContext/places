/// Интерфейс для репозитория мест "Посещенные"
abstract class VisitedRepository {
  /// Возвращает список id мест "Посещенные"
  Future<Set<int>> getList();

  /// Добавляет место с [id] в список "Посещенные"
  Future<void> add(int id);

  /// Удаляет место с [id] из списка "Посещенные"
  Future<void> remove(int id);

  /// Возвращает включено ли место [id] в список "Посещенные"
  Future<bool> isFavorite(int id);
}
