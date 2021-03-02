import 'package:places/interactor/repository/favorites_repository.dart';

/// Репозиторий мест "Хочу посетить".
///
/// Храним в памяти пока не подключена db
class FavoritesRepositoryMemory implements FavoritesRepository {
  final Set<int> _favorites = {};

  @override
  Future<void> add(int id) {
    _favorites.add(id);
    return Future.value();
  }

  @override
  Future<Set<int>> getList() {
    return Future.value(_favorites);
  }

  @override
  Future<bool> isFavorite(int id) {
    final bool isFav = _favorites.contains(id);
    return Future.value(isFav);
  }

  @override
  Future<void> remove(int id) {
    _favorites.remove(id);
    return Future.value();
  }
}
