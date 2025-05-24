import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:logger/logger.dart';
import 'package:geolocator/geolocator.dart';
import 'package:reliance/features/payment/controllers/payment_controller.dart'; // Corrected app name
import 'package:reliance/core/services/api_service.dart'; // Corrected app name
import 'package:reliance/core/services/biometric_service.dart'; // Corrected app name
import 'package:reliance/core/services/location_service.dart'; // Corrected app name
import 'package:reliance/core/services/device_info_service.dart'; // Corrected app name
import 'package:get_it/get_it.dart'; // For mocking GetIt dependencies

// Mock classes
class MockApiService extends Mock implements ApiService {}

class MockBiometricService extends Mock implements BiometricService {}

class MockLocationService extends Mock implements LocationService {}

class MockDeviceInfoService extends Mock implements DeviceInfoService {}

class MockLogger extends Mock implements Logger {}

void main() {
  late PaymentController paymentController;
  late MockApiService mockApiService;
  late MockBiometricService mockBiometricService;
  late MockLocationService mockLocationService;
  late MockDeviceInfoService mockDeviceInfoService;
  late MockLogger mockLogger;

  setUp(() {
    mockApiService = MockApiService();
    mockBiometricService = MockBiometricService();
    mockLocationService = MockLocationService();
    mockDeviceInfoService = MockDeviceInfoService();
    mockLogger = MockLogger();

    GetIt.I.registerSingleton<Logger>(mockLogger); // Register logger

    paymentController = PaymentController(
      mockApiService,
      mockBiometricService,
      mockLocationService,
      mockDeviceInfoService,
      mockLogger,
    );

    // Stub logger methods
    when(() => mockLogger.i(any<dynamic>())).thenReturn(null);
    when(() => mockLogger.w(any<dynamic>())).thenReturn(null);
    when(() => mockLogger.e(any<dynamic>())).thenReturn(null);
    when(() => mockLogger.d(any<dynamic>())).thenReturn(null);

    // Default stub for biometric availability
    when(
      () => mockBiometricService.canCheckBiometrics(),
    ).thenAnswer((_) async => true);
  });

  tearDown(() {
    GetIt.I.reset();
  });

  group('PaymentController', () {
    test('initial state is correct', () {
      expect(paymentController.isLoading, isFalse);
      expect(paymentController.statusMessage, isNull);
      expect(paymentController.canUseBiometrics, isFalse);
    });

    test('checkBiometricsAvailability updates canUseBiometrics', () async {
      when(
        () => mockBiometricService.canCheckBiometrics(),
      ).thenAnswer((_) async => true);
      await paymentController.checkBiometricsAvailability();
      expect(paymentController.canUseBiometrics, isTrue);

      when(
        () => mockBiometricService.canCheckBiometrics(),
      ).thenAnswer((_) async => false);
      await paymentController.checkBiometricsAvailability();
      expect(paymentController.canUseBiometrics, isFalse);
    });

    test(
      'authenticateBiometrics calls biometricService.authenticate',
      () async {
        when(
          () => mockBiometricService.authenticate(
            localizedReason: any(named: 'localizedReason'),
          ),
        ).thenAnswer((_) async => true);
        final result = await paymentController.authenticateBiometrics(
          'Test reason',
        );
        expect(result, isTrue);
        verify(
          () =>
              mockBiometricService.authenticate(localizedReason: 'Test reason'),
        ).called(1);
      },
    );

    test('makePayment returns early if amount is invalid', () async {
      await paymentController.makePayment(0.0, 'recipient');
      expect(
        paymentController.statusMessage,
        'Invalid amount.',
      ); // Generic error
      expect(paymentController.isLoading, isFalse);
      verifyNever(() => mockApiService.post(any(), any()));
    });

    test('makePayment returns early if recipient is empty', () async {
      await paymentController.makePayment(100.0, '');
      expect(
        paymentController.statusMessage,
        'Recipient cannot be empty.',
      ); // Generic error
      expect(paymentController.isLoading, isFalse);
      verifyNever(() => mockApiService.post(any(), any()));
    });

    test('makePayment proceeds without biometrics if not available', () async {
      when(
        () => mockBiometricService.canCheckBiometrics(),
      ).thenAnswer((_) async => false);
      await paymentController.checkBiometricsAvailability();

      when(() => mockLocationService.getCurrentLocation()).thenAnswer(
        (_) async => Position(
          latitude: 0,
          longitude: 0,
          timestamp: DateTime.now(),
          accuracy: 1,
          altitude: 0,
          heading: 0,
          speed: 0,
          speedAccuracy: 0,
          floor: null,
          isMocked: false,
          altitudeAccuracy: 0,
          headingAccuracy: 0,
        ),
      );
      when(
        () => mockDeviceInfoService.getDeviceInfo(),
      ).thenAnswer((_) async => {'platform': 'test'});
      when(() => mockApiService.post(any(), any())).thenAnswer(
        (_) async => {'transactionId': 'tx1', 'status': 'completed'},
      );

      await paymentController.makePayment(100.0, 'recipient');
      expect(paymentController.isLoading, isFalse);
      expect(
        paymentController.statusMessage,
        'Payment successful! Transaction ID: tx1',
      ); // Generic success
      verify(
        () => mockApiService.post('transactions/payment', any()),
      ).called(1);
    });

    test(
      'makePayment calls API with device and location info on success',
      () async {
        when(
          () => mockBiometricService.authenticate(
            localizedReason: any(named: 'localizedReason'),
          ),
        ).thenAnswer((_) async => true);
        when(() => mockLocationService.getCurrentLocation()).thenAnswer(
          (_) async => Position(
            latitude: 1.0,
            longitude: 2.0,
            timestamp: DateTime.now(),
            accuracy: 1.0,
            altitude: 0,
            heading: 0,
            speed: 0,
            speedAccuracy: 0,
            floor: null,
            isMocked: false,
            altitudeAccuracy: 0,
            headingAccuracy: 0,
          ),
        );
        when(
          () => mockDeviceInfoService.getDeviceInfo(),
        ).thenAnswer((_) async => {'platform': 'Android', 'model': 'Pixel'});
        when(() => mockApiService.post(any(), any())).thenAnswer(
          (_) async => {'transactionId': 'tx1', 'status': 'completed'},
        );

        await paymentController.makePayment(100.0, 'recipient');

        expect(paymentController.isLoading, isFalse);
        expect(
          paymentController.statusMessage,
          'Payment successful! Transaction ID: tx1',
        );
        verify(
          () => mockApiService.post(
            'transactions/payment',
            captureAny(that: isA<Map<String, dynamic>>()),
          ),
        ).called(1);

        final capturedArgs =
            verify(
                  () =>
                      mockApiService.post('transactions/payment', captureAny()),
                ).captured.last
                as Map<String, dynamic>;
        expect(capturedArgs['device_info'], isA<Map<String, dynamic>>());
        expect(capturedArgs['device_info']['platform'], 'Android');
        expect(capturedArgs['location'], isA<Map<String, dynamic>>());
        expect(capturedArgs['location']['latitude'], 1.0);
      },
    );

    test('makePayment sets statusMessage to error on API failure', () async {
      when(
        () => mockBiometricService.authenticate(
          localizedReason: any(named: 'localizedReason'),
        ),
      ).thenAnswer((_) async => true);
      when(
        () => mockLocationService.getCurrentLocation(),
      ).thenAnswer((_) async => null);
      when(
        () => mockDeviceInfoService.getDeviceInfo(),
      ).thenAnswer((_) async => null);
      when(
        () => mockApiService.post(any(), any()),
      ).thenThrow(Exception('API error'));

      await paymentController.makePayment(100.0, 'recipient');

      expect(paymentController.isLoading, isFalse);
      expect(
        paymentController.statusMessage,
        'Payment failed: Exception: API error',
      ); // Generic error
    });

    test('clearStatusMessage sets statusMessage to null', () async {
      paymentController.makePayment(0.0, 'recipient');
      expect(paymentController.statusMessage, isNotNull);

      paymentController.clearStatusMessage();
      expect(paymentController.statusMessage, isNull);
    });
  });
}
