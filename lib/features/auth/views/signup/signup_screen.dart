// lib/features/auth/views/register_screen.dart
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:provider/provider.dart';
import 'package:reliance/features/auth/views/signup/signup_viewmodel.dart';
import 'package:reliance/l10n/app_localizations.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Change Provider type to RegistrationViewModel
    final registrationViewModel = Provider.of<RegisterViewModel>(context);
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(localizations.registerButton)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: registrationViewModel
                    .fullNameController, // Use RegistrationViewModel's controller
                decoration: InputDecoration(
                  labelText: localizations.fullNameHint,
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: registrationViewModel
                    .emailController, // Use RegistrationViewModel's controller
                decoration: InputDecoration(
                  labelText: localizations
                      .emailHint, // Changed to emailHint for clarity, if available
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),
              InternationalPhoneNumberInput(
                textFieldController: registrationViewModel
                    .phoneController, // Use RegistrationViewModel's controller
                onInputChanged: registrationViewModel
                    .onPhoneNumberChanged, // Use RegistrationViewModel's method
                onInputValidated: registrationViewModel
                    .onPhoneNumberValidated, // Use RegistrationViewModel's method
                selectorConfig: const SelectorConfig(
                  selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                ),
                initialValue: registrationViewModel
                    .phoneNumber, // Use RegistrationViewModel's property
                inputDecoration: InputDecoration(
                  labelText:
                      localizations.phoneNumberHint, // Using localization
                  border: const OutlineInputBorder(),
                ),
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: registrationViewModel
                    .passwordController, // Use RegistrationViewModel's controller
                decoration: InputDecoration(
                  labelText: localizations.passwordHint,
                  suffixIcon: IconButton(
                    icon: Icon(
                      registrationViewModel
                              .obscurePassword // Use RegistrationViewModel's property
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: registrationViewModel
                        .togglePasswordVisibility, // Use RegistrationViewModel's method
                  ),
                ),
                obscureText: registrationViewModel
                    .obscurePassword, // Use RegistrationViewModel's property
              ),
              const SizedBox(height: 16),
              TextField(
                controller: registrationViewModel
                    .confirmPasswordController, // Use RegistrationViewModel's controller
                decoration: InputDecoration(
                  labelText: localizations.confirmPasswordHint,
                  suffixIcon: IconButton(
                    icon: Icon(
                      registrationViewModel
                              .obscureConfirmPassword // Use RegistrationViewModel's property
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: registrationViewModel
                        .toggleConfirmPasswordVisibility, // Use RegistrationViewModel's method
                  ),
                ),
                obscureText: registrationViewModel
                    .obscureConfirmPassword, // Use RegistrationViewModel's property
              ),
              if (registrationViewModel.error !=
                  null) // Access error from RegistrationViewModel
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Text(
                    registrationViewModel.error!,
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
              const SizedBox(height: 16),
              registrationViewModel
                      .isLoading // Access isLoading from RegistrationViewModel
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: () => registrationViewModel.register(
                        context,
                      ), // Use RegistrationViewModel's method
                      child: Text(localizations.registerButton),
                    ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () => registrationViewModel
                    .navigateToLogin(), // Use RegistrationViewModel's method
                child: Text(localizations.loginButton),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
