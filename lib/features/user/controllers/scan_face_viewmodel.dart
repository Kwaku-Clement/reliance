import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:reliance/core/router/app_router.dart';
import 'package:reliance/core/services/auth_service.dart';
import 'package:reliance/features/auth/controllers/base_auth_viewmodel.dart';
import 'package:reliance/features/user/controllers/user_service.dart';
import 'package:reliance/l10n/app_localizations.dart';

class ScanFaceViewModel extends BaseAuthViewModel {
  final AuthService _authService;
  final AppRouter _appRouter;
  final ImagePicker _picker = ImagePicker();
  final UserService _userService; // Add UserService dependency

  File? _faceImage;
  // This would typically come from a liveness detection SDK
  String? _facialExpressionData;

  ScanFaceViewModel(
    this._authService,
    Logger logger,
    this._appRouter,
    this._userService, // Inject UserService
  ) : super(logger);

  File? get faceImagePath => _faceImage;
  String? get facialExpressionData => _facialExpressionData;

  /// Opens the camera to take a selfie.
  ///
  /// In a production scenario for Face ID with liveness, this method
  /// would integrate with a dedicated liveness detection SDK.
  /// For testing, we use ImagePicker to simulate photo capture.
  Future<void> takeSelfie(BuildContext context) async {
    if (isDisposed || isLoading) return;
    final localizations = AppLocalizations.of(context)!;

    try {
      // --- PRODUCTION READY (COMMENTED OUT) ---
      /*
      // Example: Integration with a hypothetical liveness SDK
      updateLoading(true);
      clearError();
      logger.i('Launching liveness detection camera...');
      final result = await LivenessSDK.startLivenessCapture(); // Replace with actual SDK call

      if (result.isSuccess) {
        _faceImage = File(result.imagePath);
        _facialExpressionData = result.livenessProof; // Data from liveness check
        logger.i('Liveness capture successful. Liveness proof received.');
        safeNotifyListeners();
      } else {
        error = localizations.selfieCaptureError + ': ${result.errorMessage}';
        logger.e('Liveness capture failed: ${result.errorMessage}');
      }
      */
      // --- END PRODUCTION READY (COMMENTED OUT) ---

      // --- DUMMY DATA LOGIC (FOR TESTING) ---
      logger.i('Launching camera for dummy selfie capture...');
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.camera,
        preferredCameraDevice:
            CameraDevice.front, // Prefer front camera for selfies
      );
      if (pickedFile != null) {
        _faceImage = File(pickedFile.path);
        // Simulate facial expression data for testing
        _facialExpressionData =
            'dummy_liveness_data_${DateTime.now().millisecondsSinceEpoch}';
        logger.i('Dummy selfie captured. Dummy liveness data generated.');
        safeNotifyListeners();
      } else {
        logger.i('Selfie capture cancelled by user.');
      }
      // --- END DUMMY DATA LOGIC ---
    } catch (e) {
      if (isDisposed) return;
      error = localizations.selfieCaptureError;
      logger.e('Selfie capture failed: $e');
    } finally {
      // updateLoading(false); // Only set to false if it was set to true initially in try block
    }
  }

  /// Submits the captured face scan and facial expression data to the server.
  Future<void> submitFaceScan(BuildContext context) async {
    if (isDisposed || isLoading) return;
    final localizations = AppLocalizations.of(context)!;

    if (_faceImage == null || _facialExpressionData == null) {
      error = localizations
          .selfieRequired; // You might want a more specific message
      return;
    }

    updateLoading(true);
    clearError();

    try {
      // --- PRODUCTION READY (COMMENTED OUT) ---
      /*
      // Call the actual UserService to upload the face scan and liveness data
      await _userService.uploadFaceScan(
        faceImage: _faceImage!,
        livenessData: _facialExpressionData!,
      );
      */
      // --- END PRODUCTION READY (COMMENTED OUT) ---

      // --- DUMMY DATA LOGIC (FOR TESTING) ---
      logger.i('Simulating face scan upload with dummy data...');
      await Future.delayed(const Duration(seconds: 2)); // Simulate API call
      logger.i('Dummy face scan and liveness data uploaded successfully.');
      // --- END DUMMY DATA LOGIC ---

      // Mark initial setup as complete in AuthService
      await _authService.markProfileComplete();

      if (isDisposed) return;

      logger.i('Face scan submitted successfully and profile setup complete');

      // Clear the stack and go to home after successful profile setup completion
      _appRouter.navigateToHomeAndClearStack();
    } catch (e) {
      if (isDisposed) return;
      error = localizations.faceScanUploadError;
      logger.e('Face scan submission failed: $e');
    } finally {
      updateLoading(false);
    }
  }

  @override
  void dispose() {
    _faceImage = null;
    _facialExpressionData = null;
    super.dispose();
  }
}
