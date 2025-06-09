library;

import 'package:flutter/foundation.dart';

import '../models/support_ticket_model.dart';
import '../services/support_service.dart';
import '../services/cloud_sync_service.dart';

class SupportProvider with ChangeNotifier {
  final SupportService _supportService;
  List<SupportTicketModel> _feedbacks = [];

  List<SupportTicketModel> get feedbacks => _feedbacks;
  SupportProvider({SupportService? service, CloudSyncService? cloudSyncService})
      : _supportService =
            service ?? SupportService(cloudSyncService: cloudSyncService);

  Future<void> loadFeedbacks() async {
    _feedbacks = await _supportService.getAllFeedbacks();
    notifyListeners();
  }

  Future<void> addFeedback(SupportTicketModel feedback) async {
    await _supportService.saveFeedback(feedback);
    _feedbacks.add(feedback);
    notifyListeners();
  }

  Future<void> deleteFeedback(String id) async {
    await _supportService.deleteFeedback(id);
    _feedbacks.removeWhere((f) => f.id == id);
    notifyListeners();
  }
}