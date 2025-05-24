import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:reliance/core/injection.dart';
import 'package:reliance/l10n/app_localizations.dart';

// GetIt DI setup
import 'core/theme/app_theme.dart';
import 'core/theme/theme_controller.dart';

// Features - Controllers (ChangeNotifiers)
import 'features/auth/controllers/auth_controller.dart';
import 'features/home/controllers/home_controller.dart';
import 'features/payment/controllers/payment_controller.dart';
import 'features/settings/controllers/settings_controller.dart';

// Features - Views
import 'features/auth/views/login_screen.dart';
import 'features/home/views/home_screen.dart';
import 'features/payment/views/payment_screen.dart';
import 'features/settings/views/settings_screen.dart';
import 'features/home/widgets/privacy_overlay.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Setup GetIt for dependency injection
  setupGetIt();

  // Check initial authentication status
  final bool isAuthenticated = await getIt
      .get<AuthController>()
      .checkAuthStatus();

  runApp(
    MultiProvider(
      providers: [
        // Provide GetIt-managed ChangeNotifiers to the widget tree using ChangeNotifierProvider
        ChangeNotifierProvider<AuthController>(
          create: (_) => getIt<AuthController>(),
        ),
        ChangeNotifierProvider<HomeController>(
          create: (_) => getIt<HomeController>(),
        ),
        ChangeNotifierProvider<PaymentController>(
          create: (_) => getIt<PaymentController>(),
        ),
        ChangeNotifierProvider<SettingsController>(
          create: (_) => getIt<SettingsController>(),
        ),
        ChangeNotifierProvider<ThemeController>(
          create: (_) => getIt<ThemeController>(),
        ),
      ],
      child: RelianceApp(isAuthenticated: isAuthenticated),
    ),
  );
}

class RelianceApp extends StatefulWidget {
  final bool isAuthenticated;
  const RelianceApp({super.key, required this.isAuthenticated});

  @override
  State<RelianceApp> createState() => _RelianceAppState();
}

class _RelianceAppState extends State<RelianceApp> with WidgetsBindingObserver {
  bool _isAppPaused = false;
  late final GoRouter _router;
  late final Logger _logger;

  @override
  void initState() {
    super.initState();
    _logger = getIt<Logger>();
    WidgetsBinding.instance.addObserver(this);
    _logger.i('App initialized.');

    _router = GoRouter(
      initialLocation: widget.isAuthenticated ? '/home' : '/',
      routes: [
        GoRoute(path: '/', builder: (context, state) => const LoginScreen()),
        GoRoute(path: '/home', builder: (context, state) => const HomeScreen()),
        GoRoute(
          path: '/payment',
          builder: (context, state) => const PaymentScreen(),
        ),
        GoRoute(
          path: '/settings',
          builder: (context, state) => const SettingsScreen(),
        ),
      ],
      redirect: (context, state) async {
        final bool loggedIn = await getIt
            .get<AuthController>()
            .checkAuthStatus();
        final bool loggingIn = state.matchedLocation == '/';

        if (!loggedIn && !loggingIn) {
          return '/';
        }
        if (loggedIn && loggingIn) {
          return '/home';
        }
        return null;
      },
      refreshListenable: getIt.get<AuthController>(),
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _router.dispose();
    _logger.i('App disposed.');
    // Explicitly dispose GetIt singletons if needed for complete cleanup (e.g., in tests)
    // For a typical app lifecycle, Flutter's process termination handles this.
    // getIt.reset(); // Uncomment if you need to aggressively reset GetIt on app dispose
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    setState(() {
      _isAppPaused = (state == AppLifecycleState.paused);
    });
    _logger.d('AppLifecycleState changed: $state, _isAppPaused: $_isAppPaused');
  }

  @override
  Widget build(BuildContext context) {
    final ThemeMode themeMode = context.watch<ThemeController>().themeMode;

    return MaterialApp.router(
      title: 'Reliance',
      routerConfig: _router,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeMode,

      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('en', ''), Locale('fr', '')],
      builder: (context, child) {
        return Stack(
          children: [child!, if (_isAppPaused) const PrivacyOverlay()],
        );
      },
    );
  }
}
