import 'dart:async';

import 'package:rxdart/rxdart.dart';

/// Интерактор для истории поиска
class SearchHistoryInteractor {
  // Хранилище для списка прошлых запросов
  final List<String> _requests = [];

  final BehaviorSubject<List<String>> _subj = BehaviorSubject();

  /// Стрим со списком истории запросов
  Stream<List<String>> get requestsListStream => _subj.stream;

  /// Добавить в историю.
  ///
  /// Добавляется, как самый первый элемент.
  /// Cтарые запросы стираются, чтобы не повторялись.
  void add(String request) {
    _requests.removeWhere((element) => element == request);
    _requests.insert(0, request);
    _subj.sink.add(_requests);
  }

  /// Очистить всю историю
  void clear() {
    _requests.clear();
    _subj.sink.add(_requests);
  }

  /// Удаляет запись из истории по индексу
  void remove(int index) {
    _requests.removeAt(index);
    _subj.sink.add(_requests);
  }

  /// Вызывается при уничтожении интерактора
  void dispose() {
    _subj.close();
  }
}
