import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart'; // Import provider
import 'package:reliance/core/injection.dart';
import 'package:reliance/core/router/app.dart';
import 'package:reliance/core/theme/theme_controller.dart'; // Import ThemeController
import 'package:reliance/features/auth/controllers/auth_viewmodel.dart'; // Import AuthViewModel

final GetIt getIt = GetIt.instance;

/// Main entry point of the Flutter application.
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await setupDependencies();

  // Fix: Provide ThemeController and AuthViewModel at the root of the widget tree
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeController>(
          create: (context) =>
              getIt.get<ThemeController>(), // Get instance from GetIt
        ),
        ChangeNotifierProvider<AuthViewModel>(
          create: (context) =>
              getIt.get<AuthViewModel>(), // Get instance from GetIt
        ),
        // Add other global providers here if needed, e.g., SettingsController
      ],
      child: const RelianceApp(),
    ),
  );
}
