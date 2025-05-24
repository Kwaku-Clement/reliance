import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/local_auth_android.dart'; // Correct import
import 'package:local_auth_darwin/types/auth_messages_ios.dart';
import 'package:logger/logger.dart';

class BiometricService {
  final LocalAuthentication _auth;
  final Logger _logger;

  BiometricService(this._logger, {LocalAuthentication? localAuth})
    : _auth = localAuth ?? LocalAuthentication();

  Future<bool> canCheckBiometrics() async {
    try {
      return await _auth.canCheckBiometrics;
    } catch (e) {
      _logger.e('Error checking biometrics capability: $e'); // Generic error
      return false;
    }
  }

  Future<List<BiometricType>> getAvailableBiometrics() async {
    try {
      return await _auth.getAvailableBiometrics();
    } catch (e) {
      _logger.e('Error getting available biometrics: $e'); // Generic error
      return [];
    }
  }

  Future<bool> authenticate({required String localizedReason}) async {
    bool authenticated = false;
    try {
      authenticated = await _auth.authenticate(
        localizedReason: localizedReason,
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
        ),
        authMessages: <AuthMessages>[
          // Correct instantiation
          AndroidAuthMessages(
            signInTitle: 'Reliance Security Check',
            cancelButton: 'Cancel',
          ),
          IOSAuthMessages(
            // Correct instantiation
            cancelButton: 'Cancel',
          ),
        ],
      );
      _logger.i('Biometric authentication result: $authenticated');
      return authenticated;
    } catch (e) {
      _logger.e('Error during biometric authentication: $e'); // Generic error
      return false;
    }
  }
}
