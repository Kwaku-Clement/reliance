// File: lib/features/user/controllers/personal_details_viewmodel.dart
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:reliance/core/router/app_router.dart';
import 'package:reliance/core/services/auth_service.dart';

class PersonalDetailsViewModel extends ChangeNotifier {
  final Logger _logger;
  final AppRouter _router;
  final AuthService _authService;

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  String? _selectedGender;
  bool _isLoading = false;
  String? _error;

  bool get isLoading => _isLoading;
  String? get error => _error;
  String? get selectedGender => _selectedGender;

  PersonalDetailsViewModel(this._logger, this._router, this._authService);

  void initialize() {
    // In production, load existing user data if editing
    // final user = _authService.currentUser;
    // if (user != null) {
    //   firstNameController.text = user.firstName ?? '';
    //   lastNameController.text = user.lastName ?? '';
    //   dobController.text = user.dob != null ? DateFormat('yyyy-MM-dd').format(user.dob!) : '';
    //   _selectedGender = user.gender;
    // }
    _logger.i('PersonalDetailsViewModel initialized');
    notifyListeners();
  }

  void setGender(String? gender) {
    _selectedGender = gender;
    notifyListeners();
  }

  Future<void> selectDateOfBirth(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().subtract(Duration(days: 365 * 18)),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      dobController.text = DateFormat('yyyy-MM-dd').format(picked);
      notifyListeners();
    }
  }

  Future<void> submitPersonalDetails(BuildContext context) async {
    setLoading(true);
    try {
      if (firstNameController.text.isEmpty) {
        throw Exception('First name is required');
      }
      if (lastNameController.text.isEmpty) {
        throw Exception('Last name is required');
      }
      if (dobController.text.isEmpty) {
        throw Exception('Date of birth is required');
      }

      if (_selectedGender == null) {
        throw Exception('Gender selection is required');
      }

      // In production, add more validation
      // final dob = DateFormat('yyyy-MM-dd').parseStrict(dobController.text);
      // if (dob.isAfter(DateTime.now().subtract(Duration(days: 365 * 18)))) {
      //   throw Exception('You must be at least 18 years old');
      // }

      // In production, save to backend
      // await _apiClient.updateUserDetails(
      //   firstName: firstNameController.text,
      //   lastName: lastNameController.text,
      //   dob: dobController.text,
      //   gender: _selectedGender!,
      // );

      _logger.i('Personal details submitted successfully');
      setError(null);
      // Navigate to ID scan
      _router.navigateToScanId();
    } catch (e) {
      _logger.e('Personal details submission error: $e');
      setError('Failed to submit details: $e');
    } finally {
      setLoading(false);
    }
  }

  void setError(String? error) {
    _error = error;
    notifyListeners();
  }

  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    dobController.dispose();
    super.dispose();
  }
}
