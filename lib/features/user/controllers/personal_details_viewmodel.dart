import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:reliance/core/router/app_router.dart';
import 'package:reliance/core/services/auth_service.dart';
import 'package:reliance/features/auth/controllers/base_auth_viewmodel.dart';
import 'package:reliance/l10n/app_localizations.dart';

class PersonalDetailsViewModel extends BaseAuthViewModel {
  // Change the type from User to AuthService
  final AuthService _authService; // <--- This should be your AuthService
  final AppRouter _appRouter;

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  String? _selectedGender;

  // Correct the constructor to accept AuthService
  PersonalDetailsViewModel(this._authService, Logger logger, this._appRouter)
    : super(logger);

  TextEditingController get firstNameController => _firstNameController;
  TextEditingController get lastNameController => _lastNameController;
  TextEditingController get dobController => _dobController;
  String? get selectedGender => _selectedGender;

  void initialize() {
    // Optionally pre-fill if user data exists
    // For now, it's assumed fresh setup.
  }

  void setGender(String? gender) {
    if (isDisposed) return;
    _selectedGender = gender;
    safeNotifyListeners();
  }

  Future<void> selectDateOfBirth(BuildContext context) async {
    if (isDisposed || isLoading) return;
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().subtract(
        const Duration(days: 365 * 18),
      ), // 18 years ago
      firstDate: DateTime(1900),
      lastDate: DateTime.now().subtract(const Duration(days: 365 * 18)),
    );
    if (picked != null) {
      _dobController.text = picked.toIso8601String().split('T').first;
      safeNotifyListeners();
    }
  }

  Future<void> submitPersonalDetails(BuildContext context) async {
    if (isDisposed || isLoading) return;
    final localizations = AppLocalizations.of(context)!;

    if (_firstNameController.text.isEmpty ||
        _lastNameController.text.isEmpty ||
        _dobController.text.isEmpty ||
        _selectedGender == null) {
      error = localizations.requiredField;
      return;
    }

    updateLoading(true);
    clearError();

    try {
      // Call your auth service to save personal details
      await _authService.updatePersonalDetails(
        // <--- Call on _authService
        firstName: _firstNameController.text.trim(),
        lastName: _lastNameController.text.trim(),
        dob: _dobController
            .text, // <--- Pass as String, or format as needed by AuthService
        gender: _selectedGender!,
      );
      if (isDisposed) return;

      logger.i('Personal details submitted successfully');
      // Navigate to the next step in the profile setup flow
      _appRouter.navigateToSetPasscode(); // PUSH: allows going back
    } catch (e) {
      if (isDisposed) return;
      error = formatAuthError(
        context,
        e,
      ); // Reusing auth error formatter, adjust as needed
    } finally {
      updateLoading(false);
    }
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _dobController.dispose();
    super.dispose();
  }
}
