import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:reliance/core/services/api_service.dart';
import 'package:reliance/features/auth/models/user_model.dart';
import 'package:reliance/features/home/models/account.dart';
import 'package:reliance/features/home/models/transaction_model.dart';

class HomeController extends ChangeNotifier {
  final ApiService _apiService;
  final Logger _logger;

  HomeController(this._apiService, this._logger);

  Account? _account;
  List<Transaction> _transactions =
      []; // Changed to non-nullable, initialized as empty
  User? _currentUser;
  bool _isLoading = false;
  String? _errorMessage;
  bool _isDisposed = false;

  Account? get account => _account;
  List<Transaction> get transactions => _transactions; // Non-nullable
  User? get user => _currentUser;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  void setUser(User? user) {
    _currentUser = user;
    _safeNotifyListeners();
  }

  void _updateLoading(bool value) {
    if (_isLoading != value) {
      _isLoading = value;
      _safeNotifyListeners();
    }
  }

  void _setErrorMessage(String message) {
    if (_errorMessage != message) {
      _errorMessage = message;
      _logger.w('Error: $message');
      _safeNotifyListeners();
    }
  }

  void _clearError() {
    if (_errorMessage != null) {
      _errorMessage = null;
      _safeNotifyListeners();
    }
  }

  void _safeNotifyListeners() {
    if (!_isDisposed) {
      notifyListeners();
    }
  }

  Future<void> fetchAccountData() async {
    if (_isDisposed || _isLoading) return;

    _updateLoading(true);
    _clearError();

    try {
      final balanceData = await _apiService.get('account/balance');
      final transactionData = await _apiService.get('transactions/history');

      _account = Account.fromJson(balanceData);
      _transactions =
          (transactionData['transactions'] as List<dynamic>?)
              ?.map((json) => Transaction.fromJson(json))
              .toList() ??
          []; // Ensure non-null list

      _logger.i('Successfully fetched account data.');
    } catch (e) {
      _setErrorMessage('Failed to fetch data: ${e.toString()}');
      _logger.e('Error fetching account data: $e');
      _transactions = []; // Reset to empty list on error
    } finally {
      _updateLoading(false);
    }
  }

  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }
}
