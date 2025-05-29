import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reliance/features/user/controllers/scan_id_viewmodel.dart';
import 'package:reliance/l10n/app_localizations.dart';

class ScanIdScreen extends StatelessWidget {
  const ScanIdScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(localizations.scanIdTitle)),
      body: Consumer<ScanIdViewModel>(
        builder: (context, viewModel, child) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  localizations
                      .scanIdDescription, // e.g., "Please scan the front and back of your ID."
                  style: Theme.of(context).textTheme.titleMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                Expanded(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (viewModel.idFrontImagePath == null)
                          Icon(
                            Icons.camera_alt,
                            size: 80,
                            color: Theme.of(context).disabledColor,
                          )
                        else
                          Image.file(
                            viewModel.idFrontImagePath!,
                            height: 150,
                            fit: BoxFit.cover,
                          ),
                        const SizedBox(height: 16),
                        ElevatedButton.icon(
                          onPressed: viewModel.isLoading
                              ? null
                              : () => viewModel.pickIdFront(context),
                          icon: const Icon(Icons.camera_alt),
                          label: Text(
                            localizations.scanIdFrontButton,
                          ), // e.g., "Scan ID Front"
                        ),
                        const SizedBox(height: 24),
                        if (viewModel.idBackImagePath == null)
                          Icon(
                            Icons.camera_alt,
                            size: 80,
                            color: Theme.of(context).disabledColor,
                          )
                        else
                          Image.file(
                            viewModel.idBackImagePath!,
                            height: 150,
                            fit: BoxFit.cover,
                          ),
                        const SizedBox(height: 16),
                        ElevatedButton.icon(
                          onPressed: viewModel.isLoading
                              ? null
                              : () => viewModel.pickIdBack(context),
                          icon: const Icon(Icons.camera_alt),
                          label: Text(
                            localizations.scanIdBackButton,
                          ), // e.g., "Scan ID Back"
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
                      : () => viewModel.submitIdScans(context),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: Text(localizations.nextButtonText), // e.g., "Next"
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
