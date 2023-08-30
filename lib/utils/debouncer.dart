import 'dart:async' show Timer;
import 'package:flutter/foundation.dart' show VoidCallback;

/// Дебаунсер - нужен для ограничения количества вызовов [VoidCallback] на еденицу времени [duration]
class Debouncer {
  final Duration duration;
  Timer? _timer;

  Debouncer({required this.duration});

  run(VoidCallback action) {
    _timer?.cancel();
    _timer = Timer(duration, action);
  }

  dispose() {
    _timer?.cancel();
  }
}
