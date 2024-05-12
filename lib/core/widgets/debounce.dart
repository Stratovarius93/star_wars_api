import 'dart:async';
import 'dart:ui';

class CallbackDebouncer {
  CallbackDebouncer(this._delay);
  final Duration _delay;
  Timer? _timer;
  bool _firstCall = true;

  void call(VoidCallback callback) {
    if (_firstCall) {
      callback();
      _firstCall = false;
    } else {
      if (_delay == Duration.zero) {
        callback();
      } else {
        _timer?.cancel();
        _timer = Timer(_delay, callback);
      }
    }
  }

  void dispose() {
    _timer?.cancel();
  }
}
