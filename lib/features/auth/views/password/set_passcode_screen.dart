// lib/features/auth/views/set_passcode_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // For input formatters
import 'package:provider/provider.dart';
import 'package:reliance/features/auth/controllers/auth_viewmodel.dart'; // Changed import
import 'package:reliance/l10n/app_localizations.dart';

class SetPasscodeScreen extends StatelessWidget {
  const SetPasscodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Change Provider type to AuthViewModel
    final authViewModel = Provider.of<AuthViewModel>(context);
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(localizations.setPasscodeTitle)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: authViewModel.setPasscodeController,
              decoration: InputDecoration(
                labelText: localizations.passcodeHint,
                suffixIcon: IconButton(
                  icon: Icon(
                    authViewModel.obscurePasscode
                        ? Icons.visibility
                        : Icons.visibility_off,
                  ),
                  onPressed: authViewModel.togglePasscodeVisibility,
                ),
              ),
              keyboardType: TextInputType.number,
              obscureText: authViewModel.obscurePasscode,
              maxLength: 4,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            ),
            const SizedBox(height: 16),
            TextField(
              controller: authViewModel.setConfirmPasscodeController,
              decoration: InputDecoration(
                labelText: localizations.confirmPasscodeHint,
                suffixIcon: IconButton(
                  icon: Icon(
                    authViewModel.obscureConfirmPasscode
                        ? Icons.visibility
                        : Icons.visibility_off,
                  ),
                  onPressed: authViewModel.toggleConfirmPasscodeVisibility,
                ),
              ),
              keyboardType: TextInputType.number,
              obscureText: authViewModel.obscureConfirmPasscode,
              maxLength: 4,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
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
                    onPressed: () => authViewModel.setPasscode(context),
                    child: Text(localizations.setPasscodeButton),
                  ),
          ],
        ),
      ),
    );
  }
}
