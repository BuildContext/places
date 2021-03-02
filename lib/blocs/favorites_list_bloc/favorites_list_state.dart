part of 'favorites_list_bloc.dart';

abstract class FavoritesListState extends Equatable {
  const FavoritesListState();

  @override
  List<Object> get props => [];
}

/// Идет загрузка
class LoadFavoritesListInProgressState extends FavoritesListState {}

/// Ошибка загрузки
class ErrorFavoritesListState extends FavoritesListState {
  final String message;

  const ErrorFavoritesListState(this.message);

  @override
  List<Object> get props => [message];
}

/// Favorites загружены
class LoadedFavoritesState extends FavoritesListState {
  final List<Sight> sights;

  const LoadedFavoritesState(this.sights);

  @override
  List<Object> get props => [sights];
}
