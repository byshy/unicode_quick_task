import 'dart:async';

class Debouncer {
  final int durationSeconds;
  final void Function(String value) callback;

  Timer? _timer;

  Debouncer({
    required this.durationSeconds,
    required this.callback,
  });

  void value({required String input}) {
    if (_timer != null) {
      _timer!.cancel();
    }

    _timer = Timer(
      Duration(seconds: durationSeconds),
      () => callback(input),
    );
  }
}
