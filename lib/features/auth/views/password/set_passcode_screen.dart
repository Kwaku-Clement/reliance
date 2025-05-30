import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reliance/features/auth/controllers/auth_viewmodel.dart';
import 'package:reliance/l10n/app_localizations.dart';

class SetPasscodeScreen extends StatelessWidget {
  const SetPasscodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(localizations.setPasscodeTitle)),
      body: Consumer<AuthViewModel>(
        builder: (context, viewModel, child) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  localizations.setPasscodeDescription,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 24),
                TextField(
                  controller: viewModel.setPasscodeController,
                  decoration: InputDecoration(
                    labelText: localizations.passcodeLabel,
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(
                        viewModel.obscurePasscode
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: viewModel.togglePasscodeVisibility,
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  obscureText: viewModel.obscurePasscode,
                  maxLength: 4,
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: viewModel.setConfirmPasscodeController,
                  decoration: InputDecoration(
                    labelText: localizations.confirmPasscodeLabel,
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(
                        viewModel.obscureConfirmPasscode
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: viewModel.toggleConfirmPasscodeVisibility,
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  obscureText: viewModel.obscureConfirmPasscode,
                  maxLength: 4,
                ),
                const SizedBox(height: 24),
                if (viewModel.error != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Text(
                      viewModel.error!,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
                ElevatedButton(
                  onPressed: viewModel.isLoading
                      ? null
                      : () => viewModel.setPasscode(context),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: Text(
                    localizations.confirmButtonText,
                  ), // e.g., "Confirm"
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
