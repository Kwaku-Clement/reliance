import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:logger/logger.dart';
import 'package:reliance/core/services/api_service.dart';
import 'package:reliance/core/services/biometric_service.dart';
import 'package:reliance/core/services/location_service.dart';
import 'package:reliance/core/services/device_info_service.dart';
import 'package:reliance/features/auth/models/user_model.dart';
import 'package:reliance/features/payment/model/payment_request.dart';

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

  User? _currentUser;
  bool _isLoading = false;
  String? _statusMessage;
  bool _canUseBiometrics = false;

  User? get user => _currentUser;
  bool get isLoading => _isLoading;
  String? get statusMessage => _statusMessage;
  bool get canUseBiometrics => _canUseBiometrics;

  void setUser(User? user) {
    _currentUser = user;
    notifyListeners();
  }

  Future<void> checkBiometricsAvailability() async {
    try {
      _canUseBiometrics = await _biometricService.canCheckBiometrics();
      notifyListeners();
    } catch (e) {
      _logger.e('Failed to check biometrics: $e');
      _canUseBiometrics = false;
      notifyListeners();
    }
  }

  Future<bool> authenticateWithBiometrics(String localizedReason) async {
    try {
      return await _biometricService.authenticate(
        localizedReason: localizedReason,
      );
    } catch (e) {
      _logger.e('Biometric authentication error: $e');
      return false;
    }
  }

  Future<void> makePayment(double amount, String recipient) async {
    if (amount <= 0) {
      _statusMessage = 'Invalid amount.';
      notifyListeners();
      _logger.w('Payment attempt with invalid amount: $amount');
      return;
    }
    if (recipient.isEmpty) {
      _statusMessage = 'Recipient cannot be empty.';
      _logger.w('Payment attempt with empty recipient.');
      notifyListeners();
      return;
    }

    _isLoading = true;
    _statusMessage = 'Processing payment...';
    notifyListeners();

    try {
      final Map<String, dynamic>? deviceInfo = await _deviceInfoService
          .getDeviceInfo();
      _logger.d('Collected device info: $deviceInfo');

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
      _logger.d('Collected location info: $locationInfo');

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
      _logger.i('Successful payment: ${response['transactionId']}');
    } catch (e) {
      _statusMessage = 'Payment failed: ${e.toString()}';
      _logger.e('Payment error: $e');
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
