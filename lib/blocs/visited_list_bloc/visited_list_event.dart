part of 'visited_list_bloc.dart';

abstract class VisitedListEvent extends Equatable {
  const VisitedListEvent();
}

/// Получает список Visited мест
/// [isHidden] - если false, то эмитится VisitedLoadingInProgress пока идет загрузка
class LoadVisitedListEvent extends VisitedListEvent {
  final bool isHidden;

  const LoadVisitedListEvent({this.isHidden = true});

  @override
  List<Object> get props => [isHidden];
}

/// Добавляет место в Visited
class AddToVisitedListEvent extends VisitedListEvent {
  final Sight sight;

  const AddToVisitedListEvent(this.sight);

  @override
  List<Object> get props => [sight];
}

/// Удаляет место из Visited
class RemoveFromVisitedListEvent extends VisitedListEvent {
  final Sight sight;

  const RemoveFromVisitedListEvent(this.sight);

  @override
  List<Object> get props => [sight];
}
