// lib/features/auth/views/login_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reliance/features/auth/views/login/login_viewmodel.dart';
import 'package:reliance/l10n/app_localizations.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Access the LoginViewModel provided by GoRouter
    final loginViewModel = Provider.of<LoginViewModel>(context);
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(localizations.loginButton)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: loginViewModel.emailOrPhoneController,
                decoration: InputDecoration(
                  labelText: localizations.emailOrPhoneHint,
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: loginViewModel.passwordController,
                decoration: InputDecoration(
                  labelText: localizations.passwordHint,
                  suffixIcon: IconButton(
                    icon: Icon(
                      loginViewModel.obscureLoginPassword
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: loginViewModel.toggleLoginPasswordVisibility,
                  ),
                ),
                obscureText: loginViewModel.obscureLoginPassword,
              ),
              if (loginViewModel.error != null)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Text(
                    loginViewModel.error!,
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
              const SizedBox(height: 16),
              loginViewModel.isLoading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: () => loginViewModel.login(context),
                      child: Text(localizations.loginButton),
                    ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () => loginViewModel.navigateToForgotPassword(),
                child: Text(localizations.forgotPassword),
              ),
              TextButton(
                onPressed: () => loginViewModel.navigateToRegister(),
                child: Text(
                  "${localizations.noAccountText} ${localizations.registerLink}",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
