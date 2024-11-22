import 'dart:async';

part 'events.dart';
final eventBus = _EventBus();

class _EventBus {
  final StreamController _streamController;

  StreamController get streamController => _streamController;

  _EventBus({bool sync = false}) : _streamController = StreamController.broadcast(sync: sync);

  _EventBus.customController(StreamController controller) : _streamController = controller;

  Stream<T> on<T>() {
    if (T == dynamic) {
      return streamController.stream as Stream<T>;
    } else {
      return streamController.stream.where((event) => event is T).cast<T>();
    }
  }

  void fire(event) {
    streamController.add(event);
  }

  void destroy() {
    _streamController.close();
  }
}
