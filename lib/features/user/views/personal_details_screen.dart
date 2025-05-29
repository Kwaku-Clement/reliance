import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reliance/features/user/controllers/personal_details_viewmodel.dart';
import 'package:reliance/l10n/app_localizations.dart'; // Assuming you have this

class PersonalDetailsScreen extends StatefulWidget {
  const PersonalDetailsScreen({super.key});

  @override
  State<PersonalDetailsScreen> createState() => _PersonalDetailsScreenState();
}

class _PersonalDetailsScreenState extends State<PersonalDetailsScreen> {
  @override
  void initState() {
    super.initState();
    // It's good practice to ensure the ViewModel is ready
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<PersonalDetailsViewModel>(
        context,
        listen: false,
      ).initialize();
    });
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          localizations.personalDetailsTitle,
        ), // e.g., "Personal Details"
        // No leading back button if this is the very first step of setup
        // But if navigated from another page, a back button might be present.
      ),
      body: Consumer<PersonalDetailsViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    localizations
                        .personalDetailsDescription, // e.g., "Tell us a bit about yourself."
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 24),
                  TextField(
                    controller: viewModel.firstNameController,
                    decoration: InputDecoration(
                      labelText:
                          localizations.firstNameLabel, // e.g., "First Name"
                      border: const OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: viewModel.lastNameController,
                    decoration: InputDecoration(
                      labelText:
                          localizations.lastNameLabel, // e.g., "Last Name"
                      border: const OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: viewModel.dobController,
                    decoration: InputDecoration(
                      labelText:
                          localizations.dobLabel, // e.g., "Date of Birth"
                      hintText: 'YYYY-MM-DD',
                      border: const OutlineInputBorder(),
                    ),
                    readOnly: true,
                    onTap: () => viewModel.selectDateOfBirth(context),
                  ),
                  const SizedBox(height: 16),
                  // Example for a dropdown (e.g., Gender)
                  DropdownButtonFormField<String>(
                    value: viewModel.selectedGender,
                    decoration: InputDecoration(
                      labelText: localizations.genderLabel,
                      border: const OutlineInputBorder(),
                    ),
                    items:
                        [
                              'Male',
                              'Female',
                              'Other',
                            ] // Replace with actual options
                            .map(
                              (gender) => DropdownMenuItem(
                                value: gender,
                                child: Text(gender),
                              ),
                            )
                            .toList(),
                    onChanged: viewModel.setGender,
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
                        : () => viewModel.submitPersonalDetails(context),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: Text(localizations.nextButtonText), // e.g., "Next"
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
