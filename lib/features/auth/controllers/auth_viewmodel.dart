// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:reliance/core/router/app_router.dart';
import 'package:reliance/core/services/auth_service.dart';
import 'package:reliance/features/auth/controllers/base_auth_viewmodel.dart';
import 'package:reliance/l10n/app_localizations.dart';

class AuthViewModel extends BaseAuthViewModel {
  final AuthService _authService;
  final AppRouter _appRouter;

  AuthViewModel(this._authService, Logger logger, this._appRouter)
    : super(logger);

  final TextEditingController _changePasswordOldController =
      TextEditingController();
  final TextEditingController _changePasswordNewController =
      TextEditingController();
  final TextEditingController _changePasswordConfirmNewController =
      TextEditingController();
  bool _obscureOldPassword = true;
  bool _obscureNewPassword = true;
  bool _obscureConfirmNewPassword = true;

  TextEditingController get changePasswordOldController =>
      _changePasswordOldController;
  TextEditingController get changePasswordNewController =>
      _changePasswordNewController;
  TextEditingController get changePasswordConfirmNewController =>
      _changePasswordConfirmNewController;
  bool get obscureOldPassword => _obscureOldPassword;
  bool get obscureNewPassword => _obscureNewPassword;
  bool get obscureConfirmNewPassword => _obscureConfirmNewPassword;

  void toggleOldPasswordVisibility() {
    if (isDisposed) return;
    _obscureOldPassword = !_obscureOldPassword;
    safeNotifyListeners();
  }

  void toggleNewPasswordVisibility() {
    if (isDisposed) return;
    _obscureNewPassword = !_obscureNewPassword;
    safeNotifyListeners();
  }

  void toggleConfirmNewPasswordVisibility() {
    if (isDisposed) return;
    _obscureConfirmNewPassword = !_obscureConfirmNewPassword;
    safeNotifyListeners();
  }

  Future<void> changePassword(BuildContext context) async {
    if (isDisposed || isLoading) return;
    final localizations = AppLocalizations.of(context)!;

    clearError();

    if (_changePasswordOldController.text.isEmpty ||
        _changePasswordNewController.text.isEmpty ||
        _changePasswordConfirmNewController.text.isEmpty) {
      error = localizations.requiredField;
      return;
    }

    if (_changePasswordNewController.text !=
        _changePasswordConfirmNewController.text) {
      error = localizations.passwordsDoNotMatch;
      return;
    }
    if (_changePasswordNewController.text.length < 8) {
      error = localizations.passwordLengthError;
      return;
    }

    updateLoading(true);
    try {
      final String? currentEmailOrPhone = await _authService
          .getCurrentUserIdentifier();
      if (currentEmailOrPhone == null) {
        throw Exception('User identifier not found for password change.');
      }

      await _authService.changePassword(
        emailOrPhone: currentEmailOrPhone,
        oldPassword: _changePasswordOldController.text,
        newPassword: _changePasswordNewController.text,
      );
      if (isDisposed) return;

      logger.i(localizations.passwordChangeSuccess);
      _changePasswordOldController.clear();
      _changePasswordNewController.clear();
      _changePasswordConfirmNewController.clear();
      _appRouter.pop();
    } catch (e) {
      if (isDisposed) return;
      error = formatAuthError(context, e);
    } finally {
      updateLoading(false);
    }
  }

  final TextEditingController _forgotPasswordEmailController =
      TextEditingController();

  TextEditingController get forgotPasswordEmailController =>
      _forgotPasswordEmailController;

  Future<void> forgotPassword(BuildContext context) async {
    if (isDisposed || isLoading) return;
    final localizations = AppLocalizations.of(context)!;
    clearError();

    if (_forgotPasswordEmailController.text.trim().isEmpty ||
        !RegExp(
          r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
        ).hasMatch(_forgotPasswordEmailController.text.trim())) {
      error = localizations.invalidEmail;
      return;
    }

    updateLoading(true);
    try {
      await _authService.forgotPassword(
        email: _forgotPasswordEmailController.text.trim(),
      );
      if (isDisposed) return;

      logger.i(localizations.resetLinkSent);
      _appRouter.go('/login');
    } catch (e) {
      if (isDisposed) return;
      error = formatAuthError(context, e);
    } finally {
      updateLoading(false);
    }
  }

  final TextEditingController _resetPasswordNewPasswordController =
      TextEditingController();
  final TextEditingController _resetPasswordConfirmNewPasswordController =
      TextEditingController();
  bool _obscureResetPassword = true;
  bool _obscureConfirmResetPassword = true;

  TextEditingController get resetPasswordNewPasswordController =>
      _resetPasswordNewPasswordController;
  TextEditingController get resetPasswordConfirmNewPasswordController =>
      _resetPasswordConfirmNewPasswordController;
  bool get obscureResetPassword => _obscureResetPassword;
  bool get obscureConfirmResetPassword => _obscureConfirmResetPassword;

  void toggleResetPasswordVisibility() {
    if (isDisposed) return;
    _obscureResetPassword = !_obscureResetPassword;
    safeNotifyListeners();
  }

  void toggleConfirmResetPasswordVisibility() {
    if (isDisposed) return;
    _obscureConfirmResetPassword = !_obscureConfirmResetPassword;
    safeNotifyListeners();
  }

  Future<void> resetPassword(BuildContext context, String token) async {
    if (isDisposed || isLoading) return;
    final localizations = AppLocalizations.of(context)!;

    clearError();

    if (_resetPasswordNewPasswordController.text.isEmpty ||
        _resetPasswordConfirmNewPasswordController.text.isEmpty) {
      error = localizations.requiredField;
      return;
    }

    if (_resetPasswordNewPasswordController.text !=
        _resetPasswordConfirmNewPasswordController.text) {
      error = localizations.passwordsDoNotMatch;
      return;
    }
    if (_resetPasswordNewPasswordController.text.length < 8) {
      error = localizations.passwordLengthError;
      return;
    }

    updateLoading(true);
    try {
      await _authService.resetPassword(
        token: token,
        newPassword: _resetPasswordNewPasswordController.text,
      );
      if (isDisposed) return;

      logger.i(localizations.passwordResetSuccess);
      _resetPasswordNewPasswordController.clear();
      _resetPasswordConfirmNewPasswordController.clear();
      _appRouter.go('/login');
    } catch (e) {
      if (isDisposed) return;
      error = formatAuthError(context, e);
    } finally {
      updateLoading(false);
    }
  }

  final TextEditingController _setPasscodeController = TextEditingController();
  final TextEditingController _setConfirmPasscodeController =
      TextEditingController();
  bool _obscurePasscode = true;
  bool _obscureConfirmPasscode = true;

  TextEditingController get setPasscodeController => _setPasscodeController;
  TextEditingController get setConfirmPasscodeController =>
      _setConfirmPasscodeController;
  bool get obscurePasscode => _obscurePasscode;
  bool get obscureConfirmPasscode => _obscureConfirmPasscode;

  void togglePasscodeVisibility() {
    if (isDisposed) return;
    _obscurePasscode = !_obscurePasscode;
    safeNotifyListeners();
  }

  void toggleConfirmPasscodeVisibility() {
    if (isDisposed) return;
    _obscureConfirmPasscode = !_obscureConfirmPasscode;
    safeNotifyListeners();
  }

  Future<void> setPasscode(BuildContext context) async {
    if (isDisposed || isLoading) return;
    final localizations = AppLocalizations.of(context)!;

    clearError();

    if (_setPasscodeController.text.isEmpty ||
        _setConfirmPasscodeController.text.isEmpty) {
      error = localizations.requiredField;
      return;
    }

    if (_setPasscodeController.text.length != 4 ||
        !RegExp(r'^[0-9]+$').hasMatch(_setPasscodeController.text)) {
      error = localizations.passcodeLengthError;
      return;
    }

    if (_setPasscodeController.text != _setConfirmPasscodeController.text) {
      error = localizations.passcodesDoNotMatch;
      return;
    }

    updateLoading(true);
    try {
      await _authService.setPasscode(passcode: _setPasscodeController.text);
      if (isDisposed) return;

      logger.i(localizations.passcodeSetSuccess);
      _setPasscodeController.clear();
      _setConfirmPasscodeController.clear();
      _appRouter.go('/profile-setup');
    } catch (e) {
      if (isDisposed) return;
      error = formatAuthError(context, e);
    } finally {
      updateLoading(false);
    }
  }

  bool _isIdScanned = false;
  bool _isFaceScanned = false;

  bool get isIdScanned => _isIdScanned;
  bool get isFaceScanned => _isFaceScanned;

  Future<void> scanIdCard(BuildContext context) async {
    if (isDisposed || isLoading) return;
    final localizations = AppLocalizations.of(context)!;

    clearError();

    updateLoading(true);
    try {
      final success = await _authService.scanIdCard();
      if (isDisposed) return;

      if (success) {
        _isIdScanned = true;
        logger.i(localizations.idScanSuccess);
      } else {
        error = localizations.idScanFailed;
      }
      safeNotifyListeners();
    } catch (e) {
      if (isDisposed) return;
      error = formatAuthError(context, e);
    } finally {
      updateLoading(false);
    }
  }

  Future<void> scanFace(BuildContext context) async {
    if (isDisposed || isLoading) return;
    final localizations = AppLocalizations.of(context)!;

    clearError();

    updateLoading(true);
    try {
      final success = await _authService.scanFace();
      if (isDisposed) return;

      if (success) {
        _isFaceScanned = true;
        logger.i(localizations.faceScanSuccess);
      } else {
        error = localizations.faceScanFailed;
      }
      safeNotifyListeners();
    } catch (e) {
      if (isDisposed) return;
      error = formatAuthError(context, e);
    } finally {
      updateLoading(false);
    }
  }

  Future<void> completeProfileSetup(BuildContext context) async {
    if (isDisposed || isLoading) return;
    final localizations = AppLocalizations.of(context)!;

    clearError();

    if (!_isIdScanned || !_isFaceScanned) {
      error = localizations.loginFailed(
        'Please complete both ID Card and Face scans.',
      );
      return;
    }

    updateLoading(true);
    try {
      await _authService.markProfileComplete();
      if (isDisposed) return;

      logger.i('Profile setup complete. Navigating to Home.');
      _appRouter.go('/home');
    } catch (e) {
      if (isDisposed) return;
      error = formatAuthError(context, e);
    } finally {
      updateLoading(false);
    }
  }

  Future<bool> checkAuthStatus() async {
    return await _authService.isLoggedIn();
  }

  Future<void> startInitialSetupFlow() async {
    if (isDisposed) return;

    final loggedIn = await _authService.isLoggedIn();

    if (_authService.isInitialSetupRequired()) {
      logger.i('Initial profile setup required. Navigating to /profile-setup.');
      _appRouter.go('/profile-setup');
    } else if (loggedIn) {
      logger.i('Profile complete. Navigating to /home.');
      _appRouter.go('/home');
    } else {
      logger.i('Not logged in. Navigating to /login.');
      _appRouter.go('/login');
    }
  }

  Future<void> logout() async {
    if (isDisposed || isLoading) return;
    updateLoading(true);
    try {
      await _authService.logout();
      if (isDisposed) return;
      _appRouter.go('/login');
    } catch (e) {
      if (isDisposed) return;
      logger.e('Logout failed: $e');
      await _authService.logout();
      _appRouter.go('/login');
    } finally {
      updateLoading(false);
    }
  }

  @override
  void dispose() {
    _changePasswordOldController.dispose();
    _changePasswordNewController.dispose();
    _changePasswordConfirmNewController.dispose();
    _forgotPasswordEmailController.dispose();
    _resetPasswordNewPasswordController.dispose();
    _resetPasswordConfirmNewPasswordController.dispose();
    _setPasscodeController.dispose();
    _setConfirmPasscodeController.dispose();
    super.dispose();
  }
}
