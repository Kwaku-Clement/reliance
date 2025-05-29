import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:reliance/core/router/app_router.dart';
import 'package:reliance/features/auth/controllers/base_auth_viewmodel.dart';
import 'package:reliance/features/auth/models/user_model.dart';
import 'package:reliance/l10n/app_localizations.dart';

class ScanIdViewModel extends BaseAuthViewModel {
  final User _userService;
  final AppRouter _appRouter;
  final ImagePicker _picker = ImagePicker();

  File? _idFrontImage;
  File? _idBackImage;

  ScanIdViewModel(this._userService, Logger logger, this._appRouter)
    : super(logger);

  File? get idFrontImagePath => _idFrontImage;
  File? get idBackImagePath => _idBackImage;

  Future<void> pickImage(BuildContext context, {required bool isFront}) async {
    if (isDisposed || isLoading) return;
    final localizations = AppLocalizations.of(context)!;

    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.camera,
      ); // Or .gallery
      if (pickedFile != null) {
        if (isFront) {
          _idFrontImage = File(pickedFile.path);
        } else {
          _idBackImage = File(pickedFile.path);
        }
        safeNotifyListeners();
      }
    } catch (e) {
      if (isDisposed) return;
      error = localizations.imagePickError; // e.g., "Failed to pick image."
      logger.e('Image picking failed: $e');
    }
  }

  Future<void> pickIdFront(BuildContext context) async {
    await pickImage(context, isFront: true);
  }

  Future<void> pickIdBack(BuildContext context) async {
    await pickImage(context, isFront: false);
  }

  Future<void> submitIdScans(BuildContext context) async {
    if (isDisposed || isLoading) return;
    final localizations = AppLocalizations.of(context)!;

    if (_idFrontImage == null || _idBackImage == null) {
      error = localizations
          .idScanRequired; // e.g., "Please scan both front and back of your ID."
      return;
    }

    updateLoading(true);
    clearError();

    try {
      // Implement your upload logic here
      // await _userService.uploadIdScans(
      //   idFront: _idFrontImage!,
      //   idBack: _idBackImage!,
      // );
      await Future.delayed(const Duration(seconds: 2)); // Simulate API call

      if (isDisposed) return;

      logger.i('ID scans submitted successfully');
      // Navigate to the next step in the profile setup flow
      _appRouter.navigateToScanFace(); // PUSH: allows going back
    } catch (e) {
      if (isDisposed) return;
      error =
          localizations.idScanUploadError; // e.g., "Failed to upload ID scans."
      logger.e('ID scan submission failed: $e');
    } finally {
      updateLoading(false);
    }
  }

  @override
  void dispose() {
    _idFrontImage = null; // Clear image references
    _idBackImage = null;
    super.dispose();
  }
}
