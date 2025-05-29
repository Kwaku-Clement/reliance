import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:logger/logger.dart';
import 'package:uuid/uuid.dart';
import '../utils/secure_storage_service.dart';
// No longer directly imports AuthService for constructor injection to break circular dependency
// import 'auth_service.dart';

class ApiService {
  final SecureStorageService _secureStorageService;
  final Logger logger;
  // This will be set by GetIt after AuthService is also initialized.
  // It's `late` because it's not available at the exact moment ApiService is constructed.
  late Function _refreshTokenCallback;

  ApiService(this._secureStorageService, this.logger);

  // Method to set the refresh token callback, typically called by the dependency injector
  void setRefreshTokenCallback(Future<bool> Function() callback) {
    _refreshTokenCallback = callback;
  }

  final String _baseUrl = 'https://your-secure-reliance-api.com/api/v1';

  Future<Map<String, dynamic>> _sendRequest(
    String method,
    String endpoint,
    Map<String, dynamic>? data,
  ) async {
    final uri = Uri.parse('$_baseUrl/$endpoint');
    String? token = await _secureStorageService.readAuthToken();

    // Ensure we have a token before proceeding. If not, consider it an auth error.
    if (token == null || token.isEmpty) {
      logger.w(
        'No authentication token found for request to $endpoint. Forcing re-login.',
      );
      throw Exception('Authentication required. Please re-login.');
    }

    Future<http.Response> performRequest() async {
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };

      switch (method) {
        case 'GET':
          return await http.get(uri, headers: headers);
        case 'POST':
          return await http.post(
            uri,
            headers: headers,
            body: json.encode(data),
          );
        // Add other methods like PUT, DELETE if needed
        default:
          throw ArgumentError('Unsupported HTTP method: $method');
      }
    }

    http.Response response = await performRequest();

    // If token expired or unauthorized, attempt refresh
    if ((response.statusCode == 401 || response.statusCode == 403) &&
        _refreshTokenCallback != null) {
      logger.w(
        'Token expired or unauthorized for $endpoint. Attempting refresh via callback...',
      );
      final refreshed =
          await _refreshTokenCallback(); // Call the refresh function from AuthService
      if (refreshed) {
        // After successful refresh, get the new token
        token = await _secureStorageService.readAuthToken();
        if (token != null && token.isNotEmpty) {
          logger.i('Token refreshed successfully. Retrying request.');
          response =
              await performRequest(); // Retry the original request with the new token
        } else {
          logger.e(
            'Failed to get new token after refresh attempt by AuthService.',
          );
          throw Exception('Session expired. Please re-login.');
        }
      } else {
        logger.e(
          'Failed to refresh token by AuthService. User needs to re-login.',
        );
        throw Exception('Session expired. Please re-login.');
      }
    }

    logger.d(
      '$method $endpoint: Status ${response.statusCode}, Body: ${response.body.length > 500 ? response.body.substring(0, 500) + '...' : response.body}',
    );

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return json.decode(response.body) as Map<String, dynamic>;
    } else if (response.statusCode == 400) {
      logger.w(
        'Bad request for $endpoint: ${response.statusCode} - ${response.body}',
      );
      throw Exception(
        'Invalid input: ${json.decode(response.body)['message'] ?? 'Please check your data.'}',
      );
    } else {
      logger.e(
        'API Error for $endpoint: ${response.statusCode} - ${response.body}',
      );
      throw Exception(
        'Operation failed: ${response.statusCode} - ${response.body}',
      );
    }
  }

  Future<Map<String, dynamic>> get(String endpoint) async {
    // --- DUMMY DATA LOGIC (FOR TESTING) ---
    await Future.delayed(const Duration(milliseconds: 500));
    if (endpoint == 'account/balance') {
      return {'balance': 1234.56, 'currency': 'USD'};
    } else if (endpoint == 'transactions/history') {
      return {
        'transactions': [
          {
            'id': 'tx_1',
            'type': 'credit',
            'amount': 250.00,
            'description': 'Salary',
            'date': '2025-05-20T10:00:00Z',
          },
          {
            'id': 'tx_2',
            'type': 'debit',
            'amount': 50.00,
            'description': 'Groceries',
            'date': '2025-05-21T14:30:00Z',
          },
          {
            'id': 'tx_3',
            'type': 'debit',
            'amount': 15.75,
            'description': 'Coffee',
            'date': '2025-05-22T08:15:00Z',
          },
        ],
      };
    }
    throw Exception('Dummy GET data not found for $endpoint');
    // --- END DUMMY DATA LOGIC ---

    // --- LIVE API CALLS (UNCOMMENT FOR PRODUCTION) ---
    // return _sendRequest('GET', endpoint, null);
    // --- END LIVE API CALLS ---
  }

  Future<Map<String, dynamic>> post(
    String endpoint,
    Map<String, dynamic> data,
  ) async {
    // --- DUMMY DATA LOGIC (FOR TESTING) ---
    await Future.delayed(const Duration(seconds: 1));
    if (endpoint == 'transactions/payment') {
      if ((data['amount'] as num) > 1000) {
        throw Exception(
          'Dummy error: Payment amount exceeds limit for testing.',
        );
      }
      logger.i('Dummy Payment request received with device info and location:');
      logger.i('Device Info: ${data['device_info']}');
      logger.i('Location: ${data['location']}');
      return {
        'transactionId': 'dummy_tx_${const Uuid().v4()}',
        'status': 'completed',
      };
    }
    throw Exception('Dummy POST data not handled for $endpoint');
    // --- END DUMMY DATA LOGIC ---

    // --- LIVE API CALLS (UNCOMMENT FOR PRODUCTION) ---
    // return _sendRequest('POST', endpoint, data);
    // --- END LIVE API CALLS ---
  }
}
