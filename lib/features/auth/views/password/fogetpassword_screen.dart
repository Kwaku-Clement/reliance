// lib/features/auth/views/forgot_password_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reliance/features/auth/controllers/auth_viewmodel.dart'; // Changed import
import 'package:reliance/l10n/app_localizations.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Change Provider type to AuthViewModel
    final authViewModel = Provider.of<AuthViewModel>(context);
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(localizations.forgotPasswordTitle)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: authViewModel.forgotPasswordEmailController,
              decoration: InputDecoration(
                labelText: localizations.emailOrPhoneHint,
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            if (authViewModel.error != null) // Access error from authViewModel
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Text(
                  authViewModel.error!,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            const SizedBox(height: 16),
            authViewModel
                    .isLoading // Access isLoading from authViewModel
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: () => authViewModel.forgotPassword(context),
                    child: Text(localizations.sendResetLinkButton),
                  ),
          ],
        ),
      ),
    );
  }
}
