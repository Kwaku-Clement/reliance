// File: app_router.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:reliance/core/services/auth_service.dart';
import 'package:reliance/features/auth/controllers/auth_viewmodel.dart';
import 'package:reliance/features/auth/views/login/login_screen.dart';
import 'package:reliance/features/auth/views/login/login_viewmodel.dart';
import 'package:reliance/features/auth/views/password/change_password_screen.dart';
import 'package:reliance/features/auth/views/password/fogetpassword_screen.dart';
import 'package:reliance/features/auth/views/password/reset_password_screen.dart';
import 'package:reliance/features/auth/views/password/set_passcode_screen.dart';
import 'package:reliance/features/auth/views/signup/signup_screen.dart';
import 'package:reliance/features/auth/views/signup/signup_viewmodel.dart';
import 'package:reliance/features/home/controllers/home_controller.dart';
import 'package:reliance/features/payment/controllers/payment_controller.dart';
import 'package:reliance/features/auth/views/otp/otp_verification_screen.dart';
import 'package:reliance/features/auth/views/otp/otp_verification_viewmodel.dart';
import 'package:reliance/features/home/views/home_screen.dart';
import 'package:reliance/features/payment/views/payment_screen.dart';
import 'package:reliance/features/settings/controllers/settings_controller.dart';
import 'package:reliance/features/settings/views/settings_screen.dart';
import 'package:reliance/features/splash/landing_page.dart';
import 'package:reliance/features/splash/splash_screen.dart';
import 'package:reliance/features/user/controllers/profile_setup_viewmodel.dart';
import 'package:reliance/features/user/views/profile_setup_screen.dart';

class AppRouter {
  final AuthService _authService;

  AppRouter(this._authService);

  late final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        name: 'splash',
        builder: (BuildContext context, GoRouterState state) =>
            const SplashScreen(),
      ),
      GoRoute(
        path: '/landing',
        name: 'landing',
        builder: (BuildContext context, GoRouterState state) =>
            const LandingPage(),
      ),
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (BuildContext context, GoRouterState state) =>
            ChangeNotifierProvider(
              create: (_) => GetIt.I.get<LoginViewModel>(),
              child: const LoginScreen(),
            ),
      ),
      GoRoute(
        path: '/register',
        name: 'register',
        builder: (BuildContext context, GoRouterState state) =>
            ChangeNotifierProvider(
              create: (_) => GetIt.I.get<RegisterViewModel>(),
              child: const SignUpScreen(),
            ),
      ),
      GoRoute(
        path: '/forgot-password',
        name: 'forgot-password',
        builder: (BuildContext context, GoRouterState state) =>
            ChangeNotifierProvider(
              create: (_) => GetIt.I.get<AuthViewModel>(),
              child: const ForgotPasswordScreen(),
            ),
      ),
      GoRoute(
        path: '/reset-password/:token',
        name: 'reset-password',
        builder: (BuildContext context, GoRouterState state) {
          final token = state.pathParameters['token']!;
          return ChangeNotifierProvider(
            create: (_) => GetIt.I.get<AuthViewModel>(),
            child: ResetPasswordScreen(token: token),
          );
        },
      ),

      GoRoute(
        path: '/settings',
        name: 'settings',
        builder: (BuildContext context, GoRouterState state) {
          return ChangeNotifierProvider(
            create: (_) => GetIt.I.get<SettingsController>(),
            child: SettingsScreen(),
          );
        },
      ),

      GoRoute(
        path: '/otp-verification',
        name: 'otp-verification',
        builder: (BuildContext context, GoRouterState state) {
          final Map<String, dynamic> args = state.extra as Map<String, dynamic>;
          final String verificationId = args['verificationId'];
          final String destination = args['destination'];
          final OtpFlowType flowType = args['flowType'];
          return ChangeNotifierProvider(
            create: (_) => GetIt.I.get<OtpVerificationViewModel>(),
            child: OtpVerificationScreen(
              verificationId: verificationId,
              destination: destination,
              flowType: flowType,
            ),
          );
        },
      ),
      GoRoute(
        path: '/profile-setup',
        name: 'profile-setup',
        builder: (BuildContext context, GoRouterState state) =>
            ChangeNotifierProvider(
              create: (_) => GetIt.I.get<ProfileSetupViewModel>(),
              child: const ProfileSetupScreen(),
            ),
        routes: <RouteBase>[
          GoRoute(
            path: 'set-passcode',
            name: 'set-passcode',
            builder: (BuildContext context, GoRouterState state) =>
                ChangeNotifierProvider(
                  create: (_) => GetIt.I.get<AuthViewModel>(),
                  child: const SetPasscodeScreen(),
                ),
          ),
          GoRoute(
            path: 'scan-id',
            name: 'scan-id',
            builder: (BuildContext context, GoRouterState state) =>
                const Text('ID Scan Placeholder Screen'),
          ),
          GoRoute(
            path: 'scan-face',
            name: 'scan-face',
            builder: (BuildContext context, GoRouterState state) =>
                const Text('Face Scan Placeholder Screen'),
          ),
        ],
      ),
      GoRoute(
        path: '/home',
        name: 'home',
        builder: (BuildContext context, GoRouterState state) =>
            ChangeNotifierProvider(
              create: (_) => GetIt.I.get<HomeController>(),
              child: const HomeScreen(),
            ),
        routes: <RouteBase>[
          GoRoute(
            path: 'payment',
            name: 'payment',
            builder: (BuildContext context, GoRouterState state) =>
                ChangeNotifierProvider(
                  create: (_) => GetIt.I.get<PaymentController>(),
                  child: const PaymentScreen(),
                ),
          ),
          GoRoute(
            path: 'change-password',
            name: 'change-password',
            builder: (BuildContext context, GoRouterState state) =>
                ChangeNotifierProvider(
                  create: (_) => GetIt.I.get<AuthViewModel>(),
                  child: const ChangePasswordScreen(),
                ),
          ),
        ],
      ),
    ],
    redirect: (BuildContext context, GoRouterState state) async {
      final loggedIn = await _authService.isLoggedIn();
      final isInitialSetupRequired = _authService.isInitialSetupRequired();

      final isLoginPath = state.fullPath == '/login';
      final isRegisterPath = state.fullPath == '/register';
      final isForgotPasswordPath = state.fullPath == '/forgot-password';
      final isResetPasswordPath = state.fullPath!.startsWith('/reset-password');
      final isOtpVerificationPath = state.fullPath == '/otp-verification';
      final isLandingPath = state.fullPath == '/landing';
      final isAuthPath =
          isLoginPath ||
          isRegisterPath ||
          isForgotPasswordPath ||
          isResetPasswordPath ||
          isOtpVerificationPath ||
          isLandingPath;

      final isProfileSetupPath =
          state.fullPath == '/profile-setup' ||
          state.fullPath!.startsWith('/profile-setup/');

      // 1. If on splash screen, let it load normally
      if (state.fullPath == '/') {
        return null;
      }

      // 2. If not logged in:
      //    - Allow access to login, register, forgot/reset password, OTP verification, and landing page
      //    - Redirect to landing for any other protected route
      if (!loggedIn) {
        return isAuthPath ? null : '/landing';
      }

      // 3. If logged in:
      //    a. If initial setup is required:
      //       - Allow access to profile setup paths
      //       - Redirect to profile setup for any other path
      if (isInitialSetupRequired) {
        return isProfileSetupPath ? null : '/profile-setup';
      }

      //    b. If initial setup is NOT required:
      //       - Prevent access to auth paths (including landing) and profile setup
      //       - Redirect to home for these paths
      if (isAuthPath || isProfileSetupPath) {
        return '/home';
      }

      // 4. No redirect needed
      return null;
    },
    refreshListenable: _authService,
  );

  // Directly expose GoRouter's core methods for full control
  void go(String path) => router.go(path);
  void goNamed(
    String name, {
    Map<String, String> pathParameters = const {},
    Map<String, dynamic> queryParameters = const {},
    Object? extra,
  }) => router.goNamed(
    name,
    pathParameters: pathParameters,
    queryParameters: queryParameters,
    extra: extra,
  );

  void push(String path) => router.push(path);
  void pushNamed(
    String name, {
    Map<String, String> pathParameters = const {},
    Map<String, dynamic> queryParameters = const {},
    Object? extra,
  }) => router.pushNamed(
    name,
    pathParameters: pathParameters,
    queryParameters: queryParameters,
    extra: extra,
  );

  void pop() => router.pop();

  // ----- Navigation methods based on your requirements -----

  // Clear stack and go to home (used after successful login/registration/profile setup)
  void navigateToHomeAndClearStack() => router.goNamed('home');
  void navigateToLandingAndClearStack() =>
      router.goNamed('landing'); // useful for logout scenarios

  // Maintain stack (pushNamed) for general navigation that allows going back
  void navigateToLogin() => router.pushNamed('login');
  void navigateToRegister() => router.pushNamed('register');
  void navigateToForgotPassword() => router.pushNamed('forgot-password');
  void navigateToResetPassword(String token) =>
      router.pushNamed('reset-password', pathParameters: {'token': token});

  // Profile setup navigation - PUSH to profile setup, PUSH for internal steps
  void navigateToProfileSetup() => router.pushNamed('profile-setup');
  void navigateToSetPasscode() => router.pushNamed('set-passcode');
  void navigateToScanId() => router.pushNamed('scan-id');
  void navigateToScanFace() => router.pushNamed('scan-face');

  // Other in-app navigations
  void navigateToPayment() => router.pushNamed('payment');
  void navigateToChangePassword() => router.pushNamed('change-password');
  void navigateToOtpVerification({
    required String verificationId,
    required String destination,
    required OtpFlowType flowType,
  }) {
    router.pushNamed(
      'otp-verification',
      extra: {
        'verificationId': verificationId,
        'destination': destination,
        'flowType': flowType,
      },
    );
  }
}
