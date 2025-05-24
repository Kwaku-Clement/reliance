import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:logger/logger.dart';
import 'package:reliance/core/services/auth_service.dart'; // Corrected app name
import 'package:reliance/core/utils/secure_storage_service.dart'; // Corrected app name

// Mock classes
class MockSecureStorageService extends Mock implements SecureStorageService {}

class MockLogger extends Mock implements Logger {}

void main() {
  late AuthService authService;
  late MockSecureStorageService mockSecureStorageService;
  late MockLogger mockLogger;

  setUp(() {
    mockSecureStorageService = MockSecureStorageService();
    mockLogger = MockLogger();
    authService = AuthService(mockSecureStorageService, mockLogger);

    // Stub logger methods to prevent errors during tests
    when(() => mockLogger.i(any<dynamic>())).thenReturn(null);
    when(() => mockLogger.w(any<dynamic>())).thenReturn(null);
    when(() => mockLogger.e(any<dynamic>())).thenReturn(null);
  });

  group('AuthService', () {
    test(
      'login returns true and stores tokens on successful dummy login',
      () async {
        when(
          () => mockSecureStorageService.writeAuthToken(any()),
        ).thenAnswer((_) async => {});
        when(
          () => mockSecureStorageService.writeRefreshToken(any()),
        ).thenAnswer((_) async => {});

        final result = await authService.login(
          'user@example.com',
          'SecurePassword123!',
        );

        expect(result, isTrue);
        verify(() => mockSecureStorageService.writeAuthToken(any())).called(1);
        verify(
          () => mockSecureStorageService.writeRefreshToken(any()),
        ).called(1);
      },
    );

    test('login returns false on failed dummy login', () async {
      final result = await authService.login(
        'wrong@example.com',
        'wrongpassword',
      );

      expect(result, isFalse);
      verifyNever(() => mockSecureStorageService.writeAuthToken(any()));
      verifyNever(() => mockSecureStorageService.writeRefreshToken(any()));
    });

    test('logout clears all tokens', () async {
      when(
        () => mockSecureStorageService.deleteAllTokens(),
      ).thenAnswer((_) async => {});

      await authService.logout();

      verify(() => mockSecureStorageService.deleteAllTokens()).called(1);
    });

    test('isAuthenticated returns true if auth token exists', () async {
      when(
        () => mockSecureStorageService.readAuthToken(),
      ).thenAnswer((_) async => 'some_token');

      final result = await authService.isAuthenticated();

      expect(result, isTrue);
    });

    test(
      'isAuthenticated returns false if auth token does not exist',
      () async {
        when(
          () => mockSecureStorageService.readAuthToken(),
        ).thenAnswer((_) async => null);

        final result = await authService.isAuthenticated();

        expect(result, isFalse);
      },
    );

    test(
      'refreshToken returns true and updates tokens on successful dummy refresh',
      () async {
        when(
          () => mockSecureStorageService.readRefreshToken(),
        ).thenAnswer((_) async => 'old_refresh_token');
        when(
          () => mockSecureStorageService.writeAuthToken(any()),
        ).thenAnswer((_) async => {});
        when(
          () => mockSecureStorageService.writeRefreshToken(any()),
        ).thenAnswer((_) async => {});

        final result = await authService.refreshToken();

        expect(result, isTrue);
        verify(() => mockSecureStorageService.writeAuthToken(any())).called(1);
        verify(
          () => mockSecureStorageService.writeRefreshToken(any()),
        ).called(1);
      },
    );

    test('refreshToken returns false if no refresh token exists', () async {
      when(
        () => mockSecureStorageService.readRefreshToken(),
      ).thenAnswer((_) async => null);

      final result = await authService.refreshToken();

      expect(result, isFalse);
      verifyNever(() => mockSecureStorageService.writeAuthToken(any()));
      verifyNever(() => mockSecureStorageService.writeRefreshToken(any()));
    });
  });
}
