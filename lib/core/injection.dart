import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';

// Core Services
import 'services/api_service.dart';
import 'services/auth_service.dart';
import 'services/biometric_service.dart';
import 'services/device_info_service.dart';
import 'services/location_service.dart';
import 'utils/secure_storage_service.dart';
import 'theme/theme_controller.dart';

// Feature Controllers
import '../features/auth/controllers/auth_controller.dart';
import '../features/home/controllers/home_controller.dart';
import '../features/payment/controllers/payment_controller.dart';
import '../features/settings/controllers/settings_controller.dart';

final GetIt getIt = GetIt.instance;

void setupGetIt() {
  // Ensure GetIt is reset before setting up, especially in tests
  if (getIt.isRegistered<Logger>()) {
    getIt.reset();
  }

  // --- Register Logger ---
  getIt.registerSingleton<Logger>(
    Logger(
      printer: PrettyPrinter(
        methodCount: 0,
        errorMethodCount: 5,
        lineLength: 80,
        colors: true,
        printEmojis: true,
        printTime: false,
      ),
    ),
  );

  // --- Register Core Utilities & Services (Singletons) ---
  // Services are typically singletons as they don't hold UI state and are reusable
  getIt.registerLazySingleton<SecureStorageService>(
    () => SecureStorageService(getIt()),
  );
  getIt.registerLazySingleton<AuthService>(() => AuthService(getIt(), getIt()));
  getIt.registerLazySingleton<ApiService>(
    () => ApiService(getIt(), getIt(), getIt()),
  );
  getIt.registerLazySingleton<BiometricService>(
    () => BiometricService(getIt()),
  );
  getIt.registerLazySingleton<LocationService>(() => LocationService(getIt()));
  getIt.registerLazySingleton<DeviceInfoService>(
    () => DeviceInfoService(getIt()),
  );
  getIt.registerLazySingleton<ThemeController>(() => ThemeController(getIt()));

  // --- Register Feature Controllers (Lazy Singletons) ---
  // Controllers are ChangeNotifiers and will be provided via Provider in the widget tree.
  // We register them as lazy singletons here so they can be accessed by other controllers
  // or services if needed (e.g., AuthService needs AuthController to refresh token).
  // Provider will manage their lifecycle in the UI.
  getIt.registerLazySingleton<AuthController>(
    () => AuthController(getIt(), getIt()),
  );
  getIt.registerLazySingleton<HomeController>(
    () => HomeController(getIt(), getIt()),
  );
  getIt.registerLazySingleton<PaymentController>(
    () => PaymentController(getIt(), getIt(), getIt(), getIt(), getIt()),
  );
  getIt.registerLazySingleton<SettingsController>(
    () => SettingsController(getIt(), getIt()),
  );

  // Note on ChangeNotifiers and GetIt:
  // When a ChangeNotifier is registered as a lazySingleton in GetIt, its dispose method
  // is usually called when GetIt.reset() is invoked (e.g., during app shutdown or test teardown).
  // When used with Provider, Provider also calls dispose when the ChangeNotifierProvider
  // is removed from the widget tree. This dual management is generally fine, but be aware.
  // For production, ensure your app's main dispose logic (e.g., in main.dart)
  // handles GetIt.reset() if you want to explicitly clean up singletons.
}

// Helper to get instances more conveniently
T find<T extends Object>() => getIt.get<T>();
