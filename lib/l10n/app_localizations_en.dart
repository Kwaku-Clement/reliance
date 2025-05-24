// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Reliance';

  @override
  String get welcomeMessage => 'Welcome to Reliance';

  @override
  String get loginButton => 'Login Securely';

  @override
  String get usernameHint => 'Username';

  @override
  String get passwordHint => 'Password';

  @override
  String get forgotPassword => 'Forgot Password?';

  @override
  String get loginFailed => 'Login failed. Please check your credentials.';

  @override
  String get dashboardTitle => 'Dashboard';

  @override
  String get currentBalance => 'Current Balance';

  @override
  String get updatedJustNow => 'Updated: Just now (Dummy)';

  @override
  String get recentTransactions => 'Recent Transactions';

  @override
  String get noTransactions => 'No transactions found.';

  @override
  String get makePaymentButton => 'Make Payment';

  @override
  String get paymentScreenTitle => 'Make a Secure Payment';

  @override
  String get enterPaymentDetails => 'Enter payment details:';

  @override
  String get recipientHint => 'Recipient Account/ID';

  @override
  String get amountHint => 'Amount';

  @override
  String get confirmPayment => 'Confirm Payment';

  @override
  String get processingPayment => 'Processing payment...';

  @override
  String paymentSuccessful(String transactionId) {
    return 'Payment successful! Transaction ID: $transactionId';
  }

  @override
  String paymentFailed(String errorMessage) {
    return 'Payment failed: $errorMessage';
  }

  @override
  String get biometricFailed => 'Biometric authentication failed or cancelled.';

  @override
  String get biometricNotAvailable => 'Biometric authentication is not available on this device or not set up.';

  @override
  String get securityReminderBackend => 'All payments are processed securely via encrypted channels and validated on the backend.';

  @override
  String get secureStorageTitle => 'App Settings & Tokens';

  @override
  String get authTokensSection => 'Authentication Tokens (Stored Securely)';

  @override
  String get authTokenLabel => 'Auth Token:';

  @override
  String get refreshTokenLabel => 'Refresh Token:';

  @override
  String get enterNewTokenHint => 'Enter new dummy auth token';

  @override
  String get storeTokensButton => 'Store Dummy Tokens';

  @override
  String get clearTokensButton => 'Clear All Tokens';

  @override
  String get securityReminderSensitiveData => 'Sensitive data (passwords, card numbers) are NEVER stored here. Only securely managed tokens.';

  @override
  String get errorTitle => 'Error:';

  @override
  String get retryButton => 'Retry';

  @override
  String get contentHidden => 'Content Hidden for Your Security';

  @override
  String get returnToApp => 'Return to the app to continue.';

  @override
  String get transactionApproved => 'Transaction Approved with Biometrics!';

  @override
  String get transactionAuthFailed => 'Transaction Authentication Failed.';

  @override
  String get errorCheckingBiometrics => 'Error checking biometrics capability.';

  @override
  String get errorGettingBiometrics => 'Error getting available biometrics.';

  @override
  String get errorDuringBiometricAuth => 'Error during biometric authentication.';

  @override
  String get authenticationRequired => 'Authentication required. No token found.';

  @override
  String get sessionExpired => 'Session expired. Please re-login.';

  @override
  String get networkError => 'Network error: Check your internet connection.';

  @override
  String get unexpectedError => 'An unexpected error occurred.';

  @override
  String invalidInput(String message) {
    return 'Invalid input: $message';
  }

  @override
  String operationFailed(int statusCode, String body) {
    return 'Operation failed: $statusCode - $body';
  }

  @override
  String get appTheme => 'App Theme';

  @override
  String get systemTheme => 'System';

  @override
  String get lightTheme => 'Light';

  @override
  String get darkTheme => 'Dark';
}
