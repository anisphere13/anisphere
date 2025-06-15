library;

import 'package:hive/hive.dart';
import 'package:flutter/foundation.dart';

import 'models/event_model.dart';

part 'event_queue.g.dart';

@HiveType(typeId: 161)
class QueuedEvent {
  @HiveField(0)
  final EventModel event;

  @HiveField(1)
  final DateTime timestamp;

  QueuedEvent({required this.event, DateTime? timestamp})
      : timestamp = timestamp ?? DateTime.now();
}

class EventQueue {
  static const String _boxName = 'event_queue';

  Future<void> addEvent(EventModel event) async {
    final box = await Hive.openBox<QueuedEvent>(_boxName);
    await box.add(QueuedEvent(event: event));
    debugPrint('📥 Événement ajouté à la file offline : ${event.type}');
  }

  Future<List<QueuedEvent>> getAll() async {
    final box = await Hive.openBox<QueuedEvent>(_boxName);
    return box.values.toList();
  }

  Future<void> clear() async {
    final box = await Hive.openBox<QueuedEvent>(_boxName);
    await box.clear();
    debugPrint('🧹 File d\'événements offline vidée.');
  }
}
