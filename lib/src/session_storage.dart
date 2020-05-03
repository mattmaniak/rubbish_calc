import 'package:flutter/services.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Save and load user's credentials safely to provide auto login.
class SessionStorage {
  static const _storage = FlutterSecureStorage();
  static const String _emailKey = 'email';
  static const String _passwordKey = 'password';
  static bool _isPasswordAccessEnabled = true;

  /// Previously signed in user's email.
  static Future<String> get email async =>
      await _storage.read(key: 'email') ?? '';

  /// Previously signed in user's password.
  ///
  /// For the security reasons, it can be accessed only once after each save.
  /// The purpose is to prevent an unauthorized access which may be any apart
  /// from an auto login attempt at the app startup.
  static Future<String> get password async {
    if (!_isPasswordAccessEnabled) {
      return '';
    }
    _isPasswordAccessEnabled = false;
    return await _storage.read(key: 'password') ?? '';
  }

  /// Remove all credentials.
  ///
  /// Traditionally performed in the case of an sign out.
  static Future<void> clear() async {
    try {
      await _storage.deleteAll();
    } on PlatformException {
      return;
    }
  }

  /// Save an email to the secure storage.
  static Future<void> saveEmail(String email) async {
    if ((email != null) && email.isNotEmpty) {
      await _storage.write(key: _emailKey, value: email);
    }
  }

  /// Save a password to the secure storage enable a one-time access to it.
  static Future<void> savePassword(String password) async {
    if ((password != null) && password.isNotEmpty) {
      await _storage.write(key: _passwordKey, value: password);
      _isPasswordAccessEnabled = true;
    }
  }
}
