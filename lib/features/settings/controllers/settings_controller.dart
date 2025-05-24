import 'package:flutter/material.dart';
import '../../../core/utils/secure_storage_service.dart';
import '../../../core/theme/theme_controller.dart';

class SettingsController extends ChangeNotifier {
  final SecureStorageService _secureStorageService;
  final ThemeController _themeController;

  SettingsController(this._secureStorageService, this._themeController);

  String? _currentAuthToken;
  String? _currentRefreshToken;

  String? get currentAuthToken => _currentAuthToken;
  String? get currentRefreshToken => _currentRefreshToken;

  ThemeMode get currentThemeMode => _themeController.themeMode;

  Future<void> loadTokens() async {
    _currentAuthToken = await _secureStorageService.readAuthToken();
    _currentRefreshToken = await _secureStorageService.readRefreshToken();
    notifyListeners();
  }

  Future<void> storeDummyTokens(String token) async {
    await _secureStorageService.writeAuthToken(token);
    await _secureStorageService.writeRefreshToken('refresh_$token');
    await loadTokens();
  }

  Future<void> clearAllTokens() async {
    await _secureStorageService.deleteAllTokens();
    await loadTokens();
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    await _themeController.setThemeMode(mode);
  }
}
