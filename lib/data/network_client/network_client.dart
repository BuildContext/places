/// Интерфейс для сетевого взаимодействия
///
/// Совершает запросы к серверу
/// Если успешно, то возвращает результат в виде строки
/// Если сервер вернул что-то отличное от 200, то должен выкидывать [InternetException]
/// При отсутствии интернета или других проблемах соединения, то должен выкидывать [NetworkException]
abstract class NetworkClient {
  /// Делает POST запрос
  Future<String> post(String url, String body);

  /// Делает GET запрос
  Future<String> get(String url, Map<String, dynamic> params);
}
