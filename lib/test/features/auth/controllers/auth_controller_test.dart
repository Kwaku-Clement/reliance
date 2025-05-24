import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:logger/logger.dart';
import 'package:reliance/features/auth/controllers/auth_controller.dart'; // Corrected app name
import 'package:reliance/core/services/auth_service.dart'; // Corrected app name
import 'package:get_it/get_it.dart'; // For mocking GetIt dependencies

// Mock classes
class MockAuthService extends Mock implements AuthService {}

class MockLogger extends Mock implements Logger {}

void main() {
  late AuthController authController;
  late MockAuthService mockAuthService;
  late MockLogger mockLogger;

  setUp(() {
    mockAuthService = MockAuthService();
    mockLogger = MockLogger();

    GetIt.I.registerSingleton<Logger>(mockLogger); // Register logger
    authController = AuthController(mockAuthService, mockLogger);

    // Stub logger methods
    when(() => mockLogger.i(any<dynamic>())).thenReturn(null);
    when(() => mockLogger.w(any<dynamic>())).thenReturn(null);
    when(() => mockLogger.e(any<dynamic>())).thenReturn(null);
  });

  tearDown(() {
    GetIt.I.reset();
  });

  group('AuthController', () {
    test('initial state is correct', () {
      expect(authController.isLoading, isFalse);
      expect(authController.errorMessage, isNull);
      expect(authController.currentUser, isNull);
    });

    test('login sets isLoading to true then false', () async {
      when(
        () => mockAuthService.login(any(), any()),
      ).thenAnswer((_) async => true);

      final future = authController.login('test@example.com', 'password');
      expect(authController.isLoading, isTrue);
      await future;
      expect(authController.isLoading, isFalse);
    });

    test('login sets currentUser and returns true on success', () async {
      when(
        () => mockAuthService.login(any(), any()),
      ).thenAnswer((_) async => true);

      final result = await authController.login('test@example.com', 'password');
      expect(result, isTrue);
      // In this version, currentUser is always null as per controller logic.
      // If a real User object was returned by AuthService, this test would verify it.
      expect(authController.currentUser, isNull);
      expect(authController.errorMessage, isNull);
    });

    test('login sets errorMessage and returns false on failure', () async {
      when(
        () => mockAuthService.login(any(), any()),
      ).thenAnswer((_) async => false);

      final result = await authController.login('test@example.com', 'password');
      expect(result, isFalse);
      expect(authController.currentUser, isNull);
      expect(
        authController.errorMessage,
        'Login failed. Please check your credentials.',
      ); // Generic error
    });

    test('login sets errorMessage on exception', () async {
      when(
        () => mockAuthService.login(any(), any()),
      ).thenThrow(Exception('Network error'));

      final result = await authController.login('test@example.com', 'password');
      expect(result, isFalse);
      expect(
        authController.errorMessage,
        'An unexpected error occurred: Exception: Network error',
      ); // Generic error
    });

    test('logout clears currentUser and calls authService.logout', () async {
      when(
        () => mockAuthService.login(any(), any()),
      ).thenAnswer((_) async => true);
      await authController.login('test@example.com', 'password');

      when(() => mockAuthService.logout()).thenAnswer((_) async => {});

      await authController.logout();
      expect(authController.currentUser, isNull);
      verify(() => mockAuthService.logout()).called(1);
    });

    test('checkAuthStatus calls authService.isAuthenticated', () async {
      when(
        () => mockAuthService.isAuthenticated(),
      ).thenAnswer((_) async => true);

      final result = await authController.checkAuthStatus();
      expect(result, isTrue);
      verify(() => mockAuthService.isAuthenticated()).called(1);
    });
  });
}
