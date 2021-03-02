import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:places/domain/filter_request.dart';
import 'package:places/domain/sight.dart';
import 'package:places/interactor/repository/sight_repository.dart';
import 'package:places/interactor/repository/visited_repository.dart';

/// Интерактор "Посещенные места"
class VisitedInteractor {
  final SightRepository sightRepository;
  final VisitedRepository visitedRepository;

  final StreamController<List<Sight>> _visitedStreamController =
      StreamController.broadcast();
  Stream<List<Sight>> get visitedStream => _visitedStreamController.stream;

  VisitedInteractor({
    @required this.sightRepository,
    @required this.visitedRepository,
  })  : assert(sightRepository != null),
        assert(visitedRepository != null);

  /// Получает список Favorite мест отсортированных по удаленности
  Future<List<Sight>> getVisitedSights() async {
    // Получаем id мест добавленных в visited
    final Set<int> visitedIds = await visitedRepository.getList();

    // в api не хватает параметра фильтра типа "список id".
    // получаем все места
    final result = await sightRepository.getFilteredList(const FilterRequest());

    // остаются только добавленные в favorites
    final visitedPlaces = result.where((e) => visitedIds.contains(e.first.id));

    final sights = visitedPlaces.map((e) => e.first).toList();

    _visitedStreamController.sink.add(sights);

    return sights;
  }

  /// Добавляет место в Visited
  Future<void> addToVisited(Sight sight) async {
    await visitedRepository.add(sight.id);
    getVisitedSights();
  }

  /// Удаляет место из Visited
  Future<void> removeFromVisited(Sight sight) async {
    await visitedRepository.remove(sight.id);
    getVisitedSights();
  }

  /// Вызывается при уничтожении интерактора
  void dispose() {
    _visitedStreamController.close();
  }
}
