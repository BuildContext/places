/// Исключение для сетевых ошибок
class NetworkException implements Exception {
  final String request;
  final int errorCode;
  final String errorText;

  NetworkException(this.request, this.errorCode, this.errorText);

  @override
  String toString() =>
      'В запросе "$request" возникла ошибка: $errorCode $errorText';
}
