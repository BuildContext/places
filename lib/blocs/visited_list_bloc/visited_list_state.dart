part of 'visited_list_bloc.dart';

abstract class VisitedListState extends Equatable {
  const VisitedListState();
}

/// Идет загрузка посещенных мест
class VisitedListLoadingInProgress extends VisitedListState {
  @override
  List<Object> get props => [];
}

/// Ошибка загрузки
class ErrorVisitedListState extends VisitedListState {
  final String message;

  const ErrorVisitedListState(this.message);

  @override
  List<Object> get props => [message];
}

/// Посещенные места загружены
class VisitedListLoaded extends VisitedListState {
  final List<Sight> sights;

  const VisitedListLoaded(this.sights);

  @override
  List<Object> get props => [sights];
}
