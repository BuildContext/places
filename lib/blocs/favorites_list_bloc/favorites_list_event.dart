part of 'favorites_list_bloc.dart';

abstract class FavoritesListEvent extends Equatable {
  const FavoritesListEvent();
}

/// Событие загрузки списка Favorites
class LoadFavoritesListEvent extends FavoritesListEvent {
  final bool isHidden;

  const LoadFavoritesListEvent({this.isHidden = true});

  @override
  List<Object> get props => [isHidden];
}

/// Удаляет место из Favorites
class RemoveFromFavoritesListEvent extends FavoritesListEvent {
  final Sight sight;

  const RemoveFromFavoritesListEvent(this.sight);

  @override
  List<Object> get props => [sight];
}
