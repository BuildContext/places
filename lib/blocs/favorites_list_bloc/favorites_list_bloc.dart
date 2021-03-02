import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:places/domain/filter_request.dart';
import 'package:places/domain/geo_point.dart';
import 'package:places/domain/sight.dart';
import 'package:places/interactor/repository/exceptions/internet_exception.dart';
import 'package:places/interactor/repository/exceptions/network_exception.dart';
import 'package:places/interactor/repository/favorites_repository.dart';
import 'package:places/interactor/repository/location_repository.dart';
import 'package:places/interactor/repository/sight_repository.dart';

part 'favorites_list_event.dart';
part 'favorites_list_state.dart';

/// Bloc списка Favorites мест
class FavoritesListBloc extends Bloc<FavoritesListEvent, FavoritesListState> {
  FavoritesListBloc({
    @required this.sightRepository,
    @required this.favoritesRepository,
    @required this.locationRepository,
  })  : assert(sightRepository != null),
        assert(favoritesRepository != null),
        assert(locationRepository != null),
        super(LoadFavoritesListInProgressState());

  final SightRepository sightRepository;
  final FavoritesRepository favoritesRepository;
  final LocationRepository locationRepository;

  @override
  Stream<FavoritesListState> mapEventToState(FavoritesListEvent event) async* {
    if (event is LoadFavoritesListEvent) {
      yield* _mapLoadFavoritesListEventToState(event);
    } else if (event is RemoveFromFavoritesListEvent) {
      yield* _mapRemoveFromFavoritesListEventToState(event);
    } else {
      yield ErrorFavoritesListState('Unknown event. ${event.runtimeType}');
    }
  }

  /// Загружает список Favorites мест
  Stream<FavoritesListState> _mapLoadFavoritesListEventToState(
    LoadFavoritesListEvent event,
  ) async* {
    if (!event.isHidden) {
      yield LoadFavoritesListInProgressState();
    }
    try {
      final sights = await _getFavoritesSights();
      yield LoadedFavoritesState(sights);
    } on NetworkException catch (e) {
      yield ErrorFavoritesListState(
          '${e.request} ${e.errorCode}:${e.errorText}');
    } on InternetException catch (e) {
      yield ErrorFavoritesListState('${e.request} ${e.errorText}');
    }
  }

  /// Удаляет место из Favorites
  Stream<FavoritesListState> _mapRemoveFromFavoritesListEventToState(
    RemoveFromFavoritesListEvent event,
  ) async* {
    await _removeFromFavorites(event.sight);
    add(const LoadFavoritesListEvent());
  }

  /// Отдает список Favorite мест отсортированных по удаленности
  Future<List<Sight>> _getFavoritesSights() async {
    // Получаем id мест добавленных в favorites
    final Set<int> favoritesIds = await favoritesRepository.getList();

    // Получаем список мест с данными по удаленности от текущего местоположения
    // Получаем текущее местоположение
    final GeoPoint currLoc = await locationRepository.getCurrentLocation();
    // радиус поиска максимальный, чтобы захватить все места.
    const double maxRadius = 100000.1;
    final FilterRequest filterReq = FilterRequest(
      lng: currLoc.lon,
      lat: currLoc.lat,
      radius: maxRadius,
    );

    // получаем все места
    final result = await sightRepository.getFilteredList(filterReq);

    // остаются только добавленные в favorites
    final favoritesPlaces = result
        .where((element) => favoritesIds.contains(element.first.id))
        .toList();

    // Сортируем по расстоянию
    favoritesPlaces.sort((a, b) => a.second > b.second ? 1 : -1);

    final sights = favoritesPlaces.map((e) => e.first).toList();

    return sights;
  }

  /// Удаление места из Favorites
  Future<void> _removeFromFavorites(Sight sight) async {
    await favoritesRepository.remove(sight.id);
  }
}
