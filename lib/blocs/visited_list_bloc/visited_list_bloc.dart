import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:places/domain/filter_request.dart';
import 'package:places/domain/sight.dart';
import 'package:places/interactor/repository/exceptions/internet_exception.dart';
import 'package:places/interactor/repository/exceptions/network_exception.dart';
import 'package:places/interactor/repository/sight_repository.dart';
import 'package:places/interactor/repository/visited_repository.dart';

part 'visited_list_event.dart';
part 'visited_list_state.dart';

/// Bloc для списка посещенных мест
class VisitedListBloc extends Bloc<VisitedListEvent, VisitedListState> {
  VisitedListBloc({
    @required this.sightRepository,
    @required this.visitedRepository,
  })  : assert(sightRepository != null),
        assert(visitedRepository != null),
        super(VisitedListLoadingInProgress());

  final SightRepository sightRepository;
  final VisitedRepository visitedRepository;

  @override
  Stream<VisitedListState> mapEventToState(VisitedListEvent event) async* {
    if (event is LoadVisitedListEvent) {
      yield* _mapLoadVisitedEventToState(event);
    } else if (event is AddToVisitedListEvent) {
      yield* _mapAddToVisitedEventToState(event);
    } else if (event is RemoveFromVisitedListEvent) {
      yield* _mapRemoveFromVisitedEventToState(event);
    } else {
      yield ErrorVisitedListState('Unknown event. ${event.runtimeType}');
    }
  }

  /// Загрузка посещенных мест
  Stream<VisitedListState> _mapLoadVisitedEventToState(
      LoadVisitedListEvent event) async* {
    // Если не скрытая загрузка, то эмитим VisitedLoadingInProgress
    if (!event.isHidden) {
      yield VisitedListLoadingInProgress();
    }

    try {
      final sights = await _getVisitedSights();
      yield VisitedListLoaded(sights);
    } on NetworkException catch (e) {
      yield ErrorVisitedListState('${e.request} ${e.errorCode}:${e.errorText}');
    } on InternetException catch (e) {
      yield ErrorVisitedListState('${e.request} ${e.errorText}');
    }
  }

  /// Добавляет место в Visited
  Stream<VisitedListState> _mapAddToVisitedEventToState(
      AddToVisitedListEvent event) async* {
    await _addToVisited(event.sight);
    add(const LoadVisitedListEvent());
  }

  /// Удаляет место из Visited
  Stream<VisitedListState> _mapRemoveFromVisitedEventToState(
      RemoveFromVisitedListEvent event) async* {
    await _removeFromVisited(event.sight);
    add(const LoadVisitedListEvent());
  }

  /// Получает список Visited мест
  Future<List<Sight>> _getVisitedSights() async {
    // Получаем id мест добавленных в visited
    final Set<int> visitedIds = await visitedRepository.getList();

    // получаем все места
    final result = await sightRepository.getFilteredList(const FilterRequest());

    // остаются только уже посещенные
    final visitedPlaces = result.where((e) => visitedIds.contains(e.first.id));

    final sights = visitedPlaces.map((e) => e.first).toList();

    return sights;
  }

  /// Добавление места в Visited
  Future<void> _addToVisited(Sight sight) async {
    await visitedRepository.add(sight.id);
  }

  /// Удаление места из Visited
  Future<void> _removeFromVisited(Sight sight) async {
    await visitedRepository.remove(sight.id);
  }
}
