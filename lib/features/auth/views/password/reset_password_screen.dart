// lib/features/auth/views/reset_password_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reliance/features/auth/controllers/auth_viewmodel.dart'; // Changed import
import 'package:reliance/l10n/app_localizations.dart';

class ResetPasswordScreen extends StatelessWidget {
  final String token; // Token received from deep link

  const ResetPasswordScreen({super.key, required this.token});

  @override
  Widget build(BuildContext context) {
    // Change Provider type to AuthViewModel
    final authViewModel = Provider.of<AuthViewModel>(context);
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(localizations.resetPasswordTitle)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Display the token (for debugging/info)
            Text(
              'Resetting password for token: $token',
              style: const TextStyle(fontSize: 12),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: authViewModel.resetPasswordNewPasswordController,
              decoration: InputDecoration(
                labelText: localizations.newPasswordHint,
                suffixIcon: IconButton(
                  icon: Icon(
                    authViewModel.obscureResetPassword
                        ? Icons.visibility
                        : Icons.visibility_off,
                  ),
                  onPressed: authViewModel.toggleResetPasswordVisibility,
                ),
              ),
              obscureText: authViewModel.obscureResetPassword,
            ),
            const SizedBox(height: 16),
            TextField(
              controller:
                  authViewModel.resetPasswordConfirmNewPasswordController,
              decoration: InputDecoration(
                labelText: localizations.confirmNewPasswordHint,
                suffixIcon: IconButton(
                  icon: Icon(
                    authViewModel.obscureConfirmResetPassword
                        ? Icons.visibility
                        : Icons.visibility_off,
                  ),
                  onPressed: authViewModel.toggleConfirmResetPasswordVisibility,
                ),
              ),
              obscureText: authViewModel.obscureConfirmResetPassword,
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
                    onPressed: () =>
                        authViewModel.resetPassword(context, token),
                    child: Text(localizations.resetPasswordButton),
                  ),
          ],
        ),
      ),
    );
  }
}
