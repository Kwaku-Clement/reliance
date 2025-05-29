import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:reliance/core/router/app_router.dart';
import 'package:reliance/core/services/auth_service.dart';
import 'package:reliance/core/widgets/app_button.dart';
import 'package:reliance/core/widgets/otp_textfield_widget.dart';
import 'package:reliance/features/auth/views/otp/otp_verification_viewmodel.dart';
import 'package:reliance/l10n/app_localizations.dart';

class OtpVerificationScreen extends StatefulWidget {
  final String verificationId;
  final String destination;
  final OtpFlowType flowType;

  const OtpVerificationScreen({
    super.key,
    required this.verificationId,
    required this.destination,
    required this.flowType,
  });

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  late final OtpVerificationViewModel _viewModel;
  Timer? _timer;
  int _seconds = 120;
  bool _canResendOtp = false;
  String _timeRemaining = '2:00';

  @override
  void initState() {
    super.initState();
    // Initialize ViewModel using GetIt for dependencies
    _viewModel = OtpVerificationViewModel(
      GetIt.I.get<AuthService>(),
      GetIt.I.get<Logger>(),
      GetIt.I.get<AppRouter>(),
    );

    // Initialize ViewModel with passed parameters
    _viewModel.initialize(
      verificationId: widget.verificationId,
      destination: widget.destination,
      flowType: widget.flowType,
    );

    // Start countdown for resend OTP
    _startCountdown();
  }

  void _startCountdown() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        // Added mounted check
        if (_seconds == 0) {
          timer.cancel();
          setState(() {
            _canResendOtp = true;
          });
        } else {
          _seconds--;
          final minutes = _seconds ~/ 60;
          final seconds = _seconds % 60;
          setState(() {
            _timeRemaining = '$minutes:${seconds < 10 ? '0$seconds' : seconds}';
          });
        }
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // It's generally better to get localizations via Provider or context extension if available,
    // but GetIt is fine if AppLocalizations is registered as a singleton.
    final localizations = AppLocalizations.of(context)!;
    ;
    return ListenableBuilder(
      listenable: _viewModel,
      builder: (context, child) {
        return Scaffold(
          appBar: AppBar(
            // When user can go back, a simple pop is appropriate
            leading: IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(Icons.arrow_back_ios),
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Text(
                    localizations.confirmYourPhone,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    localizations.otpSentTo(widget.destination),
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 16),
                  OTPTextfield(
                    hasError: _viewModel.error != null, // Access public getter
                    resendOnTap: _canResendOtp
                        ? () async {
                            await _viewModel.resendOtp(context);
                            // Only reset countdown if resend was successful (error is null)
                            if (_viewModel.error == null && mounted) {
                              setState(() {
                                _seconds = 120;
                                _canResendOtp = false;
                                _timeRemaining = '2:00';
                              });
                              _startCountdown();
                            }
                          }
                        : null,
                    onChanged: (value) {
                      // VERIFICATION FIX: Update error logic to clear error only if valid length
                      if (_viewModel.error != null && value.length == 6) {
                        _viewModel
                            .clearError(); // Call clearError through ViewModel
                      } else if (value.length < 6) {
                        // Optionally set a local error for incomplete input without affecting ViewModel's global error
                        // For simplicity, we'll let ViewModel handle validation on verify.
                      }
                    },
                    onCompleted: (value) {
                      _viewModel.otpController.text = value;
                      // VERIFICATION FIX: Immediately verify on complete if no error
                      if (_viewModel.error == null) {
                        _viewModel.verifyOtp(context);
                      }
                    },
                    canResendOTP: _canResendOtp,
                    timeRemaining: _timeRemaining,
                  ),
                  if (_viewModel.error != null) ...[
                    const SizedBox(height: 8),
                    Text(
                      _viewModel.error!, // Access public getter
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.error,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
          bottomNavigationBar: Container(
            padding: const EdgeInsets.all(16),
            child: AppButton(
              text: localizations.verifyYourNumber,
              // VERIFICATION FIX: Access public getter
              isActive: !_viewModel.isLoading && _viewModel.error == null,
              // VERIFICATION FIX: Access public getter
              onPressed: _viewModel.isLoading
                  ? null
                  : () async {
                      FocusScope.of(context).unfocus();
                      await _viewModel.verifyOtp(context);
                    },
            ),
          ),
        );
      },
    );
  }
}
