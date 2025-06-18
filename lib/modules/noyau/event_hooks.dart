
import 'models/event_model.dart';
import 'services/event_bus_service.dart';

/// Global instance used by helper hooks.
EventBusService eventBusService = EventBusService();

/// Registers a listener for [type].
void registerListener(String type, EventCallback listener) {
  eventBusService.subscribe(type, listener);
}

/// Emits an event of [type] with [payload].
Future<void> emitEvent(
  String type, {
  Map<String, dynamic> payload = const {},
  String sender = '',
  String scope = 'global',
}) {
  final event = EventModel(
    type: type,
    payload: payload,
    sender: sender,
    scope: scope,
  );
  return eventBusService.publish(event);
}

/// Removes a previously registered listener.
void removeListener(String type, EventCallback listener) {
  eventBusService.unsubscribe(type, listener);
}

/// Registers a listener that triggers only once.
void once(String type, EventCallback listener) {
  void wrapper(EventModel event) {
    removeListener(type, wrapper);
    listener(event);
  }

  registerListener(type, wrapper);
}
