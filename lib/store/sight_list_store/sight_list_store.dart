import 'package:flutter/foundation.dart';
import 'package:mobx/mobx.dart';
import 'package:places/domain/filter.dart';
import 'package:places/domain/filter_request.dart';
import 'package:places/domain/geo_point.dart';
import 'package:places/domain/sight.dart';
import 'package:places/interactor/repository/location_repository.dart';
import 'package:places/interactor/repository/sight_repository.dart';

part 'sight_list_store.g.dart';

/// Стор mobx для экрана списка интересным мест
class SightListStore = SightListStoreBase with _$SightListStore;

abstract class SightListStoreBase with Store {
  SightListStoreBase(
      {@required this.sightRepository, @required this.locationRepository})
      : assert(sightRepository != null),
        assert(locationRepository != null);

  final SightRepository sightRepository;
  final LocationRepository locationRepository;

  /// Список мест
  @observable
  ObservableFuture<List<Sight>> sightListFuture;

  /// Флаг загрузки
  @computed
  bool get isLoading =>
      sightListFuture == null || sightListFuture.status == FutureStatus.pending;

  /// Флаг ошибки
  @computed
  bool get hasError =>
      sightListFuture != null &&
      sightListFuture.status == FutureStatus.rejected;

  /// Загружает места, которые соответствуют фильтру [filter]
  @action
  Future<void> requestFilteredSights({@required Filter filter}) async {
    FilterRequest filterReq;

    if (filter.maxDistance != null) {
      // Если задан гео-поиск, то получаем текущее местоположение
      // и формируем соответствующий запрос
      final GeoPoint currLoc = await locationRepository.getCurrentLocation();
      filterReq = FilterRequest(
        lat: currLoc.lat,
        lng: currLoc.lon,
        radius: filter.maxDistance,
        typeFilter: filter.types.map((e) => e.code).toList(),
        nameFilter: filter.nameFilter,
      );
    } else {
      filterReq = FilterRequest(
        typeFilter: filter.types.map((e) => e.code).toList(),
        nameFilter: filter.nameFilter,
      );
    }

    try {
      final result = await sightRepository.getFilteredList(filterReq);
      final sights = result.map((e) => e.first).toList();
      sightListFuture = ObservableFuture.value(sights);
    } catch (e) {
      sightListFuture = ObservableFuture.error(e);
    }
  }
}
