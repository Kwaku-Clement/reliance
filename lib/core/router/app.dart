import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart'; // Import GoRouter
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:get_it/get_it.dart'; // Import GetIt
import 'package:reliance/core/router/app_router.dart'; // Import AppRouter
import 'package:reliance/core/theme/app_theme.dart';
import 'package:reliance/core/theme/theme_controller.dart';
import 'package:reliance/features/home/widgets/privacy_overlay.dart';
import 'package:reliance/l10n/app_localizations.dart';

class RelianceApp extends StatefulWidget {
  // Removed isAuthenticated as AppRouter's redirect will handle this
  const RelianceApp({super.key});

  @override
  State<RelianceApp> createState() => _RelianceAppState();
}

class _RelianceAppState extends State<RelianceApp> with WidgetsBindingObserver {
  bool _isAppPaused = false;
  late final GoRouter _router; // Now correctly initialized from AppRouter
  late final Logger logger;

  @override
  void initState() {
    super.initState();
    logger = GetIt.I.get<Logger>(); // Use GetIt.I
    WidgetsBinding.instance.addObserver(this);
    logger.i('RelianceApp initialized.');

    // Get the GoRouter instance from the AppRouter singleton
    _router = GetIt.I.get<AppRouter>().router;

    // We no longer need the complex initial setup logic here.
    // The GoRouter's redirect will handle initial navigation.
    // However, we still need to ensure AppLocalizations is available in GetIt
    // if other ViewModels depend on it outside of a Widget build method.
    // The safest way to do this *once* is still via addPostFrameCallback.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final appLocalizations = AppLocalizations.of(context);
      // Ensure it's not already registered before registering
      if (appLocalizations != null &&
          !GetIt.I.isRegistered<AppLocalizations>()) {
        GetIt.I.registerSingleton<AppLocalizations>(appLocalizations);
        logger.d('AppLocalizations registered in GetIt.');
      }
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    // No need to dispose _router here if AppRouter manages its lifecycle
    // and it's a singleton.
    logger.i('RelianceApp disposed.');
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    setState(() {
      _isAppPaused = (state == AppLifecycleState.paused);
    });
    logger.d('AppLifecycleState changed: $state, _isAppPaused: $_isAppPaused');
  }

  @override
  Widget build(BuildContext context) {
    final ThemeMode themeMode = context.watch<ThemeController>().themeMode;

    return MaterialApp.router(
      title: 'Reliance',
      routerConfig: _router, // Use the GoRouter from AppRouter
      debugShowCheckedModeBanner: false, // Added for clarity
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeMode,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations
          .supportedLocales, // Use the supportedLocales from AppLocalizations
      builder: (context, child) {
        return Stack(
          children: [child!, if (_isAppPaused) const PrivacyOverlay()],
        );
      },
    );
  }
}
