import 'dart:async';

abstract class Cubit<State> {
  Cubit(this._state);

  State _state;
  State get state => _state;

  final _controller = StreamController<State>.broadcast();
  Stream<State> get stream => _controller.stream;

  void emit(State newState) {
    if (_state == newState) return;
    _state = newState;
    if (!_controller.isClosed) {
      _controller.add(newState);
    }
  }

  void dispose() {
    _controller.close();
  }
}
