import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:reliance/core/theme/ap_colors.dart';

class OTPTextfield extends StatefulWidget {
  final bool hasError, canResendOTP;
  final String timeRemaining;
  final void Function()? resendOnTap;
  final void Function(String)? onChanged;
  final void Function(String)? onCompleted;

  const OTPTextfield({
    super.key,
    required this.hasError,
    required this.resendOnTap,
    required this.onChanged,
    required this.onCompleted,
    required this.canResendOTP,
    required this.timeRemaining,
  });

  @override
  State<OTPTextfield> createState() => _OTPTextfieldState();
}

class _OTPTextfieldState extends State<OTPTextfield> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomOtpField(
          hasError: widget.hasError,
          onChanged: widget.onChanged,
          onCompleted: widget.onCompleted,
        ),
        const SizedBox(height: 30),
        if (widget.canResendOTP) ...[
          Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Didn\'t get the code?'),
                // const SizedBox(width: 4),
                TextButton(
                  onPressed: widget.resendOnTap,
                  child: Text(
                    'Resend',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppColors.primaryLight,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Text(
          //   "Didn't get the code?",
          //   style: Theme.of(context).textTheme.bodySmall?.copyWith(
          //     color: Theme.of(
          //       context,
          //     ).colorScheme.onSurface.withValues(alpha: 0.6),
          //   ),
          // ),
          // TextButton(
          //   onPressed: widget.resendOnTap,
          //   style: TextButton.styleFrom(
          //     foregroundColor: Colors.blue,
          //     padding: EdgeInsets.zero,
          //     minimumSize: Size.zero,
          //     tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          //   ),
          //   child: Text(
          //     "Resend OTP",
          //     style: Theme.of(
          //       context,
          //     ).textTheme.bodySmall?.copyWith(color: Colors.blue),
          //   ),
          // ),
        ] else
          Text(
            "Resend OTP (${widget.timeRemaining})",
            style: Theme.of(context).textTheme.bodySmall,
          ),
      ],
    );
  }
}

class CustomOtpField extends StatefulWidget {
  final int? length;
  final bool hasError;
  final void Function(String)? onCompleted;
  final void Function(String)? onChanged;

  const CustomOtpField({
    super.key,
    this.length,
    required this.hasError,
    this.onChanged,
    this.onCompleted,
  });

  @override
  State<CustomOtpField> createState() => _CustomOtpFieldState();
}

class _CustomOtpFieldState extends State<CustomOtpField> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Pinput(
      length: widget.length ?? 6,
      onCompleted: widget.onCompleted,
      onChanged: widget.onChanged,
      defaultPinTheme: PinTheme(
        width: 48,
        height: 48,
        margin: const EdgeInsets.symmetric(horizontal: 4),
        textStyle: theme.textTheme.bodyLarge?.copyWith(
          fontSize: 25,
          fontWeight: FontWeight.w500,
          color: theme.colorScheme.onSurface,
        ),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.4),
              width: 1.0,
            ),
          ),
        ),
      ),
      focusedPinTheme: PinTheme(
        width: 48,
        height: 48,
        margin: const EdgeInsets.symmetric(horizontal: 4),
        textStyle: theme.textTheme.bodyLarge?.copyWith(
          fontSize: 25,
          fontWeight: FontWeight.w500,
          color: theme.colorScheme.onSurface,
        ),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: theme.colorScheme.primary, width: 1.5),
          ),
        ),
      ),
      errorPinTheme: PinTheme(
        width: 48,
        height: 48,
        margin: const EdgeInsets.symmetric(horizontal: 4),
        textStyle: theme.textTheme.bodyLarge?.copyWith(
          fontSize: 25,
          fontWeight: FontWeight.w500,
          color: theme.colorScheme.onSurface,
        ),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: theme.colorScheme.error, width: 1.5),
          ),
        ),
      ),
      hapticFeedbackType: HapticFeedbackType.lightImpact,
      cursor: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 2),
            width: 12,
            height: 1,
            color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
          ),
        ],
      ),
    );
  }
}
