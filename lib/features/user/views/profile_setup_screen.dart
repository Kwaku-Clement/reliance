// lib/features/auth/views/profile_setup_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reliance/features/user/controllers/profile_setup_viewmodel.dart'
    show ProfileSetupViewModel;
import 'package:reliance/l10n/app_localizations.dart';

class ProfileSetupScreen extends StatelessWidget {
  const ProfileSetupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final profileSetupViewModel = Provider.of<ProfileSetupViewModel>(context);
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(localizations.profileSetupTitle)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome! Please complete your profile setup to continue.',
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            // ID Scan Section
            ListTile(
              leading: Icon(
                profileSetupViewModel.isIdScanned
                    ? Icons.check_circle
                    : Icons.credit_card,
                color: profileSetupViewModel.isIdScanned ? Colors.green : null,
              ),
              title: Text(localizations.scanIdCardButton),
              trailing: profileSetupViewModel.isIdScanned
                  ? const Icon(Icons.done, color: Colors.green)
                  : null,
              onTap:
                  profileSetupViewModel.isLoading ||
                      profileSetupViewModel.isIdScanned
                  ? null
                  : () => profileSetupViewModel.scanIdCard(context),
            ),
            if (profileSetupViewModel.isLoading &&
                !profileSetupViewModel.isIdScanned)
              const LinearProgressIndicator(),
            const SizedBox(height: 16),

            // Face Scan Section
            ListTile(
              leading: Icon(
                profileSetupViewModel.isFaceScanned
                    ? Icons.check_circle
                    : Icons.face,
                color: profileSetupViewModel.isFaceScanned
                    ? Colors.green
                    : null,
              ),
              title: Text(localizations.scanFaceButton),
              trailing: profileSetupViewModel.isFaceScanned
                  ? const Icon(Icons.done, color: Colors.green)
                  : null,
              onTap:
                  profileSetupViewModel.isLoading ||
                      profileSetupViewModel.isFaceScanned
                  ? null
                  : () => profileSetupViewModel.scanFace(context),
            ),
            if (profileSetupViewModel.isLoading &&
                !profileSetupViewModel.isFaceScanned)
              const LinearProgressIndicator(),
            const SizedBox(height: 32),

            // Set Passcode Button
            ElevatedButton(
              onPressed: () {
                profileSetupViewModel
                    .navigateToSetPasscode(); // Navigate to set passcode screen
              },
              child: Text(localizations.setPasscodeTitle),
            ),
            const SizedBox(height: 32),

            // Error Display
            if (profileSetupViewModel.error != null)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Text(
                  profileSetupViewModel.error!,
                  style: const TextStyle(color: Colors.red),
                ),
              ),

            // Complete Profile Button
            profileSetupViewModel.isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed:
                        profileSetupViewModel.isIdScanned &&
                            profileSetupViewModel.isFaceScanned
                        ? () => profileSetupViewModel.completeProfileSetup(
                            context,
                          )
                        : null, // Only enable if both scans are done
                    child: Text(localizations.completeProfileButton),
                  ),
          ],
        ),
      ),
    );
  }
}
