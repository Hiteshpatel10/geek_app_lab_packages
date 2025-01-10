import 'dart:async';
import 'dart:ui';

class CoreDebouncer {
  final int milliseconds;
  Timer? _timer;

  CoreDebouncer({required this.milliseconds});

  run(VoidCallback action) {
    _timer?.cancel();
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}
