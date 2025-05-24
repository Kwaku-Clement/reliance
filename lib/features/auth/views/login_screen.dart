import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reliance/l10n/app_localizations.dart';
import '../../../core/services/auth_service.dart';
import '../controllers/auth_controller.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/theme/app_text_styles.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController(
    text: AuthService.dummyUsername,
  );
  final TextEditingController _passwordController = TextEditingController(
    text: AuthService.dummyPassword,
  );

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations localizations = AppLocalizations.of(context)!;
    final AuthController authController = context.watch<AuthController>();

    // Localized error message based on generic message from controller
    String? localizedErrorMessage;
    if (authController.errorMessage != null) {
      if (authController.errorMessage!.contains('Login failed')) {
        localizedErrorMessage = localizations.loginFailed;
      } else {
        localizedErrorMessage =
            localizations.unexpectedError; // Catch-all for other errors
      }
    }

    return Scaffold(
      appBar: AppBar(title: Text(localizations.appTitle)),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.account_balance_wallet,
                size: 80,
                color: Colors.blue,
              ),
              const SizedBox(height: 30),
              Text(
                localizations.welcomeMessage,
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: localizations.usernameHint,
                  prefixIcon: const Icon(Icons.person),
                ),
                keyboardType: TextInputType.emailAddress,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: localizations.passwordHint,
                  prefixIcon: const Icon(Icons.lock),
                ),
                obscureText: true,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              if (localizedErrorMessage != null)
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(
                    localizedErrorMessage,
                    style: AppTextStyles.errorLight.copyWith(
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),
                ),
              const SizedBox(height: 30),
              AppButton(
                text: localizations.loginButton,
                onPressed: () async {
                  final success = await authController.login(
                    _usernameController.text,
                    _passwordController.text,
                  );
                  if (success) {
                    if (mounted) {
                      context.go('/home');
                    }
                  }
                },
                isLoading: authController.isLoading,
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(localizations.forgotPassword)),
                  );
                },
                child: Text(localizations.forgotPassword),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
