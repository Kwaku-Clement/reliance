// reliance/features/auth/controllers/base_auth_viewmodel.dart
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:reliance/l10n/app_localizations.dart';

/// A base class for authentication-related ViewModels to share common state and logic.
///
/// Provides loading state, error handling, and safe notification of listeners.
abstract class BaseAuthViewModel extends ChangeNotifier {
  final Logger logger;

  // Private state variables
  bool _isLoading = false;
  String? _error;
  bool _isDisposed = false; // Kept private, only internal logic should set this

  BaseAuthViewModel(this.logger);

  /// Getter for the current loading state.
  bool get isLoading => _isLoading;

  /// Getter for the current error message.
  String? get error => _error;

  /// Getter to check if the ViewModel has been disposed.
  bool get isDisposed => _isDisposed;

  /// Updates the loading state and safely notifies listeners.
  @protected
  void updateLoading(bool value) {
    if (_isLoading != value) {
      // Use private field here
      _isLoading = value; // Use private field here
      safeNotifyListeners();
    }
  }

  /// Sets an error message and safely notifies listeners.
  @protected
  set error(String? message) {
    // Setter for error, allows subclasses to assign
    if (_error != message) {
      _error = message;
      safeNotifyListeners();
    }
  }

  /// Clears any existing error message and safely notifies listeners.
  void clearError() {
    if (_isDisposed || _error == null) return;
    _error = null;
    safeNotifyListeners();
  }

  /// Formats a dynamic error object into a user-friendly string using localizations.
  @protected
  String formatAuthError(BuildContext context, dynamic e) {
    final localizations = AppLocalizations.of(context)!;
    logger.e('Auth ViewModel Error: $e');
    final message = e.toString();
    if (message.startsWith('Exception: ')) {
      return message.replaceFirst('Exception: ', '');
    }
    return localizations.loginFailed(message);
  }

  /// Notifies listeners only if the ViewModel has not been disposed.
  /// Prevents calling `notifyListeners` on a disposed object, which causes errors.
  @protected
  void safeNotifyListeners() {
    if (!_isDisposed) {
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _isDisposed = true; // Set dispose flag to private field
    super.dispose();
  }
}
