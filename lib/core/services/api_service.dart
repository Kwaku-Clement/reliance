import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:logger/logger.dart';
import 'package:uuid/uuid.dart';
import '../utils/secure_storage_service.dart';
import 'auth_service.dart';

class ApiService {
  final SecureStorageService _secureStorageService;
  final AuthService _authService;
  final Logger _logger;

  ApiService(this._secureStorageService, this._authService, this._logger);

  final String _baseUrl = 'https://your-secure-reliance-api.com/api/v1';

  Future<Map<String, dynamic>> _sendRequest(
    String method,
    String endpoint,
    Map<String, dynamic>? data,
  ) async {
    final uri = Uri.parse('$_baseUrl/$endpoint');
    String? token = await _secureStorageService.readAuthToken();

    if (token == null) {
      _logger.w('No authentication token found for request to $endpoint.');
      throw Exception(
        'Authentication required. No token found.',
      ); // Generic error
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
        default:
          throw ArgumentError('Unsupported HTTP method: $method');
      }
    }

    http.Response response = await performRequest();

    if (response.statusCode == 401 || response.statusCode == 403) {
      _logger.w(
        'Token expired or unauthorized for $endpoint. Attempting refresh...',
      );
      final refreshed = await _authService.refreshToken();
      if (refreshed) {
        token = await _secureStorageService.readAuthToken();
        if (token != null) {
          _logger.i('Token refreshed successfully. Retrying request.');
          response = await performRequest();
        } else {
          _logger.e('Failed to get new token after refresh attempt.');
          throw Exception('Session expired. Please re-login.'); // Generic error
        }
      } else {
        _logger.e('Failed to refresh token. User needs to re-login.');
        throw Exception('Session expired. Please re-login.'); // Generic error
      }
    }

    _logger.d(
      '$method $endpoint: Status ${response.statusCode}, Body: ${response.body.length > 500 ? response.body.substring(0, 500) + '...' : response.body}',
    );

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return json.decode(response.body) as Map<String, dynamic>;
    } else if (response.statusCode == 400) {
      _logger.w(
        'Bad request for $endpoint: ${response.statusCode} - ${response.body}',
      );
      throw Exception(
        'Invalid input: ${json.decode(response.body)['message'] ?? 'Please check your data.'}',
      ); // Generic error
    } else {
      _logger.e(
        'API Error for $endpoint: ${response.statusCode} - ${response.body}',
      );
      throw Exception(
        'Operation failed: ${response.statusCode} - ${response.body}',
      ); // Generic error
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
      _logger.i(
        'Dummy Payment request received with device info and location:',
      );
      _logger.i('Device Info: ${data['device_info']}');
      _logger.i('Location: ${data['location']}');
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
