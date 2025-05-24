import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:logger/logger.dart';

class SecureStorageService {
  final FlutterSecureStorage _storage;
  final Logger _logger;

  SecureStorageService(this._logger) : _storage = const FlutterSecureStorage();

  static const _authTokenKey = 'jwt_auth_token';
  static const _refreshTokenKey = 'jwt_refresh_token';
  static const _appSettingsPrefix = 'app_setting_';

  // --- Authentication Token Methods ---
  Future<void> writeAuthToken(String token) async {
    try {
      await _storage.write(key: _authTokenKey, value: token);
      _logger.i('Auth Token written successfully.');
    } catch (e) {
      _logger.e('Error writing auth token: $e');
    }
  }

  Future<String?> readAuthToken() async {
    try {
      final token = await _storage.read(key: _authTokenKey);
      _logger.i('Auth Token read: ${token != null ? 'Exists' : 'None'}');
      return token;
    } catch (e) {
      _logger.e('Error reading auth token: $e');
      return null;
    }
  }

  Future<void> deleteAuthToken() async {
    try {
      await _storage.delete(key: _authTokenKey);
      _logger.i('Auth Token deleted.');
    } catch (e) {
      _logger.e('Error deleting auth token: $e');
    }
  }

  Future<void> writeRefreshToken(String token) async {
    try {
      await _storage.write(key: _refreshTokenKey, value: token);
      _logger.i('Refresh Token written successfully.');
    } catch (e) {
      _logger.e('Error writing refresh token: $e');
    }
  }

  Future<String?> readRefreshToken() async {
    try {
      final token = await _storage.read(key: _refreshTokenKey);
      _logger.i('Refresh Token read: ${token != null ? 'Exists' : 'None'}');
      return token;
    } catch (e) {
      _logger.e('Error reading refresh token: $e');
      return null;
    }
  }

  Future<void> deleteRefreshToken() async {
    try {
      await _storage.delete(key: _refreshTokenKey);
      _logger.i('Refresh Token deleted.');
    } catch (e) {
      _logger.e('Error deleting refresh token: $e');
    }
  }

  Future<void> deleteAllTokens() async {
    try {
      await _storage.delete(key: _authTokenKey);
      await _storage.delete(key: _refreshTokenKey);
      _logger.i('All authentication tokens deleted.');
    } catch (e) {
      _logger.e('Error deleting all authentication tokens: $e');
    }
  }

  // --- New: App Settings Methods ---
  Future<void> writeAppSetting(String key, String value) async {
    try {
      await _storage.write(key: '$_appSettingsPrefix$key', value: value);
      _logger.i('App setting "$key" written successfully.');
    } catch (e) {
      _logger.e('Error writing app setting "$key": $e');
    }
  }

  Future<String?> readAppSetting(String key) async {
    try {
      final value = await _storage.read(key: '$_appSettingsPrefix$key');
      _logger.i(
        'App setting "$key" read: ${value != null ? 'Exists' : 'None'}',
      );
      return value;
    } catch (e) {
      _logger.e('Error reading app setting "$key": $e');
      return null;
    }
  }

  Future<void> deleteAppSetting(String key) async {
    try {
      await _storage.delete(key: '$_appSettingsPrefix$key');
      _logger.i('App setting "$key" deleted.');
    } catch (e) {
      _logger.e('Error deleting app setting "$key": $e');
    }
  }
}
