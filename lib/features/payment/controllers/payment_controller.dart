import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:geolocator/geolocator.dart';
import 'package:reliance/features/payment/model/payment_request.dart';
import '../../../core/services/api_service.dart';
import '../../../core/services/biometric_service.dart';
import '../../../core/services/location_service.dart';
import '../../../core/services/device_info_service.dart';

class PaymentController extends ChangeNotifier {
  final ApiService _apiService;
  final BiometricService _biometricService;
  final LocationService _locationService;
  final DeviceInfoService _deviceInfoService;
  final Logger _logger;

  PaymentController(
    this._apiService,
    this._biometricService,
    this._locationService,
    this._deviceInfoService,
    this._logger,
  );

  bool _isLoading = false;
  String? _statusMessage; // Generic status message, UI will localize
  bool _canUseBiometrics = false;

  bool get isLoading => _isLoading;
  String? get statusMessage => _statusMessage;
  bool get canUseBiometrics => _canUseBiometrics;

  Future<void> checkBiometricsAvailability() async {
    _canUseBiometrics = await _biometricService.canCheckBiometrics();
    notifyListeners();
  }

  Future<bool> authenticateBiometrics(String localizedReason) async {
    return await _biometricService.authenticate(
      localizedReason: localizedReason,
    );
  }

  Future<void> makePayment(double amount, String recipient) async {
    // Controllers receive generic messages; UI handles localization
    if (amount <= 0) {
      _statusMessage = 'Invalid amount.';
      notifyListeners();
      return;
    }
    if (recipient.isEmpty) {
      _statusMessage = 'Recipient cannot be empty.';
      notifyListeners();
      return;
    }

    _isLoading = true;
    _statusMessage = 'Processing payment...';
    notifyListeners();

    try {
      final Map<String, dynamic>? deviceInfo = await _deviceInfoService
          .getDeviceInfo();
      _logger.d('Collected Device Info: $deviceInfo');

      final Position? currentPosition = await _locationService
          .getCurrentLocation();
      final Map<String, dynamic>? locationInfo = currentPosition != null
          ? {
              'latitude': currentPosition.latitude,
              'longitude': currentPosition.longitude,
              'accuracy': currentPosition.accuracy,
              'timestamp': currentPosition.timestamp.toIso8601String(),
            }
          : null;
      _logger.d('Collected Location Info: $locationInfo');

      final paymentRequest = PaymentRequest(
        amount: amount,
        currency: 'USD',
        recipientId: recipient,
        paymentGatewayToken: 'dummy_token_from_payment_gateway_sdk',
        deviceInfo: deviceInfo,
        locationInfo: locationInfo,
      );

      final response = await _apiService.post(
        'transactions/payment',
        paymentRequest.toJson(),
      );

      _statusMessage =
          'Payment successful! Transaction ID: ${response['transactionId']}';
      _logger.i('Payment successful: ${response['transactionId']}');
    } catch (e) {
      _statusMessage = 'Payment failed: ${e.toString()}';
      _logger.e('Payment failed: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearStatusMessage() {
    _statusMessage = null;
    notifyListeners();
  }
}
