import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import '../../test_config.dart';
import 'package:http/testing.dart';
import 'package:http/http.dart' as http;
import 'package:anisphere/modules/noyau/services/cloud_drive_service.dart';

void main() {
  setUpAll(() async {
    await initTestEnv();
  });

  test('uploadFile uses Google Drive API when authenticated', () async {
    late http.Request captured;
    final client = MockClient((request) async {
      captured = request;
      return http.Response('{}', 200);
    });

    final service = CloudDriveService(client: client);
    service.authenticateGoogle('token123');

    final file = File('${Directory.systemTemp.path}/g.txt');
    await file.writeAsString('hello');

    final result = await service.uploadFile(file);

    expect(result, isTrue);
    expect(captured.url.toString(), contains('googleapis.com'));
    expect(captured.headers['Authorization'], 'Bearer token123');
  });

  test('uploadFile uses OneDrive when Google unavailable', () async {
    late http.Request captured;
    final client = MockClient((request) async {
      captured = request;
      return http.Response('{}', 201);
    });

    final service = CloudDriveService(client: client);
    service.authenticateOneDrive('one');

    final file = File('${Directory.systemTemp.path}/o.txt');
    await file.writeAsString('hi');

    final result = await service.uploadFile(file);

    expect(result, isTrue);
    expect(captured.url.toString(), contains('graph.microsoft.com'));
    expect(captured.method, 'PUT');
  });

  test('checkQuota calls Dropbox API', () async {
    final client = MockClient((request) async {
      expect(request.url.toString(), contains('dropboxapi.com'));
      return http.Response('{"used":100,"allocation":{"allocated":1000}}', 200);
    });

    final service = CloudDriveService(client: client);
    service.authenticateDropbox('d');

    final remaining = await service.checkQuota();

    expect(remaining, 900);
  });
}
