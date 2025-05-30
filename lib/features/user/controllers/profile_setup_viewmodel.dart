import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:reliance/core/router/app_router.dart';
import 'package:reliance/core/services/auth_service.dart';
import 'package:reliance/features/auth/controllers/base_auth_viewmodel.dart';
import 'package:reliance/l10n/app_localizations.dart';

/// Manages the initial user profile setup flow, including ID/Face scans and finalization.
///
/// This ViewModel ensures that critical profile steps are completed before full app access.
class ProfileSetupViewModel extends BaseAuthViewModel {
  final AuthService _authService;
  final AppRouter _appRouter;

  // --- State for tracking setup steps completion ---
  bool _isIdScanned = false;
  bool _isFaceScanned = false;

  /// Getters for scan status.
  bool get isIdScanned => _isIdScanned;
  bool get isFaceScanned => _isFaceScanned;

  /// Constructor: Injects dependencies for AuthService, Logger, and AppRouter.
  ProfileSetupViewModel(this._authService, Logger logger, this._appRouter)
    : super(logger); // Pass logger to base class

  // --- Public Methods ---

  /// Simulates or initiates the ID card scanning process.
  ///
  /// In a real app, this would involve launching a native ID scanning SDK.
  Future<void> scanIdCard(BuildContext context) async {
    if (isDisposed || isLoading) return;

    final localizations = AppLocalizations.of(context)!;

    updateLoading(true); // Use inherited method
    clearError(); // Use inherited method

    try {
      final success = await _authService.scanIdCard(); // Call the service
      if (isDisposed) return; // Use inherited getter

      if (success) {
        _isIdScanned = true;
        logger.i(localizations.idScanSuccess); // Use inherited logger
      } else {
        error = localizations.idScanFailed; // Use inherited setter
      }
      safeNotifyListeners(); // Use inherited method
    } catch (e) {
      if (isDisposed) return; // Use inherited getter
      error = formatAuthError(context, e); // Use inherited setter and method
    } finally {
      updateLoading(false); // Use inherited method
    }
  }

  /// Simulates or initiates the face scanning (e.g., for liveness/biometric verification).
  ///
  /// In a real app, this would involve launching a native face recognition SDK.
  Future<void> scanFace(BuildContext context) async {
    if (isDisposed || isLoading) return;

    final localizations = AppLocalizations.of(context)!;
    // Use GetIt for localizations

    updateLoading(true); // Use inherited method
    clearError(); // Use inherited method

    try {
      final success = await _authService.scanFace(); // Call the service
      if (isDisposed) return; // Use inherited getter

      if (success) {
        _isFaceScanned = true;
        logger.i(localizations.faceScanSuccess); // Use inherited logger
      } else {
        error = localizations.faceScanFailed; // Use inherited setter
      }
      safeNotifyListeners(); // Use inherited method
    } catch (e) {
      if (isDisposed) return; // Use inherited getter
      error = formatAuthError(context, e); // Use inherited setter and method
    } finally {
      updateLoading(false); // Use inherited method
    }
  }

  /// Handles the final step of profile setup, marking it as complete.
  ///
  /// This should only be called once all mandatory steps (e.g., scans) are done.
  Future<void> completeProfileSetup(BuildContext context) async {
    if (isDisposed || isLoading) return;
    final localizations = AppLocalizations.of(context)!;

    // --- Validation: Ensure all prerequisite steps are completed ---
    if (!_isIdScanned || !_isFaceScanned) {
      error = localizations.loginFailed(
        'Please complete all required scans.',
      ); // Reusing general error, consider specific localization
      return;
    }

    updateLoading(true); // Use inherited method
    clearError(); // Use inherited method

    try {
      await _authService
          .markProfileComplete(); // Mark profile as complete in AuthService
      if (isDisposed) return; // Use inherited getter

      logger.i(
        'Profile setup complete. Navigating to Home.',
      ); // Use inherited logger
      // After successfully completing profile setup, navigate to the main app screen
      _appRouter.go('/home'); // Use AppRouter.go()
    } catch (e) {
      if (isDisposed) return; // Use inherited getter
      error = formatAuthError(context, e); // Use inherited setter and method
    } finally {
      updateLoading(false); // Use inherited method
    }
  }

  /// Navigates to the set passcode screen, typically part of the initial setup flow.
  void navigateToSetPasscode() {
    if (isDisposed) return; // Use inherited getter
    _appRouter.go('/set-passcode'); // Use AppRouter.go()
  }
}
