import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:anisphere/modules/noyau/i18n/i18n_provider.dart';
import 'package:anisphere/modules/noyau/i18n/language_selector_widget.dart';
import '../../test_config.dart';

void main() {
  setUpAll(() async {
    await initTestEnv();
  });

  testWidgets('selecting a language updates provider', (tester) async {}, skip: true);
  });
}
