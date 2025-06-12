// Copilot Prompt : Service permettant de stocker des fichiers dans Google Drive, OneDrive ou Dropbox.
// Gère l'authentification simple via token OAuth et l'upload de fichiers.
// Fournit aussi des helpers pour vérifier l'espace disponible et connaître le service actif.
library;

import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

enum DriveProvider { google, onedrive, dropbox }

class CloudDriveService {
  final http.Client httpClient;
  String? _googleToken;
  String? _oneDriveToken;
  String? _dropboxToken;

  CloudDriveService({http.Client? client}) : httpClient = client ?? http.Client();

  /// 🔑 Enregistre le token OAuth pour Google Drive
  void authenticateGoogle(String token) {
    _googleToken = token;
    _log('Google Drive authenticated');
  }

  /// 🔑 Enregistre le token OAuth pour OneDrive
  void authenticateOneDrive(String token) {
    _oneDriveToken = token;
    _log('OneDrive authenticated');
  }

  /// 🔑 Enregistre le token OAuth pour Dropbox
  void authenticateDropbox(String token) {
    _dropboxToken = token;
    _log('Dropbox authenticated');
  }

  /// 📦 Upload un fichier vers le premier service disponible
  Future<bool> uploadFile(File file) async {
    final service = getAvailableService();
    if (service == null) return false;
    switch (service) {
      case DriveProvider.google:
        return _uploadToGoogle(file);
      case DriveProvider.onedrive:
        return _uploadToOneDrive(file);
      case DriveProvider.dropbox:
        return _uploadToDropbox(file);
    }
  }

  /// 🔍 Vérifie l'espace disponible (en octets) sur le service actif
  Future<int?> checkQuota() async {
    final service = getAvailableService();
    if (service == null) return null;
    switch (service) {
      case DriveProvider.google:
        return _quotaGoogle();
      case DriveProvider.onedrive:
        return _quotaOneDrive();
      case DriveProvider.dropbox:
        return _quotaDropbox();
    }
  }

  /// 🔁 Renvoie le service disponible en priorité : Google > OneDrive > Dropbox
  DriveProvider? getAvailableService() {
    if (_googleToken != null) return DriveProvider.google;
    if (_oneDriveToken != null) return DriveProvider.onedrive;
    if (_dropboxToken != null) return DriveProvider.dropbox;
    return null;
  }

  Future<bool> _uploadToGoogle(File file) async {
    final uri = Uri.parse('https://www.googleapis.com/upload/drive/v3/files?uploadType=media');
    final response = await httpClient.post(
      uri,
      headers: {
        'Authorization': 'Bearer $_googleToken',
        'Content-Type': 'application/octet-stream',
      },
      body: await file.readAsBytes(),
    );
    _log('Google upload status ${response.statusCode}');
    return response.statusCode >= 200 && response.statusCode < 300;
  }

  Future<bool> _uploadToOneDrive(File file) async {
    final filename = file.uri.pathSegments.last;
    final uri = Uri.parse('https://graph.microsoft.com/v1.0/me/drive/root:/$filename:/content');
    final response = await httpClient.put(
      uri,
      headers: {
        'Authorization': 'Bearer $_oneDriveToken',
        'Content-Type': 'application/octet-stream',
      },
      body: await file.readAsBytes(),
    );
    _log('OneDrive upload status ${response.statusCode}');
    return response.statusCode >= 200 && response.statusCode < 300;
  }

  Future<bool> _uploadToDropbox(File file) async {
    final filename = file.uri.pathSegments.last;
    final uri = Uri.parse('https://content.dropboxapi.com/2/files/upload');
    final response = await httpClient.post(
      uri,
      headers: {
        'Authorization': 'Bearer $_dropboxToken',
        'Content-Type': 'application/octet-stream',
        'Dropbox-API-Arg': jsonEncode({'path': '/$filename', 'mode': 'add', 'autorename': true}),
      },
      body: await file.readAsBytes(),
    );
    _log('Dropbox upload status ${response.statusCode}');
    return response.statusCode >= 200 && response.statusCode < 300;
  }

  Future<int?> _quotaGoogle() async {
    final uri = Uri.parse('https://www.googleapis.com/drive/v3/about?fields=storageQuota');
    final res = await httpClient.get(uri, headers: {'Authorization': 'Bearer $_googleToken'});
    if (res.statusCode == 200) {
      final data = jsonDecode(res.body) as Map<String, dynamic>;
      final quota = data['storageQuota'] as Map<String, dynamic>?;
      if (quota != null) {
        final limit = int.tryParse(quota['limit']?.toString() ?? '0') ?? 0;
        final usage = int.tryParse(quota['usage']?.toString() ?? '0') ?? 0;
        return limit - usage;
      }
    }
    return null;
  }

  Future<int?> _quotaOneDrive() async {
    final uri = Uri.parse('https://graph.microsoft.com/v1.0/me/drive');
    final res = await httpClient.get(uri, headers: {'Authorization': 'Bearer $_oneDriveToken'});
    if (res.statusCode == 200) {
      final data = jsonDecode(res.body) as Map<String, dynamic>;
      final quota = data['quota'] as Map<String, dynamic>?;
      if (quota != null) {
        final remaining = int.tryParse(quota['remaining']?.toString() ?? '0');
        return remaining;
      }
    }
    return null;
  }

  Future<int?> _quotaDropbox() async {
    final uri = Uri.parse('https://api.dropboxapi.com/2/users/get_space_usage');
    final res = await httpClient.post(uri, headers: {
      'Authorization': 'Bearer $_dropboxToken',
      'Content-Type': 'application/json',
    });
    if (res.statusCode == 200) {
      final data = jsonDecode(res.body) as Map<String, dynamic>;
      final allocation = data['allocation'] as Map<String, dynamic>?;
      final allocated = int.tryParse(allocation?['allocated']?.toString() ?? '0') ?? 0;
      final used = int.tryParse(data['used']?.toString() ?? '0') ?? 0;
      return allocated - used;
    }
    return null;
  }

  /// Log typé pour debug uniquement
  void _log(String message) {
    assert(() {
      debugPrint('[CloudDrive] $message');
      return true;
    }());
  }
}
