// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sight_list_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SightListStore on SightListStoreBase, Store {
  Computed<bool> _$isLoadingComputed;

  @override
  bool get isLoading =>
      (_$isLoadingComputed ??= Computed<bool>(() => super.isLoading,
              name: 'SightListStoreBase.isLoading'))
          .value;
  Computed<bool> _$hasErrorComputed;

  @override
  bool get hasError =>
      (_$hasErrorComputed ??= Computed<bool>(() => super.hasError,
              name: 'SightListStoreBase.hasError'))
          .value;

  final _$sightListFutureAtom =
      Atom(name: 'SightListStoreBase.sightListFuture');

  @override
  ObservableFuture<List<Sight>> get sightListFuture {
    _$sightListFutureAtom.reportRead();
    return super.sightListFuture;
  }

  @override
  set sightListFuture(ObservableFuture<List<Sight>> value) {
    _$sightListFutureAtom.reportWrite(value, super.sightListFuture, () {
      super.sightListFuture = value;
    });
  }

  final _$requestFilteredSightsAsyncAction =
      AsyncAction('SightListStoreBase.requestFilteredSights');

  @override
  Future<void> requestFilteredSights({@required Filter filter}) {
    return _$requestFilteredSightsAsyncAction
        .run(() => super.requestFilteredSights(filter: filter));
  }

  @override
  String toString() {
    return '''
sightListFuture: ${sightListFuture},
isLoading: ${isLoading},
hasError: ${hasError}
    ''';
  }
}
