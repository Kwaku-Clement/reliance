import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reliance/features/user/controllers/scan_face_viewmodel.dart';
import 'package:reliance/l10n/app_localizations.dart';

class ScanFaceScreen extends StatelessWidget {
  const ScanFaceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.scanFaceTitle), // e.g., "Scan Face"
      ),
      body: Consumer<ScanFaceViewModel>(
        builder: (context, viewModel, child) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  localizations
                      .scanFaceDescription, // e.g., "Take a clear selfie for verification."
                  style: Theme.of(context).textTheme.titleMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                Expanded(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (viewModel.faceImagePath == null)
                          Icon(
                            Icons.face,
                            size: 80,
                            color: Theme.of(context).disabledColor,
                          )
                        else
                          ClipOval(
                            // Display circular image
                            child: Image.file(
                              viewModel.faceImagePath!,
                              height: 180,
                              width: 180,
                              fit: BoxFit.cover,
                            ),
                          ),
                        const SizedBox(height: 16),
                        ElevatedButton.icon(
                          onPressed: viewModel.isLoading
                              ? null
                              : () => viewModel.takeSelfie(context),
                          icon: const Icon(Icons.camera_alt),
                          label: Text(
                            localizations.takeSelfieButton,
                          ), // e.g., "Take Selfie"
                        ),
                      ],
                    ),
                  ),
                ),
                if (viewModel.error != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Text(
                      viewModel.error!,
                      style: const TextStyle(color: Colors.red),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ElevatedButton(
                  onPressed: viewModel.isLoading
                      ? null
                      : () => viewModel.submitFaceScan(context),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: Text(
                    localizations.completeSetupButton,
                  ), // e.g., "Complete Setup"
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
