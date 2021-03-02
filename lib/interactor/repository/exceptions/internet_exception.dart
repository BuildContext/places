/// Исключение для ошибок соединения. (отсутствие сети и тп)
class InternetException implements Exception {
  final String request;
  final String errorText;

  InternetException(this.request, this.errorText);

  @override
  String toString() => 'В запросе "$request" возникла ошибка: $errorText';
}
