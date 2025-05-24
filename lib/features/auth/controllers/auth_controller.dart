import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import '../../../core/services/auth_service.dart';
import '../models/user.dart';

class AuthController extends ChangeNotifier {
  final AuthService _authService;
  final Logger _logger;

  AuthController(this._authService, this._logger);

  bool _isLoading = false;
  String? _errorMessage; // Generic error message, UI will localize

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  User? get currentUser =>
      null; // User object will be managed by a separate UserProvider or similar in a real app

  Future<bool> login(String username, String password) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final success = await _authService.login(username, password);
      if (success) {
        _logger.i('Login successful.');
        // In a real app, you'd fetch actual user data here and update a UserProvider
        return true;
      } else {
        _errorMessage =
            'Login failed. Please check your credentials.'; // Generic error
        _logger.w('Login failed for $username');
        return false;
      }
    } catch (e) {
      _errorMessage = 'An unexpected error occurred: $e'; // Generic error
      _logger.e('Login error: $e');
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> logout() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    await _authService.logout();
    _logger.i('Logged out successfully.');

    _isLoading = false;
    notifyListeners();
  }

  Future<bool> checkAuthStatus() async {
    return await _authService.isAuthenticated();
  }
}
