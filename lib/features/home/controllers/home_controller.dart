import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:reliance/features/home/models/transaction_model.dart';
import '../../../core/services/api_service.dart';
import '../models/account.dart';

class HomeController extends ChangeNotifier {
  final ApiService _apiService;
  final Logger _logger;

  HomeController(this._apiService, this._logger);

  Account? _account;
  List<Transaction> _transactions = [];
  bool _isLoading = false;
  String? _errorMessage;

  Account? get account => _account;
  List<Transaction> get transactions => _transactions;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchAccountData() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final balanceData = await _apiService.get('account/balance');
      final transactionData = await _apiService.get('transactions/history');

      _account = Account.fromJson(balanceData);
      _transactions = (transactionData['transactions'] as List)
          .map((json) => Transaction.fromJson(json))
          .toList();

      _logger.i('Account data fetched successfully.');
    } catch (e) {
      _errorMessage = e.toString();
      _logger.e('Error fetching account data: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
