import 'package:flutter_test/flutter_test.dart';
import 'package:anisphere/modules/identite/models/identity_model.dart';
import 'package:anisphere/modules/identite/services/identity_service.dart';
import 'package:hive/hive.dart';
import 'package:mockito/mockito.dart';
import 'dart:async';

class MockBox extends Mock implements Box<IdentityModel> {}

void main() {
  test('saveIdentityLocally should store model by animalId', () async {
    final mockBox = MockBox();
    final service = IdentityService(localBox: mockBox);

    final identity = IdentityModel(animalId: 'abc123');

    await service.saveIdentityLocally(identity);

    verify(mockBox.put('abc123', identity)).called(1);
  });
}
