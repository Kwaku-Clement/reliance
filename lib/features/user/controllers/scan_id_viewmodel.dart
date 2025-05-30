import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:reliance/core/router/app_router.dart';
import 'package:reliance/features/auth/controllers/base_auth_viewmodel.dart';
import 'package:reliance/features/user/controllers/user_service.dart';
// import 'package:reliance/features/auth/models/user_model.dart'; // No longer directly used here, but keep if needed elsewhere
import 'package:reliance/l10n/app_localizations.dart';

class ScanIdViewModel extends BaseAuthViewModel {
  final UserService _userService; // Use UserService for ID uploads
  final AppRouter _appRouter;
  final ImagePicker _picker = ImagePicker();

  File? _idFrontImage;
  File? _idBackImage;

  // You might want to store extracted data in a real scenario
  Map<String, dynamic>? _extractedIdFrontData;
  Map<String, dynamic>? _extractedIdBackData;

  ScanIdViewModel(this._userService, Logger logger, this._appRouter)
    : super(logger);

  File? get idFrontImagePath => _idFrontImage;
  File? get idBackImagePath => _idBackImage;

  Map<String, dynamic>? get extractedIdFrontData => _extractedIdFrontData;
  Map<String, dynamic>? get extractedIdBackData => _extractedIdBackData;

  /// Opens the camera to pick an image for either the ID front or back.
  ///
  /// In a production scenario for ID scanning, this would integrate with
  /// a dedicated ID scanning SDK that provides OCR capabilities.
  Future<void> pickImage(BuildContext context, {required bool isFront}) async {
    if (isDisposed || isLoading) return;
    final localizations = AppLocalizations.of(context)!;

    try {
      // --- PRODUCTION READY (COMMENTED OUT) ---
      /*
      // Example: Integration with a hypothetical ID scanning SDK
      updateLoading(true);
      clearError();
      logger.i('Launching ID scan camera for ${isFront ? 'front' : 'back'}...');
      final result = await IdScanSDK.startScan(isFront: isFront); // Replace with actual SDK call

      if (result.isSuccess) {
        final imageFile = File(result.imagePath);
        final extractedData = result.extractedData; // Data from OCR

        if (isFront) {
          _idFrontImage = imageFile;
          _extractedIdFrontData = extractedData;
        } else {
          _idBackImage = imageFile;
          _extractedIdBackData = extractedData;
        }
        logger.i('ID ${isFront ? 'front' : 'back'} scan successful. Data extracted.');
        safeNotifyListeners();
      } else {
        error = localizations.imagePickError + ': ${result.errorMessage}';
        logger.e('ID scan failed: ${result.errorMessage}');
      }
      */
      // --- END PRODUCTION READY (COMMENTED OUT) ---

      // --- DUMMY DATA LOGIC (FOR TESTING) ---
      logger.i(
        'Launching camera for dummy ID ${isFront ? 'front' : 'back'} capture...',
      );
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.camera,
      );
      if (pickedFile != null) {
        if (isFront) {
          _idFrontImage = File(pickedFile.path);
          // Simulate extracted data for testing
          _extractedIdFrontData = {
            'documentType': 'ID Card',
            'issueDate': '2020-01-01',
            'expiryDate': '2030-12-31',
            'dummyFieldFront': 'dummy_value_front',
          };
        } else {
          _idBackImage = File(pickedFile.path);
          // Simulate extracted data for testing
          _extractedIdBackData = {
            'address': '123 Main St, Anytown',
            'signaturePresent': true,
            'dummyFieldBack': 'dummy_value_back',
          };
        }
        logger.i(
          'Dummy ID ${isFront ? 'front' : 'back'} captured. Dummy data generated.',
        );
        safeNotifyListeners();
      } else {
        logger.i('ID ${isFront ? 'front' : 'back'} capture cancelled by user.');
      }
      // --- END DUMMY DATA LOGIC ---
    } catch (e) {
      if (isDisposed) return;
      error = localizations.imagePickError;
      logger.e('Image picking failed: $e');
    } finally {
      // updateLoading(false); // Only set to false if it was set to true initially in try block
    }
  }

  Future<void> pickIdFront(BuildContext context) async {
    await pickImage(context, isFront: true);
  }

  Future<void> pickIdBack(BuildContext context) async {
    await pickImage(context, isFront: false);
  }

  /// Submits the captured ID scans (front and back) and any extracted data to the server.
  Future<void> submitIdScans(BuildContext context) async {
    if (isDisposed || isLoading) return;
    final localizations = AppLocalizations.of(context)!;

    if (_idFrontImage == null || _idBackImage == null) {
      error = localizations.idScanRequired;
      return;
    }

    updateLoading(true);
    clearError();

    try {
      // --- PRODUCTION READY (COMMENTED OUT) ---
      /*
      // Call the actual UserService to upload the ID scans and extracted data
      await _userService.uploadIdScans(
        idFront: _idFrontImage!,
        idBack: _idBackImage!,
        idFrontData: _extractedIdFrontData, // Pass extracted data
        idBackData: _extractedIdBackData,
      );
      */
      // --- END PRODUCTION READY (COMMENTED OUT) ---

      // --- DUMMY DATA LOGIC (FOR TESTING) ---
      logger.i('Simulating ID scans upload with dummy data...');
      await Future.delayed(const Duration(seconds: 2)); // Simulate API call
      logger.i('Dummy ID scans uploaded successfully.');
      // --- END DUMMY DATA LOGIC ---

      if (isDisposed) return;

      logger.i('ID scans submitted successfully');
      // Navigate to the next step in the profile setup flow
      _appRouter.navigateToScanFace(); // PUSH: allows going back
    } catch (e) {
      if (isDisposed) return;
      error = localizations.idScanUploadError;
      logger.e('ID scan submission failed: $e');
    } finally {
      updateLoading(false);
    }
  }

  @override
  void dispose() {
    _idFrontImage = null; // Clear image references
    _idBackImage = null;
    _extractedIdFrontData = null;
    _extractedIdBackData = null;
    super.dispose();
  }
}
