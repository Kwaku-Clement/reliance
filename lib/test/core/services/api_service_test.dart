import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:logger/logger.dart';
import 'package:reliance/core/services/api_service.dart';
import 'package:reliance/core/services/auth_service.dart';
import 'package:reliance/core/utils/secure_storage_service.dart';

class MockSecureStorageService extends Mock implements SecureStorageService {}

class MockAuthService extends Mock implements AuthService {}

class MockLogger extends Mock implements Logger {}

void main() {
  late ApiService apiService;
  late MockSecureStorageService mockSecureStorageService;
  late MockAuthService mockAuthService;
  late MockLogger mockLogger;

  setUp(() {
    mockSecureStorageService = MockSecureStorageService();
    mockAuthService = MockAuthService();
    mockLogger = MockLogger();
    apiService = ApiService(
      mockSecureStorageService,
      mockAuthService,
      mockLogger,
    );

    when(() => mockLogger.i(any<dynamic>())).thenReturn(null);
    when(() => mockLogger.w(any<dynamic>())).thenReturn(null);
    when(() => mockLogger.e(any<dynamic>())).thenReturn(null);
    when(() => mockLogger.d(any<dynamic>())).thenReturn(null);

    when(
      () => mockSecureStorageService.readAuthToken(),
    ).thenAnswer((_) async => 'valid_token');
  });

  group('ApiService - Dummy Data', () {
    test('get returns dummy balance data for "account/balance"', () async {
      final result = await apiService.get('account/balance');
      expect(result, {'balance': 1234.56, 'currency': 'USD'});
    });

    test(
      'get returns dummy transaction history for "transactions/history"',
      () async {
        final result = await apiService.get('transactions/history');
        expect(result, isA<Map<String, dynamic>>());
        expect(result['transactions'], isA<List>());
        expect(result['transactions'].length, 3);
      },
    );

    test('get throws exception for unknown dummy endpoint', () async {
      expect(
        () => apiService.get('unknown/endpoint'),
        throwsA(isA<Exception>()),
      );
    });

    test(
      'post returns dummy payment success for "transactions/payment"',
      () async {
        final data = {
          'amount': 100.00,
          'currency': 'USD',
          'recipient_id': 'test_user',
        };
        final result = await apiService.post('transactions/payment', data);
        expect(result, containsPair('status', 'completed'));
        expect(result.containsKey('transactionId'), isTrue);
      },
    );

    test('post throws exception for dummy payment exceeding limit', () async {
      final data = {
        'amount': 1500.00,
        'currency': 'USD',
        'recipient_id': 'test_user',
      };
      expect(
        () => apiService.post('transactions/payment', data),
        throwsA(isA<Exception>()),
      );
    });

    test('post throws exception for unknown dummy endpoint', () async {
      final data = {'key': 'value'};
      expect(
        () => apiService.post('unknown/post', data),
        throwsA(isA<Exception>()),
      );
    });
  });
}
