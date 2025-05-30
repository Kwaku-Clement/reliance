import 'dart:io';
import 'package:logger/logger.dart';
import 'package:reliance/core/services/api_service.dart';
import 'package:reliance/features/auth/models/user_model.dart'; // Assuming User model is in this path

class UserService {
  final ApiService _apiService;
  final Logger _logger;

  UserService(this._apiService, this._logger);

  /// Uploads ID card front and back images to the server.
  ///
  /// For production, this would typically involve multipart form data
  /// and potentially extracted OCR data.
  Future<void> uploadIdScans({
    required File idFront,
    required File idBack,
    Map<String, dynamic>? idFrontData, // Extracted data from front
    Map<String, dynamic>? idBackData, // Extracted data from back
  }) async {
    _logger.i('Attempting to upload ID scans...');

    // --- PRODUCTION READY (COMMENTED OUT) ---
    /*
    try {
      // You would typically use a multipart request for file uploads.
      // This is a simplified example.
      final formData = FormData.fromMap({
        'idFront': await MultipartFile.fromFile(idFront.path, filename: 'id_front.jpg'),
        'idBack': await MultipartFile.fromFile(idBack.path, filename: 'id_back.jpg'),
        'idFrontMetadata': jsonEncode(idFrontData), // Send extracted data as JSON string
        'idBackMetadata': jsonEncode(idBackData),
      });

      await _apiService.post('user/id-verification', formData);
      _logger.i('ID scans uploaded successfully to backend.');
    } catch (e) {
      _logger.e('Failed to upload ID scans: $e');
      rethrow;
    }
    */
    // --- END PRODUCTION READY (COMMENTED OUT) ---

    // --- DUMMY DATA LOGIC (FOR TESTING) ---
    _logger.i('Simulating ID scan upload...');
    await Future.delayed(const Duration(seconds: 3)); // Simulate network delay
    _logger.i('Dummy ID scans processed by UserService.');
    // In a real scenario, you might return a success/failure status or verification ID
    // --- END DUMMY DATA LOGIC ---
  }

  /// Uploads a face scan image and liveness detection data to the server.
  ///
  /// For production, this would typically involve multipart form data
  /// and the liveness proof token/data from the SDK.
  Future<void> uploadFaceScan({
    required File faceImage,
    required String livenessData, // Data/token from liveness detection SDK
  }) async {
    _logger.i('Attempting to upload face scan with liveness data...');

    // --- PRODUCTION READY (COMMENTED OUT) ---
    /*
    try {
      final formData = FormData.fromMap({
        'faceImage': await MultipartFile.fromFile(faceImage.path, filename: 'face_scan.jpg'),
        'livenessProof': livenessData, // This would be a token or specific data from the liveness SDK
      });

      await _apiService.post('user/face-verification', formData);
      _logger.i('Face scan with liveness data uploaded successfully to backend.');
    } catch (e) {
      _logger.e('Failed to upload face scan: $e');
      rethrow;
    }
    */
    // --- END PRODUCTION READY (COMMENTED OUT) ---

    // --- DUMMY DATA LOGIC (FOR TESTING) ---
    _logger.i('Simulating face scan upload with liveness data...');
    await Future.delayed(const Duration(seconds: 3)); // Simulate network delay
    _logger.i('Dummy face scan and liveness data processed by UserService.');
    // In a real scenario, you might return a success/failure status or verification ID
    // --- END DUMMY DATA LOGIC ---
  }

  // You can add other user-related API calls here, e.g., fetching user profile
  Future<User?> fetchUserProfile() async {
    _logger.i('Fetching user profile...');
    // --- DUMMY DATA LOGIC (FOR TESTING) ---
    await Future.delayed(const Duration(seconds: 1));
    return User(
      id: 'dummy_user_id',
      username: 'dummyuser',
      fullName: 'Dummy User',
      email: 'dummy@example.com',
      phone: '+1234567890',
      roles: ['user'],
    );
    // --- END DUMMY DATA LOGIC ---

    /*
    // --- LIVE API CALLS (UNCOMMENT FOR PRODUCTION) ---
    try {
      final response = await _apiService.get('user/profile');
      return User.fromJson(response);
    } catch (e) {
      _logger.e('Failed to fetch user profile: $e');
      return null;
    }
    // --- END LIVE API CALLS ---
    */
  }
}
