import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:places/data/network_client/network_client.dart';
import 'package:places/interactor/repository/exceptions/internet_exception.dart';
import 'package:places/interactor/repository/exceptions/network_exception.dart';

/// Клиент для сетевого взаимодействия через Dio
///
/// Совершает запросы к серверу
/// Если успешно, то возвращает результат в виде строки
/// Если сервер вернул что-то отличное от 200, то выкидывает [NetworkException]
/// При отсутствии интернета или других проблемах соединения, то выкидывает [InternetException]
class NetworkClientDio implements NetworkClient {
  final Dio _dio = Dio();

  NetworkClientDio({@required String baseUrl}) : assert(baseUrl != null) {
    _dio.options.baseUrl = baseUrl;
    _dio.options.connectTimeout = 5000;
    _dio.options.receiveTimeout = 5000;
    _dio.options.sendTimeout = 5000;
    _dio.options.responseType = ResponseType.json;

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options) {
          print('request: ${options.data}');
        },
        onResponse: (response) {
          print('response: ${response.data}');
        },
        onError: (e) {},
      ),
    );
  }

  /// Делает POST запрос
  @override
  Future<String> post(String url, String body) async {
    return _executeRequest(_dio.post<String>(url, data: body));
  }

  /// Делает GET запрос
  @override
  Future<String> get(String url, Map<String, dynamic> params) async {
    return _executeRequest(_dio.get<String>(url, queryParameters: params));
  }

  // Выполняет запрос. Возвращает результат или выкидывает exception
  Future<String> _executeRequest(Future<Response<String>> requestFuture) async {
    try {
      final response = await requestFuture;
      if (response.statusCode != 200) {
        throw NetworkException(
          response.request.baseUrl,
          response.statusCode,
          response.statusMessage,
        );
      }
      return response.data;
    } catch (e) {
      throw _mapException(e);
    }
  }

  dynamic _mapException(dynamic e) {
    if (e is DioError) {
      return InternetException(e.request.path, e.message);
    } else if (e is NetworkException) {
      return e;
    }
    return e;
  }
}
