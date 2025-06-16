library;

import 'package:flutter/foundation.dart';
import '../models/payment_plan.dart';

class PaymentService {
  Future<void> purchaseItem(PaymentPlan plan) async {
    debugPrint('\u{1F4B3} purchaseItem: ${plan.id}');
    await Future.delayed(const Duration(milliseconds: 100));
  }
}
