
import 'package:flutter/foundation.dart';

import '../models/event_model.dart';
import '../services/event_bus_service.dart';

/// ChangeNotifier wrapper around [EventBusService].
class EventBusProvider extends ChangeNotifier {
  final EventBusService _service;

  EventBusProvider({EventBusService? service})
      : _service = service ?? EventBusService();

  EventBusService get service => _service;

  Future<void> emit(EventModel event) async {
    await _service.publish(event);
    notifyListeners();
  }

  void addListenerFor(String type, EventCallback callback) {
    _service.subscribe(type, callback);
  }

  void removeListenerFor(String type, EventCallback callback) {
    _service.unsubscribe(type, callback);
  }

  Future<void> replay() => _service.replayQueued();
}
