// lib/features/auth/views/change_password_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reliance/features/auth/controllers/auth_viewmodel.dart'; // Changed import
import 'package:reliance/l10n/app_localizations.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Change Provider type to AuthViewModel
    final authViewModel = Provider.of<AuthViewModel>(context);
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(localizations.changePasswordTitle)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: authViewModel.changePasswordOldController,
              decoration: InputDecoration(
                labelText: localizations.oldPasswordHint,
                suffixIcon: IconButton(
                  icon: Icon(
                    authViewModel.obscureOldPassword
                        ? Icons.visibility
                        : Icons.visibility_off,
                  ),
                  onPressed: authViewModel.toggleOldPasswordVisibility,
                ),
              ),
              obscureText: authViewModel.obscureOldPassword,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: authViewModel.changePasswordNewController,
              decoration: InputDecoration(
                labelText: localizations.newPasswordHint,
                suffixIcon: IconButton(
                  icon: Icon(
                    authViewModel.obscureNewPassword
                        ? Icons.visibility
                        : Icons.visibility_off,
                  ),
                  onPressed: authViewModel.toggleNewPasswordVisibility,
                ),
              ),
              obscureText: authViewModel.obscureNewPassword,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: authViewModel.changePasswordConfirmNewController,
              decoration: InputDecoration(
                labelText: localizations.confirmNewPasswordHint,
                suffixIcon: IconButton(
                  icon: Icon(
                    authViewModel.obscureConfirmNewPassword
                        ? Icons.visibility
                        : Icons.visibility_off,
                  ),
                  onPressed: authViewModel.toggleConfirmNewPasswordVisibility,
                ),
              ),
              obscureText: authViewModel.obscureConfirmNewPassword,
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
                    onPressed: () => authViewModel.changePassword(context),
                    child: Text(localizations.changePasswordButton),
                  ),
          ],
        ),
      ),
    );
  }
}
