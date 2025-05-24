import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:get_it/get_it.dart';
import '../utils/secure_storage_service.dart';

class ThemeController extends ChangeNotifier {
  final SecureStorageService _secureStorageService;
  final Logger _logger;

  ThemeController(this._secureStorageService)
    : _logger = GetIt.I.get<Logger>() {
    // Get logger from GetIt
    _loadThemeMode();
  }

  ThemeMode _themeMode = ThemeMode.system;
  static const String _themeKey = 'theme_mode';

  ThemeMode get themeMode => _themeMode;

  Future<void> _loadThemeMode() async {
    try {
      final storedTheme = await _secureStorageService.readAppSetting(_themeKey);
      if (storedTheme == 'light') {
        _themeMode = ThemeMode.light;
      } else if (storedTheme == 'dark') {
        _themeMode = ThemeMode.dark;
      } else {
        _themeMode =
            ThemeMode.system; // Default to system if not set or invalid
      }
      _logger.i('Loaded theme mode: $_themeMode');
      notifyListeners();
    } catch (e) {
      _logger.e('Error loading theme mode: $e');
    }
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    if (_themeMode == mode) return; // No change needed

    _themeMode = mode;
    String themeString;
    switch (mode) {
      case ThemeMode.light:
        themeString = 'light';
        break;
      case ThemeMode.dark:
        themeString = 'dark';
        break;
      case ThemeMode.system:
        themeString = 'system';
        break;
    }
    await _secureStorageService.writeAppSetting(_themeKey, themeString);
    _logger.i('Set theme mode to: $_themeMode');
    notifyListeners();
  }
}
