import 'package:flutter/material.dart';
import 'package:reliance/core/widgets/app_button.dart';

class ShowConfirmPhoneNumberDialog extends StatelessWidget {
  final String phoneNumber;
  final VoidCallback onConfirm;
  const ShowConfirmPhoneNumberDialog({
    super.key,
    required this.phoneNumber,
    required this.onConfirm,
  });
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      // backgroundColor: Theme.of(context).colorScheme.surface,
      contentPadding: const EdgeInsets.all(16.0),
      // title: Text('Confirm Phone Number'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Text(
              'Confirm Phone Number',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
          SizedBox(height: 8.0),
          Center(
            child: Text(
              'Is this your phone number? $phoneNumber',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          SizedBox(height: 16.0),
          AppButton(
            onPressed: onConfirm,
            text: 'Yes',
            type: AppButtonType.primary,
          ),
          SizedBox(height: 8.0),
          AppButton(
            onPressed: () => Navigator.of(context).pop(),
            text: 'No',
            type: AppButtonType.outline,
          ),
        ],
      ),
    );
  }
}
