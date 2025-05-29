import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:reliance/core/services/api_service.dart';
import 'package:reliance/core/utils/secure_storage_service.dart';
import 'package:reliance/features/auth/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart'; // Keep Uuid for dummy data generation

class AuthService extends ChangeNotifier {
  final SecureStorageService _secureStorageService;
  final Logger _logger;
  final SharedPreferences _prefs;
  final ApiService _apiService; // ApiService for making actual API calls

  User? _currentUser;
  // These are specific to dummy OTP logic and will be used for testing.
  String? _lastSentOtp;
  String? _lastGeneratedVerificationId;
  String? _pendingOtpVerificationEmailOrPhone;
  String? _dummyPasscode;

  AuthService(
    this._secureStorageService,
    this._logger,
    this._prefs,
    this._apiService,
  );

  static const String _kProfileCompleteKey = 'isProfileComplete';
  static const String _kInitialSetupRequiredKey = 'initialSetupRequired';

  User? get currentUser => _currentUser;

  /// Logs in a user with email/phone and password (using dummy data).
  Future<Map<String, dynamic>> login({
    required String emailOrPhone,
    required String password,
  }) async {
    _logger.i('Attempting login for: $emailOrPhone');

    // --- DUMMY DATA LOGIC (FOR TESTING) ---
    await Future.delayed(const Duration(seconds: 2));

    if ((emailOrPhone == 'user@example.com' ||
            emailOrPhone == '+233241234567') &&
        password == 'Password123!') {
      _currentUser = User(
        id: const Uuid().v4(),
        username: 'user123',
        fullName: 'Test User',
        email: 'user@example.com',
        phone: '+233241234567',
        roles: [],
      );
      final dummyAuthToken = 'dummy_jwt_token_${const Uuid().v4()}';
      final dummyRefreshToken = 'dummy_refresh_token_${const Uuid().v4()}';
      await _secureStorageService.writeAuthToken(dummyAuthToken);
      await _secureStorageService.writeRefreshToken(
        dummyRefreshToken,
      ); // FIX: Changed to writeRefreshToken
      _logger.i('Dummy login successful. Tokens stored.');

      if (!(_prefs.getBool(_kProfileCompleteKey) ?? false)) {
        await _prefs.setBool(_kInitialSetupRequiredKey, true);
      } else {
        await _prefs.setBool(_kInitialSetupRequiredKey, false);
      }
      notifyListeners();
      return {'message': 'Dummy Login successful!', 'token': dummyAuthToken};
    } else {
      _logger.w('Dummy login failed for: $emailOrPhone: Invalid credentials.');
      throw Exception('Invalid email/phone or password.');
    }
    // --- END DUMMY DATA LOGIC ---

    /*
    // --- LIVE API CALLS (UNCOMMENT FOR PRODUCTION) ---
    try {
      final response = await _apiService.post('auth/login', {
        'emailOrPhone': emailOrPhone,
        'password': password,
      });

      final String? token = response['token'];
      final String? refreshToken = response['refreshToken'];
      final Map<String, dynamic>? userData = response['user'];

      if (token != null) {
        await _secureStorageService.writeAuthToken(token);
        if (refreshToken != null) {
          await _secureStorageService.writeRefreshToken(refreshToken);
        }

        if (userData != null) {
          _currentUser = User.fromJson(userData);
        } else {
          _logger.w('Login successful but no user data returned. Consider fetching profile.');
          _currentUser = User(
            id: 'unknown',
            username: emailOrPhone,
            fullName: 'Unknown User',
            email: emailOrPhone,
            phone: emailOrPhone,
            roles: [],
          );
        }

        if (!(response['isProfileComplete'] ?? (_prefs.getBool(_kProfileCompleteKey) ?? false))) {
          await _prefs.setBool(_kInitialSetupRequiredKey, true);
        } else {
          await _prefs.setBool(_kInitialSetupRequiredKey, false);
          await _prefs.setBool(_kProfileCompleteKey, true);
        }

        _logger.i('Login successful for: $emailOrPhone');
        notifyListeners();
        return {'message': 'Login successful!', 'token': token};
      } else {
        _logger.e('Login failed: Token not received from API.');
        throw Exception('Login failed. Please try again.');
      }
    } catch (e) {
      _logger.e('Login error: $e');
      rethrow;
    }
    // --- END LIVE API CALLS ---
    */
  }

  /// Registers a new user (using dummy data).
  Future<Map<String, dynamic>> registerUser({
    required String email,
    required String password,
    required String phone,
    required String fullName,
    String? address,
  }) async {
    _logger.i('Attempting registration for email: $email, phone: $phone');

    // --- DUMMY DATA LOGIC (FOR TESTING) ---
    await Future.delayed(const Duration(seconds: 2));

    if (email == 'user@example.com' || phone == '+233241234567') {
      throw Exception('Email or phone number already registered.');
    }

    _pendingOtpVerificationEmailOrPhone = email;
    _lastGeneratedVerificationId = const Uuid().v4();
    _lastSentOtp = '123456';

    _logger.i(
      'Registration initiated. OTP sent to $email. Dummy Verification ID: $_lastGeneratedVerificationId',
    );
    return {
      'message': 'Dummy Registration successful, OTP sent.',
      'verificationId': _lastGeneratedVerificationId,
      'destination': email,
    };
    // --- END DUMMY DATA LOGIC ---

    /*
    // --- LIVE API CALLS (UNCOMMENT FOR PRODUCTION) ---
    try {
      final response = await _apiService.post('auth/register', {
        'email': email,
        'password': password,
        'phone': phone,
        'fullName': fullName,
        'address': address,
      });
      _logger.i('Registration initiated. OTP sent.');
      return response;
    } catch (e) {
      _logger.e('Registration error: $e');
      rethrow;
    }
    // --- END LIVE API CALLS ---
    */
  }

  /// Verifies OTP during registration (using dummy data).
  Future<Map<String, dynamic>> verifyRegistrationOtp({
    required String verificationId,
    required String otp,
  }) async {
    _logger.i(
      'Attempting to verify registration OTP for $verificationId with OTP: $otp',
    );

    // --- DUMMY DATA LOGIC (FOR TESTING) ---
    await Future.delayed(const Duration(seconds: 2));

    if (_lastGeneratedVerificationId == verificationId && _lastSentOtp == otp) {
      _currentUser = User(
        id: const Uuid().v4(),
        username: _pendingOtpVerificationEmailOrPhone!.split('@')[0],
        fullName: 'New User',
        email: _pendingOtpVerificationEmailOrPhone!,
        phone: '', // Placeholder, update if phone is part of registration
        roles: [],
      );
      _pendingOtpVerificationEmailOrPhone = null;
      _lastSentOtp = null;
      _lastGeneratedVerificationId = null;

      final dummyAuthToken = 'dummy_registered_jwt_token_${const Uuid().v4()}';
      final dummyRefreshToken =
          'dummy_registered_refresh_token_${const Uuid().v4()}';
      await _secureStorageService.writeAuthToken(dummyAuthToken);
      await _secureStorageService.writeRefreshToken(
        dummyRefreshToken,
      ); // FIX: Changed to writeRefreshToken
      await _prefs.setBool(_kProfileCompleteKey, false);
      await _prefs.setBool(_kInitialSetupRequiredKey, true);

      _logger.i(
        'Dummy registration OTP verification successful. User now logged in.',
      );
      notifyListeners();
      return {
        'message': 'Dummy OTP verified, registration complete!',
        'token': dummyAuthToken,
      };
    } else {
      _logger.w(
        'Dummy registration OTP verification failed: Invalid OTP or verification ID.',
      );
      throw Exception('Invalid OTP or verification ID.');
    }
    // --- END DUMMY DATA LOGIC ---

    /*
    // --- LIVE API CALLS (UNCOMMENT FOR PRODUCTION) ---
    try {
      final response = await _apiService.post('auth/verify-registration-otp', {
        'verificationId': verificationId,
        'otp': otp,
      });

      final String? token = response['token'];
      final String? refreshToken = response['refreshToken'];
      final Map<String, dynamic>? userData = response['user'];

      if (token != null) {
        await _secureStorageService.writeAuthToken(token);
        if (refreshToken != null) {
          await _secureStorageService.writeRefreshToken(refreshToken);
        }

        if (userData != null) {
          _currentUser = User.fromJson(userData);
        } else {
          _logger.w('Registration OTP verification successful but no user data returned.');
        }
        await _prefs.setBool(_kProfileCompleteKey, false);
        await _prefs.setBool(_kInitialSetupRequiredKey, true);

        _logger.i('Registration OTP verification successful. User now logged in.');
        notifyListeners();
        return response;
      } else {
        _logger.e('Registration OTP verification failed: Token not received.');
        throw Exception('OTP verification failed. Please try again.');
      }
    } catch (e) {
      _logger.e('Registration OTP verification error: $e');
      rethrow;
    }
    // --- END LIVE API CALLS ---
    */
  }

  /// Verifies OTP during login (using dummy data).
  Future<Map<String, dynamic>> verifyLoginOtp({
    required String verificationId,
    required String otp,
  }) async {
    _logger.i(
      'Attempting to verify login OTP for $verificationId with OTP: $otp',
    );

    // --- DUMMY DATA LOGIC (FOR TESTING) ---
    await Future.delayed(const Duration(seconds: 2));

    if (_lastGeneratedVerificationId == verificationId && _lastSentOtp == otp) {
      _currentUser = User(
        id: const Uuid().v4(),
        username: 'user123',
        fullName: 'Test User',
        email: _pendingOtpVerificationEmailOrPhone ?? 'user@example.com',
        phone: '+233241234567',
        roles: [],
      );
      final dummyAuthToken = 'dummy_login_jwt_token_${const Uuid().v4()}';
      final dummyRefreshToken =
          'dummy_login_refresh_token_${const Uuid().v4()}';
      await _secureStorageService.writeAuthToken(dummyAuthToken);
      await _secureStorageService.writeRefreshToken(
        dummyRefreshToken,
      ); // FIX: Changed to writeRefreshToken

      _pendingOtpVerificationEmailOrPhone = null;
      _lastSentOtp = null;
      _lastGeneratedVerificationId = null;

      _logger.i('Dummy login OTP verification successful. User now logged in.');
      notifyListeners();
      return {
        'message': 'Dummy OTP verified, login complete!',
        'token': dummyAuthToken,
      };
    } else {
      _logger.w(
        'Dummy login OTP verification failed: Invalid OTP or verification ID.',
      );
      throw Exception('Invalid OTP or verification ID.');
    }
    // --- END DUMMY DATA LOGIC ---

    /*
    // --- LIVE API CALLS (UNCOMMENT FOR PRODUCTION) ---
    try {
      final response = await _apiService.post('auth/verify-login-otp', {
        'verificationId': verificationId,
        'otp': otp,
      });

      final String? token = response['token'];
      final Map<String, dynamic>? userData = response['user'];

      if (token != null) {
        await _secureStorageService.writeAuthToken(token);
        if (userData != null) {
          _currentUser = User.fromJson(userData);
        }
        if (!(response['isProfileComplete'] ?? (_prefs.getBool(_kProfileCompleteKey) ?? false))) {
          await _prefs.setBool(_kInitialSetupRequiredKey, true);
        } else {
          await _prefs.setBool(_kInitialSetupRequiredKey, false);
          await _prefs.setBool(_kProfileCompleteKey, true);
        }

        _logger.i('Login OTP verification successful. User now logged in.');
        notifyListeners();
        return response;
      } else {
        _logger.e('Login OTP verification failed: Token not received.');
        throw Exception('OTP verification failed. Please try again.');
      }
    } catch (e) {
      _logger.e('Login OTP verification error: $e');
      rethrow;
    }
    // --- END LIVE API CALLS ---
    */
  }

  /// Resends OTP for registration (using dummy data).
  Future<Map<String, dynamic>> resendRegistrationOtp({
    required String destination,
  }) async {
    _logger.i('Attempting to resend registration OTP to: $destination');

    // --- DUMMY DATA LOGIC (FOR TESTING) ---
    await Future.delayed(const Duration(seconds: 2));

    if (destination == 'user@example.com' ||
        destination == '+233241234567' ||
        _pendingOtpVerificationEmailOrPhone == destination) {
      _lastGeneratedVerificationId = const Uuid().v4();
      _lastSentOtp = '654321';
      _pendingOtpVerificationEmailOrPhone = destination;
      _logger.i(
        'Dummy registration OTP resent to $destination. New Dummy Verification ID: $_lastGeneratedVerificationId',
      );
      return {
        'message': 'Dummy OTP resent successfully.',
        'verificationId': _lastGeneratedVerificationId,
      };
    } else {
      _logger.w(
        'Dummy resend registration OTP failed: Destination not recognized.',
      );
      throw Exception('Could not resend OTP. Destination not recognized.');
    }
    // --- END DUMMY DATA LOGIC ---

    /*
    // --- LIVE API CALLS (UNCOMMENT FOR PRODUCTION) ---
    try {
      final response = await _apiService.post('auth/resend-registration-otp', {
        'destination': destination,
      });
      _logger.i('Registration OTP resent successfully to $destination.');
      return response;
    } catch (e) {
      _logger.e('Resend registration OTP error: $e');
      rethrow;
    }
    // --- END LIVE API CALLS ---
    */
  }

  /// Sends OTP for login (using dummy data).
  Future<Map<String, dynamic>> sendLoginOtp({
    required String destination,
  }) async {
    _logger.i('Attempting to send login OTP to: $destination');

    // --- DUMMY DATA LOGIC (FOR TESTING) ---
    await Future.delayed(const Duration(seconds: 2));

    if (destination == 'user@example.com' || destination == '+233241234567') {
      _lastGeneratedVerificationId = const Uuid().v4();
      _lastSentOtp = '789012';
      _pendingOtpVerificationEmailOrPhone = destination;
      _logger.i(
        'Dummy login OTP sent to $destination. Dummy Verification ID: $_lastGeneratedVerificationId',
      );
      return {
        'message': 'Dummy Login OTP sent successfully.',
        'verificationId': _lastGeneratedVerificationId,
        'destination': destination,
      };
    } else {
      _logger.w('Dummy send login OTP failed: Destination not recognized.');
      throw Exception('Could not send login OTP. Destination not recognized.');
    }
    // --- END DUMMY DATA LOGIC ---

    /*
    // --- LIVE API CALLS (UNCOMMENT FOR PRODUCTION) ---
    try {
      final response = await _apiService.post('auth/send-login-otp', {
        'destination': destination,
      });
      _logger.i('Login OTP sent successfully to $destination.');
      return response;
    } catch (e) {
      _logger.e('Send login OTP error: $e');
      rethrow;
    }
    // --- END LIVE API CALLS ---
    */
  }

  /// Verifies OTP for password reset (using dummy data).
  Future<Map<String, dynamic>> verifyPasswordResetOtp({
    required String verificationId,
    required String otp,
  }) async {
    _logger.i(
      'Attempting to verify password reset OTP for $verificationId with OTP: $otp',
    );

    // --- DUMMY DATA LOGIC (FOR TESTING) ---
    await Future.delayed(const Duration(seconds: 2));

    if (_lastGeneratedVerificationId == verificationId && _lastSentOtp == otp) {
      final token = 'dummy_reset_token_${const Uuid().v4()}';
      _pendingOtpVerificationEmailOrPhone = null;
      _lastSentOtp = null;
      _lastGeneratedVerificationId = null;
      _logger.i('Dummy password reset OTP verification successful.');
      return {
        'message': 'Dummy OTP verified, proceed to reset password.',
        'token': token,
      };
    } else {
      _logger.w(
        'Dummy password reset OTP verification failed: Invalid OTP or verification ID.',
      );
      throw Exception('Invalid OTP or verification ID.');
    }
    // --- END DUMMY DATA LOGIC ---

    /*
    // --- LIVE API CALLS (UNCOMMENT FOR PRODUCTION) ---
    try {
      final response = await _apiService.post('auth/verify-password-reset-otp', {
        'verificationId': verificationId,
        'otp': otp,
      });
      _logger.i('Password reset OTP verification successful.');
      return response;
    } catch (e) {
      _logger.e('Password reset OTP verification error: $e');
      rethrow;
    }
    // --- END LIVE API CALLS ---
    */
  }

  /// Verifies OTP for transactions (using dummy data).
  Future<Map<String, dynamic>> verifyTransactionOtp({
    required String verificationId,
    required String otp,
  }) async {
    _logger.i(
      'Attempting to verify transaction OTP for $verificationId with OTP: $otp',
    );

    // --- DUMMY DATA LOGIC (FOR TESTING) ---
    await Future.delayed(const Duration(seconds: 2));

    if (_lastGeneratedVerificationId == verificationId && _lastSentOtp == otp) {
      _pendingOtpVerificationEmailOrPhone = null;
      _lastSentOtp = null;
      _lastGeneratedVerificationId = null;
      _logger.i('Dummy transaction OTP verification successful.');
      return {'message': 'Dummy OTP verified, transaction authorized.'};
    } else {
      _logger.w(
        'Dummy transaction OTP verification failed: Invalid OTP or verification ID.',
      );
      throw Exception('Invalid OTP or verification ID.');
    }
    // --- END DUMMY DATA LOGIC ---

    /*
    // --- LIVE API CALLS (UNCOMMENT FOR PRODUCTION) ---
    try {
      final response = await _apiService.post('auth/verify-transaction-otp', {
        'verificationId': verificationId,
        'otp': otp,
      });
      _logger.i('Transaction OTP verification successful.');
      return response;
    } catch (e) {
      _logger.e('Transaction OTP verification error: $e');
      rethrow;
    }
    // --- END LIVE API CALLS ---
    */
  }

  /// Resends OTP for password reset (using dummy data).
  Future<Map<String, dynamic>> resendPasswordResetOtp({
    required String destination,
  }) async {
    _logger.i('Attempting to resend password reset OTP to: $destination');

    // --- DUMMY DATA LOGIC (FOR TESTING) ---
    await Future.delayed(const Duration(seconds: 2));

    if (destination == 'user@example.com' ||
        destination == '+233241234567' ||
        _pendingOtpVerificationEmailOrPhone == destination) {
      _lastGeneratedVerificationId = const Uuid().v4();
      _lastSentOtp = '543210';
      _pendingOtpVerificationEmailOrPhone = destination;
      _logger.i(
        'Dummy password reset OTP resent to $destination. New Dummy Verification ID: $_lastGeneratedVerificationId',
      );
      return {
        'message': 'Dummy OTP resent successfully.',
        'verificationId': _lastGeneratedVerificationId,
      };
    } else {
      _logger.w(
        'Dummy resend password reset OTP failed: Destination not recognized.',
      );
      throw Exception('Could not resend OTP. Destination not recognized.');
    }
    // --- END DUMMY DATA LOGIC ---

    /*
    // --- LIVE API CALLS (UNCOMMENT FOR PRODUCTION) ---
    try {
      final response = await _apiService.post('auth/resend-password-reset-otp', {
        'destination': destination,
      });
      _logger.i('Password reset OTP resent successfully to $destination.');
      return response;
    } catch (e) {
      _logger.e('Resend password reset OTP error: $e');
      rethrow;
    }
    // --- END LIVE API CALLS ---
    */
  }

  /// Resends OTP for transactions (using dummy data).
  Future<Map<String, dynamic>> resendTransactionOtp({
    required String destination,
  }) async {
    _logger.i('Attempting to resend transaction OTP to: $destination');

    // --- DUMMY DATA LOGIC (FOR TESTING) ---
    await Future.delayed(const Duration(seconds: 2));

    if (destination == 'user@example.com' ||
        destination == '+233241234567' ||
        _pendingOtpVerificationEmailOrPhone == destination) {
      _lastGeneratedVerificationId = const Uuid().v4();
      _lastSentOtp = '098765';
      _pendingOtpVerificationEmailOrPhone = destination;
      _logger.i(
        'Dummy transaction OTP resent to $destination. New Dummy Verification ID: $_lastGeneratedVerificationId',
      );
      return {
        'message': 'Dummy OTP resent successfully.',
        'verificationId': _lastGeneratedVerificationId,
      };
    } else {
      _logger.w(
        'Dummy resend transaction OTP failed: Destination not recognized.',
      );
      throw Exception('Could not resend OTP. Destination not recognized.');
    }
    // --- END DUMMY DATA LOGIC ---

    /*
    // --- LIVE API CALLS (UNCOMMENT FOR PRODUCTION) ---
    try {
      final response = await _apiService.post('auth/resend-transaction-otp', {
        'destination': destination,
      });
      _logger.i('Transaction OTP resent successfully to $destination.');
      return response;
    } catch (e) {
      _logger.e('Resend transaction OTP error: $e');
      rethrow;
    }
    // --- END LIVE API CALLS ---
    */
  }

  /// Retrieves the current user's identifier (email or phone).
  Future<String?> getCurrentUserIdentifier() async {
    _logger.d('Retrieving current user identifier.');
    // In a live scenario, this might be from a decoded JWT or user profile.
    // For dummy data, we rely on the _currentUser object.
    return _currentUser?.email ?? _currentUser?.phone;
  }

  /// Logs out the user (using dummy data).
  Future<void> logout() async {
    _logger.i('Attempting logout.');
    // --- DUMMY DATA LOGIC (FOR TESTING) ---
    await _secureStorageService.deleteAuthToken();
    await _secureStorageService
        .deleteRefreshToken(); // Ensure refresh token is also cleared
    await _prefs.setBool(_kProfileCompleteKey, false);
    await _prefs.setBool(_kInitialSetupRequiredKey, false);
    _currentUser = null;
    _logger.i('Dummy logout successful.');
    notifyListeners();
    // --- END DUMMY DATA LOGIC ---

    /*
    // --- LIVE API CALLS (UNCOMMENT FOR PRODUCTION) ---
    try {
      await _apiService.post('auth/logout', {});
      await _secureStorageService.deleteAuthToken();
      await _secureStorageService.deleteRefreshToken();
      await _prefs.setBool(_kProfileCompleteKey, false);
      await _prefs.setBool(_kInitialSetupRequiredKey, false);
      _currentUser = null;
      _logger.i('Logout successful.');
      notifyListeners();
    } catch (e) {
      _logger.e('Logout error: $e');
      await _secureStorageService.deleteAuthToken();
      await _secureStorageService.deleteRefreshToken();
      await _prefs.setBool(_kProfileCompleteKey, false);
      await _prefs.setBool(_kInitialSetupRequiredKey, false);
      _currentUser = null;
      notifyListeners();
      rethrow;
    }
    // --- END LIVE API CALLS ---
    */
  }

  /// Attempts to refresh the authentication token (using dummy data).
  Future<bool> refreshToken() async {
    _logger.i('Attempting to refresh token...');
    // --- DUMMY DATA LOGIC (FOR TESTING) ---
    await Future.delayed(const Duration(seconds: 1));
    try {
      final String? existingRefreshToken = await _secureStorageService
          .readRefreshToken();
      if (existingRefreshToken == null || existingRefreshToken.isEmpty) {
        _logger.w('No dummy refresh token found. Cannot refresh.');
        await logout(); // Force logout if no refresh token
        return false;
      }

      final newAuthToken = 'dummy_refreshed_auth_token_${const Uuid().v4()}';
      final newRefreshToken =
          'dummy_rotated_refresh_token_${const Uuid().v4()}'; // Simulate refresh token rotation
      await _secureStorageService.writeAuthToken(newAuthToken);
      await _secureStorageService.writeRefreshToken(
        newRefreshToken,
      ); // FIX: Changed to writeRefreshToken
      _logger.i('Dummy token refreshed successfully.');
      notifyListeners();
      return true;
    } catch (e) {
      _logger.e('Failed to refresh dummy token: $e');
      await _secureStorageService.deleteAuthToken();
      await _secureStorageService
          .deleteRefreshToken(); // Clear refresh token on failure
      _currentUser = null;
      notifyListeners();
      return false;
    }
    // --- END DUMMY DATA LOGIC ---

    /*
    // --- LIVE API CALLS (UNCOMMENT FOR PRODUCTION) ---
    try {
      final refreshToken = await _secureStorageService.readRefreshToken();
      if (refreshToken == null) {
        _logger.w('No refresh token found. Cannot refresh.');
        await logout();
        return false;
      }

      final response = await _apiService.post('auth/refresh-token', {
        'refreshToken': refreshToken,
      });

      final String? newAuthToken = response['token'];
      final String? newRefreshToken = response['refreshToken'];

      if (newAuthToken != null) {
        await _secureStorageService.writeAuthToken(newAuthToken);
        if (newRefreshToken != null) {
          await _secureStorageService.writeRefreshToken(newRefreshToken);
        }
        _logger.i('Token refreshed successfully.');
        notifyListeners();
        return true;
      } else {
        _logger.e('Failed to refresh token: New token not received from API.');
        await logout();
        return false;
      }
    } catch (e) {
      _logger.e('Failed to refresh token: $e');
      await logout();
      return false;
    }
    // --- END LIVE API CALLS ---
    */
  }

  /// Changes the user's password (using dummy data).
  Future<void> changePassword({
    required String emailOrPhone,
    required String oldPassword,
    required String newPassword,
  }) async {
    _logger.i('Attempting password change for: $emailOrPhone');
    // --- DUMMY DATA LOGIC (FOR TESTING) ---
    await Future.delayed(const Duration(seconds: 2));

    if (_currentUser != null &&
        (_currentUser!.email == emailOrPhone ||
            _currentUser!.phone == emailOrPhone) &&
        oldPassword == 'Password123!') {
      _logger.i('Dummy password changed successfully for $emailOrPhone.');
      return;
    } else {
      _logger.w(
        'Dummy password change failed for $emailOrPhone: Invalid old password or credentials.',
      );
      throw Exception('Invalid old password or user not found.');
    }
    // --- END DUMMY DATA LOGIC ---

    /*
    // --- LIVE API CALLS (UNCOMMENT FOR PRODUCTION) ---
    try {
      await _apiService.post('auth/change-password', {
        'emailOrPhone': emailOrPhone,
        'oldPassword': oldPassword,
        'newPassword': newPassword,
      });
      _logger.i('Password changed successfully for $emailOrPhone.');
    } catch (e) {
      _logger.e('Password change error: $e');
      rethrow;
    }
    // --- END LIVE API CALLS ---
    */
  }

  /// Initiates the forgot password process (using dummy data).
  Future<void> forgotPassword({required String email}) async {
    _logger.i('Attempting forgot password for: $email');
    // --- DUMMY DATA LOGIC (FOR TESTING) ---
    await Future.delayed(const Duration(seconds: 2));

    if (email == 'user@example.com') {
      _pendingOtpVerificationEmailOrPhone = email;
      _lastGeneratedVerificationId = const Uuid().v4();
      _lastSentOtp = '543210';
      _logger.i(
        'Dummy password reset OTP sent to $email. Verification ID: $_lastGeneratedVerificationId',
      );
      return;
    } else {
      _logger.w('Dummy forgot password failed for $email: Email not found.');
      throw Exception('Email not found.');
    }
    // --- END DUMMY DATA LOGIC ---

    /*
    // --- LIVE API CALLS (UNCOMMENT FOR PRODUCTION) ---
    try {
      await _apiService.post('auth/forgot-password', {
        'email': email,
      });
      _logger.i('Password reset OTP sent to $email.');
    } catch (e) {
      _logger.e('Forgot password error: $e');
      rethrow;
    }
    // --- END LIVE API CALLS ---
    */
  }

  /// Resets the user's password using a verification token (using dummy data).
  Future<void> resetPassword({
    required String token,
    required String newPassword,
  }) async {
    _logger.i('Attempting password reset with token.');
    // --- DUMMY DATA LOGIC (FOR TESTING) ---
    await Future.delayed(const Duration(seconds: 2));

    if (token.isNotEmpty) {
      _logger.i('Dummy password reset successfully.');
      return;
    } else {
      _logger.w('Dummy password reset failed: Invalid or expired token.');
      throw Exception('Invalid or expired reset token.');
    }
    // --- END DUMMY DATA LOGIC ---

    /*
    // --- LIVE API CALLS (UNCOMMENT FOR PRODUCTION) ---
    try {
      await _apiService.post('auth/reset-password', {
        'token': token,
        'newPassword': newPassword,
      });
      _logger.i('Password reset successfully.');
    } catch (e) {
      _logger.e('Password reset error: $e');
      rethrow;
    }
    // --- END LIVE API CALLS ---
    */
  }

  /// Sets a transaction passcode for the user (using dummy data).
  Future<void> setPasscode({required String passcode}) async {
    _logger.i('Attempting to set passcode.');
    // --- DUMMY DATA LOGIC (FOR TESTING) ---
    await Future.delayed(const Duration(seconds: 1));

    if (passcode.length == 4 && RegExp(r'^[0-9]+$').hasMatch(passcode)) {
      _dummyPasscode = passcode;
      _logger.i('Passcode set successfully.');
      return;
    } else {
      _logger.w('Passcode set failed: Invalid passcode format.');
      throw Exception('Passcode must be a 4-digit number.');
    }
    // --- END DUMMY DATA LOGIC ---

    /*
    // --- LIVE API CALLS (UNCOMMENT FOR PRODUCTION) ---
    try {
      await _apiService.post('auth/set-passcode', {
        'passcode': passcode,
      });
      _logger.i('Passcode set successfully.');
    } catch (e) {
      _logger.e('Set passcode error: $e');
      rethrow;
    }
    // --- END LIVE API CALLS ---
    */
  }

  /// Checks if a passcode has been set for the user (using dummy data).
  bool hasPasscode() {
    // --- DUMMY DATA LOGIC (FOR TESTING) ---
    return _dummyPasscode != null && _dummyPasscode!.isNotEmpty;
    // --- END DUMMY DATA LOGIC ---

    /*
    // --- LIVE API CALLS (UNCOMMENT FOR PRODUCTION) ---
    // This might require an API call to check user's passcode status
    // or rely on a local flag if your backend supports it.
    // For now, this is a placeholder. You might need a dedicated API endpoint like 'auth/has-passcode'
    try {
      final response = _apiService.get('auth/has-passcode'); // Note: This should be async if it hits API
      return response['hasPasscode'] ?? false;
    } catch (e) {
      _logger.e('Error checking passcode status: $e');
      return false; // Assume no passcode on error
    }
    // --- END LIVE API CALLS ---
    */
  }

  /// Authenticates with a given passcode (using dummy data).
  Future<bool> authenticateWithPasscode(String passcode) async {
    _logger.i('Attempting to authenticate with passcode.');
    // --- DUMMY DATA LOGIC (FOR TESTING) ---
    await Future.delayed(const Duration(milliseconds: 500));
    return _dummyPasscode == passcode;
    // --- END DUMMY DATA LOGIC ---

    /*
    // --- LIVE API CALLS (UNCOMMENT FOR PRODUCTION) ---
    try {
      final response = await _apiService.post('auth/authenticate-passcode', {
        'passcode': passcode,
      });
      return response['success'] == true;
    } catch (e) {
      _logger.e('Passcode authentication failed: $e');
      return false;
    }
    // --- END LIVE API CALLS ---
    */
  }

  /// Updates the user's personal details (using dummy data).
  Future<void> updatePersonalDetails({
    String? firstName,
    String? lastName,
    String? email,
    String? phone,
    String? gender,
    String? dob,
    String? address,
    String? profilePictureUrl,
  }) async {
    _logger.i('Attempting to update personal details.');

    // --- DUMMY DATA LOGIC (FOR TESTING) ---
    await Future.delayed(const Duration(seconds: 2));

    if (_currentUser == null) {
      _logger.w('Cannot update personal details: No current user logged in.');
      throw Exception('No user logged in.');
    }

    // Validation
    if (email != null &&
        !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email)) {
      _logger.w('Invalid email format: $email');
      throw Exception('Invalid email format.');
    }
    if (dob != null && DateTime.tryParse(dob) == null) {
      _logger.w('Invalid date of birth format: $dob');
      throw Exception('Invalid date of birth format.');
    }

    // Apply updates to the dummy current user
    _currentUser = _currentUser!.copyWith(
      fullName: firstName != null && lastName != null
          ? '$firstName $lastName'
          : _currentUser!.fullName,
      email: email ?? _currentUser!.email,
      phone: phone ?? _currentUser!.phone,
      address: address ?? _currentUser!.address,
      profilePictureUrl: profilePictureUrl ?? _currentUser!.profilePictureUrl,
      gender: gender ?? _currentUser!.gender,
      dob: dob != null ? DateTime.tryParse(dob) : _currentUser!.dob,
    );

    _logger.i('Dummy personal details updated successfully.');
    notifyListeners();
    // --- END DUMMY DATA LOGIC ---

    /*
    // --- LIVE API CALLS (UNCOMMENT FOR PRODUCTION) ---
    if (_currentUser == null) {
      throw Exception('No user logged in to update.');
    }
    try {
      final response = await _apiService.put(
        'users/profile',
        {
          'firstName': firstName,
          'lastName': lastName,
          'email': email,
          'phone': phone,
          'gender': gender,
          'dob': dob,
          'address': address,
          'profilePictureUrl': profilePictureUrl,
        },
      );
      _currentUser = User.fromJson(response);
      _logger.i('Personal details updated successfully.');
      notifyListeners();
    } catch (e) {
      _logger.e('Failed to update personal details: $e');
      rethrow;
    }
    // --- END LIVE API CALLS ---
    */
  }

  /// Marks the user's profile as complete (using dummy data).
  Future<void> markProfileComplete() async {
    _logger.i('Marking profile as complete.');
    // --- DUMMY DATA LOGIC (FOR TESTING) ---
    await _prefs.setBool(_kProfileCompleteKey, true);
    await _prefs.setBool(_kInitialSetupRequiredKey, false);
    _logger.i('Dummy Profile marked as complete.');
    notifyListeners();
    // --- END DUMMY DATA LOGIC ---

    /*
    // --- LIVE API CALLS (UNCOMMENT FOR PRODUCTION) ---
    try {
      await _apiService.post('auth/mark-profile-complete', {});
      await _prefs.setBool(_kProfileCompleteKey, true);
      await _prefs.setBool(_kInitialSetupRequiredKey, false);
      _logger.i('Profile marked as complete on both backend and locally.');
      notifyListeners();
    } catch (e) {
      _logger.e('Failed to mark profile complete: $e');
      rethrow;
    }
    // --- END LIVE API CALLS ---
    */
  }

  /// Checks if the user's profile is complete.
  bool isProfileComplete() {
    return _prefs.getBool(_kProfileCompleteKey) ?? false;
  }

  /// Checks if initial setup is required for the user.
  bool isInitialSetupRequired() {
    return _prefs.getBool(_kInitialSetupRequiredKey) ?? false;
  }

  /// Checks if the user is currently logged in (based on dummy data).
  Future<bool> isLoggedIn() async {
    _logger.d('Checking login status...');
    final token = await _secureStorageService.readAuthToken();
    return token != null && token.isNotEmpty && _currentUser != null;
  }

  /// Simulates/Calls API for ID card scanning (using dummy data).
  Future<bool> scanIdCard() async {
    _logger.i('Simulating ID Card scan.');
    // --- DUMMY DATA LOGIC (FOR TESTING) ---
    await Future.delayed(const Duration(seconds: 3));
    final bool success = true;
    _logger.i('ID Card scan result: $success');
    return success;
    // --- END DUMMY DATA LOGIC ---

    /*
    // --- LIVE API CALLS (UNCOMMENT FOR PRODUCTION) ---
    try {
      final response = await _apiService.post('auth/scan-id-card', {});
      return response['success'] == true;
    } catch (e) {
      _logger.e('ID card scan failed: $e');
      return false;
    }
    // --- END LIVE API CALLS ---
    */
  }

  /// Simulates/Calls API for face scanning (using dummy data).
  Future<bool> scanFace() async {
    _logger.i('Simulating Face scan.');
    // --- DUMMY DATA LOGIC (FOR TESTING) ---
    await Future.delayed(const Duration(seconds: 3));
    final bool success = true;
    _logger.i('Face scan result: $success');
    return success;
    // --- END DUMMY DATA LOGIC ---

    /*
    // --- LIVE API CALLS (UNCOMMENT FOR PRODUCTION) ---
    try {
      final response = await _apiService.post('auth/scan-face', {});
      return response['success'] == true;
    } catch (e) {
      _logger.e('Face scan failed: $e');
      return false;
    }
    // --- END LIVE API CALLS ---
    */
  }
}
