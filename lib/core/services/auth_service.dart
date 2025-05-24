import 'package:logger/logger.dart';
import 'package:uuid/uuid.dart';
import '../utils/secure_storage_service.dart';

class AuthService {
  final SecureStorageService _secureStorageService;
  final Logger _logger;

  AuthService(this._secureStorageService, this._logger);

  static const String dummyUsername = 'user@example.com';
  static const String dummyPassword = 'SecurePassword123!';

  // final String _authEndpoint = 'https://your-secure-reliance-api.com/auth'; // Live API endpoint

  Future<bool> login(String username, String password) async {
    _logger.i('Attempting login for: $username');

    // --- DUMMY LOGIN LOGIC (FOR TESTING) ---
    await Future.delayed(const Duration(seconds: 2));

    if (username == dummyUsername && password == dummyPassword) {
      final dummyAuthToken = 'dummy_jwt_token_${const Uuid().v4()}';
      final dummyRefreshToken = 'dummy_refresh_token_${const Uuid().v4()}';

      await _secureStorageService.writeAuthToken(dummyAuthToken);
      await _secureStorageService.writeRefreshToken(dummyRefreshToken);
      _logger.i('Dummy login successful. Tokens stored.');
      return true;
    } else {
      _logger.w('Dummy login failed for: $username');
      return false; // Return false, UI will handle localized message
    }
    // --- END DUMMY LOGIN LOGIC ---

    // --- LIVE API LOGIN (UNCOMMENT FOR PRODUCTION) ---
    /*
    try {
      final response = await http.post(
        Uri.parse('$_authEndpoint/login'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'username': username, 'password': password}),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final String? authToken = data['accessToken'];
        final String? refreshToken = data['refreshToken'];

        if (authToken != null && refreshToken != null) {
          await _secureStorageService.writeAuthToken(authToken);
          await _secureStorageService.writeRefreshToken(refreshToken);
          _logger.i('Live API login successful. Tokens stored.');
          return true;
        } else {
          _logger.e('Login API response missing tokens.');
          return false;
        }
      } else {
        _logger.w('Login API failed: ${response.statusCode} - ${response.body}');
        return false;
      }
    } catch (e) {
      _logger.e('Error during live API login: $e');
      return false;
    }
    */
    // --- END LIVE API LOGIN ---
  }

  Future<void> logout() async {
    _logger.i('Logging out...');
    await _secureStorageService.deleteAllTokens();
    _logger.i('Tokens cleared. User logged out.');
    /*
    try {
      final token = await _secureStorageService.readAuthToken();
      if (token != null) {
        await http.post(
          Uri.parse('$_authEndpoint/logout'),
          headers: {'Authorization': 'Bearer $token'},
        );
      }
    } catch (e) {
      _logger.e('Error calling logout API: $e');
    }
    */
  }

  Future<bool> isAuthenticated() async {
    final token = await _secureStorageService.readAuthToken();
    return token != null;
  }

  Future<bool> refreshToken() async {
    final refreshToken = await _secureStorageService.readRefreshToken();
    if (refreshToken == null) {
      _logger.w('No refresh token available. Cannot refresh.');
      return false;
    }

    _logger.i('Attempting to refresh token...');
    // --- DUMMY REFRESH LOGIC (FOR TESTING) ---
    await Future.delayed(const Duration(seconds: 1));
    final newAuthToken = 'dummy_new_jwt_token_${const Uuid().v4()}';
    final newRefreshToken = 'dummy_new_refresh_token_${const Uuid().v4()}';
    await _secureStorageService.writeAuthToken(newAuthToken);
    await _secureStorageService.writeRefreshToken(newRefreshToken);
    _logger.i('Dummy token refresh successful.');
    return true;
    // --- END DUMMY REFRESH LOGIC ---

    // --- LIVE API REFRESH (UNCOMMENT FOR PRODUCTION) ---
    /*
    try {
      final response = await http.post(
        Uri.parse('$_authEndpoint/refresh'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'refreshToken': refreshToken}),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final String? newAuthToken = data['accessToken'];
        final String? newRefreshToken = data['refreshToken'];

        if (newAuthToken != null && newRefreshToken != null) {
          await _secureStorageService.writeAuthToken(newAuthToken);
          await _secureStorageService.writeRefreshToken(newRefreshToken);
          _logger.i('Live API token refresh successful.');
          return true;
        } else {
          _logger.e('Refresh API response missing new tokens.');
          return false;
        }
      } else {
        _logger.w('Refresh API failed: ${response.statusCode} - ${response.body}');
        return false;
      }
    } catch (e) {
      _logger.e('Error during live API token refresh: $e');
      return false;
    }
    */
    // --- END LIVE API REFRESH ---
  }
}
