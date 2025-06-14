library;

import 'package:flutter/foundation.dart';

import '../models/consent_entry.dart';
import '../services/consent_service.dart';

class ConsentProvider with ChangeNotifier {
  final ConsentService _service;
  List<ConsentEntry> _history = [];

  List<ConsentEntry> get history => _history;
  ConsentEntry? get lastEntry => _history.isNotEmpty ? _history.last : null;

  bool get accepted => lastEntry?.action == ConsentAction.accepted;

  ConsentProvider({ConsentService? service})
      : _service = service ?? ConsentService();

  Future<void> loadHistory() async {
    _history = await _service.getHistory();
    notifyListeners();
  }

  Future<void> addAction(ConsentAction action, String userId) async {
    final entry = ConsentEntry(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      userId: userId,
      action: action,
      timestamp: DateTime.now(),
    );
    await _service.addEntry(entry);
    _history.add(entry);
    notifyListeners();
  }
}
