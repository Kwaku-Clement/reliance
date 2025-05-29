import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:reliance/core/router/app_router.dart';
import 'package:reliance/core/services/auth_service.dart';
import 'package:reliance/features/auth/controllers/base_auth_viewmodel.dart';
import 'package:reliance/features/auth/models/user_model.dart';
import 'package:reliance/l10n/app_localizations.dart';

class ScanFaceViewModel extends BaseAuthViewModel {
  final User _userService;
  final AuthService _authService;
  final AppRouter _appRouter;
  final ImagePicker _picker = ImagePicker();

  File? _faceImage;

  ScanFaceViewModel(
    this._userService,
    this._authService,
    Logger logger,
    this._appRouter,
  ) : super(logger);

  File? get faceImagePath => _faceImage;

  Future<void> takeSelfie(BuildContext context) async {
    if (isDisposed || isLoading) return;
    final localizations = AppLocalizations.of(context)!;

    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.camera,
      );
      if (pickedFile != null) {
        _faceImage = File(pickedFile.path);
        safeNotifyListeners();
      }
    } catch (e) {
      if (isDisposed) return;
      error = localizations.selfieCaptureError;
      logger.e('Selfie capture failed: $e');
    }
  }

  Future<void> submitFaceScan(BuildContext context) async {
    if (isDisposed || isLoading) return;
    final localizations = AppLocalizations.of(context)!;

    if (_faceImage == null) {
      error = localizations.selfieRequired;
      return;
    }

    updateLoading(true);
    clearError();

    try {
      // Implement your upload logic here
      // await _userService.uploadFaceScan(faceImage: _faceImage!);
      await Future.delayed(const Duration(seconds: 2)); // Simulate API call

      // Mark initial setup as complete in AuthService
      await _authService.markProfileComplete();

      if (isDisposed) return;

      logger.i('Face scan submitted successfully and profile setup complete');

      // Clear the stack and go to home after successful profile setup completion
      _appRouter.navigateToHomeAndClearStack();
    } catch (e) {
      if (isDisposed) return;
      error = localizations
          .faceScanUploadError; // e.g., "Failed to upload face scan."
      logger.e('Face scan submission failed: $e');
    } finally {
      updateLoading(false);
    }
  }

  @override
  void dispose() {
    _faceImage = null; // Clear image reference
    super.dispose();
  }
}
