import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mockito/mockito.dart';

import 'package:anisphere/modules/noyau/services/local_storage_service.dart';
import 'local_storage_service_test.mocks.dart';

void main() {
  late MockBox mockBox;
  late LocalStorageService localStorage;

  setUp(() {
    mockBox = MockBox();
    when(mockBox.isOpen).thenReturn(true);
    localStorage = LocalStorageService();
    localStorage.init(); // on pourrait injecter un testBox si on l’étend
  });

  test('get() retourne la valeur par défaut si clé absente', () {
    when(mockBox.get('theme', defaultValue: 'light')).thenReturn('light');
    final result = localStorage.get('theme', defaultValue: 'light');
    expect(result, equals('light'));
  });
}
