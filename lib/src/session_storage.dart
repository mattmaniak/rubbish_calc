import 'package:flutter/services.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SessionStorage {
  static const _storage = FlutterSecureStorage();
  static const String _emailKey = 'email';
  static const String _passwordKey = 'password';
  static bool _isPasswordAccessEnabled = true;

  static Future<String> get email async =>
      await _storage.read(key: 'email') ?? '';

  static Future<String> get password async {
    if (_isPasswordAccessEnabled) {
      return await _storage.read(key: 'password') ?? '';
    } else {
      return '';
    }
  }

  static Future<void> clear() async {
    try {
      await _storage.deleteAll();
    } on PlatformException {
      return;
    }
  }

  static Future<void> saveEmail(String email) async {
    if ((email != null) && email.isNotEmpty) {
      await _storage.write(key: _emailKey, value: email);
    }
  }

  static Future<void> savePassword(String password) async {
    if ((password != null) && password.isNotEmpty) {
      await _storage.write(key: _passwordKey, value: password);
      _isPasswordAccessEnabled = true;
    }
  }
}
