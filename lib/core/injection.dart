import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:reliance/core/router/app_router.dart';
import 'package:reliance/core/services/api_service.dart';
import 'package:reliance/core/services/auth_service.dart';
import 'package:reliance/core/services/biometric_service.dart';
import 'package:reliance/core/services/device_info_service.dart';
import 'package:reliance/core/services/location_service.dart';
import 'package:reliance/core/theme/theme_controller.dart';
import 'package:reliance/core/utils/secure_storage_service.dart';
import 'package:reliance/features/auth/controllers/auth_viewmodel.dart';
import 'package:reliance/features/auth/views/login/login_viewmodel.dart';
import 'package:reliance/features/auth/views/otp/otp_verification_viewmodel.dart';
import 'package:reliance/features/auth/views/signup/signup_viewmodel.dart'; // Assuming RegisterViewModel is in signup/signup_viewmodel.dart
import 'package:reliance/features/home/controllers/home_controller.dart';
import 'package:reliance/features/payment/controllers/payment_controller.dart';
import 'package:reliance/features/settings/controllers/settings_controller.dart';
import 'package:reliance/features/user/controllers/profile_setup_viewmodel.dart';
import 'package:shared_preferences/shared_preferences.dart'; // For SharedPreferences

// Core Services
final GetIt getIt = GetIt.instance;

/// Sets up all application dependencies using GetIt.
///
/// This function should be called once at the start of the application.
Future<void> setupDependencies() async {
  // --- Register Utilities & Common Components ---
  getIt.registerSingleton<Logger>(Logger());
  getIt.registerSingleton<SecureStorageService>(
    SecureStorageService(getIt<Logger>()),
  );

  // Register SharedPreferences asynchronously and wait for it to be ready.
  getIt.registerSingletonAsync<SharedPreferences>(
    () => SharedPreferences.getInstance(),
  );
  await getIt
      .isReady<SharedPreferences>(); // Ensure SharedPreferences is initialized

  // --- Register Core Services ---

  // Register ApiService FIRST, as AuthService depends on it.
  getIt.registerSingleton<ApiService>(
    ApiService(getIt<SecureStorageService>(), getIt<Logger>()),
  );

  getIt.registerSingleton<AuthService>(
    AuthService(
      getIt<SecureStorageService>(),
      getIt<Logger>(),
      getIt<SharedPreferences>(),
      getIt<ApiService>(),
    ),
  );

  // If ApiService needs AuthService, and you removed it from ApiService's constructor for circularity,
  // you would then set it here *after* both are registered.
  // Example (assuming ApiService has a `setAuthService` method):
  // getIt<ApiService>().setAuthService(getIt<AuthService>());

  getIt.registerSingleton<BiometricService>(BiometricService(getIt<Logger>()));
  getIt.registerSingleton<DeviceInfoService>(
    DeviceInfoService(getIt<Logger>()),
  );
  getIt.registerSingleton<LocationService>(LocationService(getIt<Logger>()));

  // --- Register App Router ---
  // AppRouter depends on AuthService for its redirect logic based on auth state.
  getIt.registerSingleton<AppRouter>(AppRouter(getIt<AuthService>()));

  // --- Register ViewModels (Controllers) as Factories ---
  // Use registerFactory for ViewModels as they might hold mutable state tied to specific screens.
  // Each ViewModel injects its required services and the AppRouter for navigation.
  getIt.registerFactory<LoginViewModel>(
    () => LoginViewModel(
      getIt<AuthService>(),
      getIt<Logger>(),
      getIt<AppRouter>(),
    ),
  );
  // Assuming RegisterViewModel is in signup/signup_viewmodel.dart
  getIt.registerFactory<RegisterViewModel>(
    () => RegisterViewModel(
      getIt<AuthService>(),
      getIt<Logger>(),
      getIt<AppRouter>(),
    ),
  );
  getIt.registerFactory<OtpVerificationViewModel>(
    // New ViewModel
    () => OtpVerificationViewModel(
      getIt<AuthService>(),
      getIt<Logger>(),
      getIt<AppRouter>(),
    ),
  );
  getIt.registerFactory<AuthViewModel>(
    // Renamed from PasswordViewModel if it's the same class
    () => AuthViewModel(
      getIt<AuthService>(),
      getIt<Logger>(),
      getIt<AppRouter>(),
    ),
  );

  getIt.registerFactory<ProfileSetupViewModel>(
    () => ProfileSetupViewModel(
      getIt<AuthService>(),
      getIt<Logger>(),
      getIt<AppRouter>(),
    ),
  );
  getIt.registerFactory<HomeController>(
    () => HomeController(getIt<ApiService>(), getIt<Logger>()),
  );
  getIt.registerFactory<PaymentController>(
    () => PaymentController(
      getIt<ApiService>(),
      getIt<BiometricService>(),
      getIt<LocationService>(),
      getIt<DeviceInfoService>(),
      getIt<Logger>(),
    ),
  );
  getIt.registerFactory<ThemeController>(
    // Ensure this is registered BEFORE SettingsController if SettingsController depends on it
    () => ThemeController(getIt<SecureStorageService>()),
  );
  getIt.registerFactory<SettingsController>(
    // Ensure this is registered
    () => SettingsController(
      getIt<SecureStorageService>(),
      getIt<ThemeController>(),
    ),
  );
}
