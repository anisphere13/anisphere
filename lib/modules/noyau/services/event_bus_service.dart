library;

import 'package:flutter/foundation.dart';

import '../models/event_model.dart';
import '../event_queue.dart';

typedef EventCallback = void Function(EventModel event);

/// Simple publish/subscribe bus with offline persistence.
class EventBusService {
  final Map<String, List<EventCallback>> _listeners = {};
  final EventQueue _queue;

  EventBusService({EventQueue? queue}) : _queue = queue ?? EventQueue();

  /// Register [listener] for events of [type].
  void subscribe(String type, EventCallback listener) {
    _listeners.putIfAbsent(type, () => []).add(listener);
    debugPrint('➕ Listener ajouté pour $type');
  }

  /// Remove a previously registered [listener].
  void unsubscribe(String type, EventCallback listener) {
    _listeners[type]?.remove(listener);
  }

  /// Emit an [event] to all listeners. It is stored offline until replayed.
  Future<void> publish(EventModel event, {bool persist = true}) async {
    if (persist) await _queue.addEvent(event);
    final list = _listeners[event.type];
    if (list != null) {
      for (final cb in List<EventCallback>.from(list)) {
        cb(event);
      }
    }
  }

  /// Replay queued events, then clear the queue.
  Future<void> replayQueued() async {
    final queued = await _queue.getAll();
    for (final q in queued) {
      final list = _listeners[q.event.type];
      if (list != null) {
        for (final cb in List<EventCallback>.from(list)) {
          cb(q.event);
        }
      }
    }
    await _queue.clear();
  }
}
