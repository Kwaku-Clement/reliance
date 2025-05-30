import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:reliance/core/services/auth_service.dart';
import 'package:logger/logger.dart';

class PersonalDetailsViewModel extends ChangeNotifier {
  final AuthService _authService;
  final Logger _logger = Logger();

  PersonalDetailsViewModel() : _authService = GetIt.I.get<AuthService>();

  // Form controllers
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController dobController = TextEditingController();

  // Gender selection
  String? selectedGender;

  // Loading and error states
  bool isLoading = false;
  String? error;

  /// Initialize the view model
  void initialize() {
    // Clear any previous data
    firstNameController.clear();
    lastNameController.clear();
    dobController.clear();
    selectedGender = null;
    error = null;
    notifyListeners();
  }

  /// Set gender selection
  void setGender(String? gender) {
    selectedGender = gender;
    notifyListeners();
  }

  /// Select date of birth
  Future<void> selectDateOfBirth(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().subtract(
        const Duration(days: 18 * 365),
      ), // 18 years ago
      firstDate: DateTime(1900),
      lastDate: DateTime.now().subtract(
        const Duration(days: 18 * 365),
      ), // Must be at least 18
    );

    if (picked != null) {
      dobController.text = picked.toIso8601String().split('T')[0];
      notifyListeners();
    }
  }

  /// Clear error message
  void clearError() {
    error = null;
    notifyListeners();
  }

  /// Submit personal details
  Future<void> submitPersonalDetails(BuildContext context) async {
    try {
      // Clear any previous errors
      error = null;
      notifyListeners();

      // Validate inputs
      if (firstNameController.text.trim().isEmpty) {
        error = "First name is required";
        notifyListeners();
        return;
      }

      if (lastNameController.text.trim().isEmpty) {
        error = "Last name is required";
        notifyListeners();
        return;
      }

      if (dobController.text.trim().isEmpty) {
        error = "Date of birth is required";
        notifyListeners();
        return;
      }

      if (selectedGender == null) {
        error = "Please select your gender";
        notifyListeners();
        return;
      }

      // Validate age (must be at least 18)
      final dob = DateTime.parse(dobController.text);
      final age = DateTime.now().difference(dob).inDays / 365;
      if (age < 18) {
        error = "You must be at least 18 years old";
        notifyListeners();
        return;
      }

      // Set loading state
      isLoading = true;
      notifyListeners();

      // PRODUCTION CODE (commented out for testing)
      /*
      await _authService.savePersonalDetails(
        firstName: firstNameController.text.trim(),
        lastName: lastNameController.text.trim(),
        dateOfBirth: dobController.text.trim(),
        gender: selectedGender!,
      );
      */

      // DUMMY DATA FOR TESTING
      await Future.delayed(const Duration(seconds: 1));
      _logger.i('Personal details saved (dummy)');

      // Update profile setup status using markProfileComplete
      await _authService.markProfileComplete();

      _logger.i('Personal details saved successfully');

      // Clear loading state
      isLoading = false;
      notifyListeners();

      // Navigate to next step (ID scan)
      if (context.mounted) {
        context.pushNamed('scan-id');
      }
    } catch (e) {
      isLoading = false;
      error = "Failed to save personal details: ${e.toString()}";
      _logger.e('Error saving personal details: $e');
      notifyListeners();
    }
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    dobController.dispose();
    super.dispose();
  }
}
