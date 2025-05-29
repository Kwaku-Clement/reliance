import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:reliance/core/router/app_router.dart';
import 'package:reliance/core/services/auth_service.dart';
import 'package:reliance/features/auth/controllers/base_auth_viewmodel.dart';
import 'package:reliance/l10n/app_localizations.dart';

enum OtpFlowType { registration, passwordReset, transactionVerification, login }

class OtpVerificationViewModel extends BaseAuthViewModel {
  final AuthService _authService;
  final AppRouter _appRouter;

  String _verificationId = '';
  String _destination = '';
  OtpFlowType _flowType = OtpFlowType.registration;
  final TextEditingController _otpController = TextEditingController();

  OtpVerificationViewModel(this._authService, Logger logger, this._appRouter)
    : super(logger);

  TextEditingController get otpController => _otpController;
  String get destination => _destination;

  void initialize({
    required String verificationId,
    required String destination,
    required OtpFlowType flowType,
  }) {
    if (isDisposed) return;
    _verificationId = verificationId;
    _destination = destination;
    _flowType = flowType;
    logger.i(
      'OTP Verification ViewModel initialized for $_flowType to $_destination',
    );
    safeNotifyListeners();
  }

  Future<void> verifyOtp(BuildContext context) async {
    if (isDisposed || isLoading) return;
    final localizations = AppLocalizations.of(context)!;

    if (_otpController.text.isEmpty || _otpController.text.length != 6) {
      error = localizations.invalidOtp;
      return;
    }

    updateLoading(true);
    clearError();

    try {
      Map<String, dynamic> response;
      if (_flowType == OtpFlowType.registration) {
        response = await _authService.verifyRegistrationOtp(
          verificationId: _verificationId,
          otp: _otpController.text,
        );
      } else if (_flowType == OtpFlowType.passwordReset) {
        response = await _authService.verifyPasswordResetOtp(
          verificationId: _verificationId,
          otp: _otpController.text,
        );
        _appRouter.go('/reset-password/${response['token']}');
      } else if (_flowType == OtpFlowType.transactionVerification) {
        response = await _authService.verifyTransactionOtp(
          verificationId: _verificationId,
          otp: _otpController.text,
        );
        _appRouter.pop();
      } else {
        response = await _authService.verifyLoginOtp(
          verificationId: _verificationId,
          otp: _otpController.text,
        );
      }
      if (isDisposed) return;

      logger.i(localizations.otpVerificationSuccess);
      _otpController.clear();

      if (_flowType == OtpFlowType.registration ||
          _flowType == OtpFlowType.login) {
        _appRouter.go('/home');
      }
    } catch (e) {
      if (isDisposed) return;
      error = localizations.otpVerificationFailed(formatAuthError(context, e));
    } finally {
      updateLoading(false);
    }
  }

  Future<void> resendOtp(BuildContext context) async {
    if (isDisposed || isLoading) return;
    final localizations = AppLocalizations.of(context)!;

    updateLoading(true);
    clearError();

    try {
      Map<String, dynamic> response;
      if (_flowType == OtpFlowType.registration) {
        response = await _authService.resendRegistrationOtp(
          destination: _destination,
        );
      } else if (_flowType == OtpFlowType.passwordReset) {
        response = await _authService.resendPasswordResetOtp(
          destination: _destination,
        );
      } else if (_flowType == OtpFlowType.transactionVerification) {
        response = await _authService.resendTransactionOtp(
          destination: _destination,
        );
      } else {
        response = await _authService.sendLoginOtp(destination: _destination);
      }
      if (isDisposed) return;

      logger.i(localizations.otpResent);
      _verificationId = response['verificationId'];
      safeNotifyListeners();
    } catch (e) {
      if (isDisposed) return;
      error = localizations.otpResendFailed(formatAuthError(context, e));
    } finally {
      updateLoading(false);
    }
  }

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }
}
