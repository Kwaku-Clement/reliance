import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:logger/logger.dart';
import 'package:reliance/core/router/app_router.dart';
import 'package:reliance/core/services/auth_service.dart';
import 'package:reliance/features/auth/controllers/base_auth_viewmodel.dart';
import 'package:reliance/features/auth/views/otp/otp_verification_viewmodel.dart';
import 'package:reliance/l10n/app_localizations.dart';

class RegisterViewModel extends BaseAuthViewModel {
  final AuthService _authService;
  final AppRouter _appRouter;

  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  PhoneNumber _phoneNumber = PhoneNumber(isoCode: 'GH');
  bool _isPhoneValid = false;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  RegisterViewModel(this._authService, Logger logger, this._appRouter)
    : super(logger);

  TextEditingController get fullNameController => _fullNameController;
  TextEditingController get emailController => _emailController;
  TextEditingController get phoneController => _phoneController;
  TextEditingController get passwordController => _passwordController;
  TextEditingController get confirmPasswordController =>
      _confirmPasswordController;

  PhoneNumber get phoneNumber => _phoneNumber;
  bool get isPhoneValid => _isPhoneValid;
  bool get obscurePassword => _obscurePassword;
  bool get obscureConfirmPassword => _obscureConfirmPassword;

  void togglePasswordVisibility() {
    if (isDisposed) return;
    _obscurePassword = !_obscurePassword;
    safeNotifyListeners();
  }

  void toggleConfirmPasswordVisibility() {
    if (isDisposed) return;
    _obscureConfirmPassword = !_obscureConfirmPassword;
    safeNotifyListeners();
  }

  void onPhoneNumberChanged(PhoneNumber number) {
    if (isDisposed) return;
    _phoneNumber = number;
    safeNotifyListeners();
  }

  void onPhoneNumberValidated(bool isValid) {
    if (isDisposed) return;
    _isPhoneValid = isValid;
    safeNotifyListeners();
  }

  Future<void> register(BuildContext context) async {
    if (isDisposed || isLoading) return;
    final localizations = AppLocalizations.of(context)!;
    clearError();

    if (_fullNameController.text.trim().isEmpty ||
        _emailController.text.trim().isEmpty ||
        _passwordController.text.isEmpty ||
        _phoneNumber.phoneNumber == null ||
        !_isPhoneValid) {
      error = localizations.requiredField;
      return;
    }

    if (_passwordController.text != _confirmPasswordController.text) {
      error = localizations.passwordsDoNotMatch;
      return;
    }

    if (_passwordController.text.length < 8) {
      error = localizations.passwordLengthError;
      return;
    }

    if (!RegExp(
      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
    ).hasMatch(_emailController.text.trim())) {
      error = localizations.invalidEmail;
      return;
    }

    updateLoading(true);

    try {
      final response = await _authService.registerUser(
        fullName: _fullNameController.text.trim(),
        email: _emailController.text.trim(),
        password: _passwordController.text,
        phone: _phoneNumber.phoneNumber!.trim(),
        address: null,
      );
      if (isDisposed) return;

      logger.i(localizations.registrationSuccess);
      _fullNameController.clear();
      _emailController.clear();
      _phoneController.clear();
      _passwordController.clear();
      _confirmPasswordController.clear();

      _appRouter.pushNamed(
        'otp-verification',
        extra: {
          'verificationId': response['verificationId'],
          'destination': _emailController.text.trim().isNotEmpty
              ? _emailController.text.trim()
              : _phoneNumber.phoneNumber!.trim(),
          'flowType': OtpFlowType.registration,
        },
      );
    } catch (e) {
      if (isDisposed) return;
      error = formatAuthError(context, e);
    } finally {
      updateLoading(false);
    }
  }

  void navigateToLogin() {
    if (isDisposed) return;
    _appRouter.go('/login');
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}
