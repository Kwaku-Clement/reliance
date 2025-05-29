import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:reliance/core/router/app_router.dart';
import 'package:reliance/core/services/auth_service.dart';
import 'package:reliance/features/auth/controllers/base_auth_viewmodel.dart';
import 'package:reliance/l10n/app_localizations.dart';

class LoginViewModel extends BaseAuthViewModel {
  final AuthService _authService;
  final AppRouter _appRouter;

  final TextEditingController _emailOrPhoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscureLoginPassword = true;

  LoginViewModel(this._authService, Logger logger, this._appRouter)
    : super(logger);

  TextEditingController get emailOrPhoneController => _emailOrPhoneController;
  TextEditingController get passwordController => _passwordController;
  bool get obscureLoginPassword => _obscureLoginPassword;

  void toggleLoginPasswordVisibility() {
    if (isDisposed) return;
    _obscureLoginPassword = !_obscureLoginPassword;
    safeNotifyListeners();
  }

  Future<void> login(BuildContext context) async {
    if (isDisposed || isLoading) return;
    final localizations = AppLocalizations.of(context)!;

    if (_emailOrPhoneController.text.trim().isEmpty ||
        _passwordController.text.isEmpty) {
      error = localizations.requiredField;
      return;
    }

    updateLoading(true);
    clearError();

    try {
      await _authService.login(
        emailOrPhone: _emailOrPhoneController.text.trim(),
        password: _passwordController.text,
      );
      if (isDisposed) return;

      logger.i(localizations.loginSuccess);
      _passwordController.clear();
      _appRouter.go('/home');
    } catch (e) {
      if (isDisposed) return;
      error = formatAuthError(context, e);
    } finally {
      updateLoading(false);
    }
  }

  void navigateToRegister() {
    if (isDisposed) return;
    _appRouter.go('/register');
  }

  void navigateToForgotPassword() {
    if (isDisposed) return;
    _appRouter.go('/forgot-password');
  }

  @override
  void dispose() {
    _emailOrPhoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
