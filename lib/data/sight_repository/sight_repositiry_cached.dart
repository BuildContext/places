import 'package:flutter/foundation.dart';
import 'package:places/domain/core/pair.dart';
import 'package:places/domain/filter_request.dart';
import 'package:places/domain/sight.dart';
import 'package:places/interactor/repository/sight_repository.dart';

/// Репозиторий мест.
///
/// Данные при запросе в network кешируются в db.
/// TODO
class SightRepositoryCached implements SightRepository {
  final SightRepository sightRepositoryDb;
  final SightRepository sightRepositoryNetwork;

  SightRepositoryCached({
    @required this.sightRepositoryDb,
    @required this.sightRepositoryNetwork,
  })  : assert(sightRepositoryDb != null),
        assert(sightRepositoryNetwork != null);

  @override
  Future<Sight> add(Sight place) {
    // TODO: implement add
    throw UnimplementedError();
  }

  @override
  Future<void> delete({int id}) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<Sight> get({int id}) {
    // TODO: implement get
    throw UnimplementedError();
  }

  @override
  Future<List<Pair<Sight, double>>> getFilteredList(FilterRequest filter) {
    // TODO: implement getFilteredList
    throw UnimplementedError();
  }

  @override
  Future<List<Sight>> getList({int count, int offset}) {
    // TODO: implement getList
    throw UnimplementedError();
  }

  @override
  Future<Sight> update(Sight sight) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
