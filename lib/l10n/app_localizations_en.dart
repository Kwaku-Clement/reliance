// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Reliance';

  @override
  String get appTitle => 'Reliance';

  @override
  String get welcomeMessage => 'Welcome to Reliance';

  @override
  String get loginButton => 'Login Securely';

  @override
  String get usernameHint => 'Username';

  @override
  String get emailOrPhoneHint => 'Email or Phone Number';

  @override
  String get emailHint => 'Enter your email';

  @override
  String get phoneNumberHint => 'Enter your phone number';

  @override
  String get passwordHint => 'Password';

  @override
  String get confirmPasswordHint => 'Confirm Password';

  @override
  String get forgotPassword => 'Forgot Password?';

  @override
  String get alreadyHaveAccount => 'Already have account?';

  @override
  String get signUp => 'Sign Up';

  @override
  String get signIn => 'Sign In';

  @override
  String get noAccountText => 'Don\'t have an account?';

  @override
  String get registerLink => 'Register Now';

  @override
  String get registerButton => 'Register';

  @override
  String get fullNameHint => 'Full Name';

  @override
  String get loginSuccess => 'Login successful!';

  @override
  String loginFailed(String message) {
    return 'Login failed: $message';
  }

  @override
  String get logoutSuccess => 'Logged out successfully.';

  @override
  String get registrationSuccess => 'Registration successful!';

  @override
  String registrationFailed(String message) {
    return 'Registration failed: $message';
  }

  @override
  String get requiredField => 'All fields are required.';

  @override
  String get passwordsDoNotMatch => 'Passwords do not match.';

  @override
  String get passwordLengthError => 'Password must be at least 8 characters.';

  @override
  String get invalidEmail => 'Please enter a valid email address.';

  @override
  String get dashboardTitle => 'Dashboard';

  @override
  String get currentBalance => 'Current Balance';

  @override
  String get balanceSectionTitle => 'Current Balance';

  @override
  String get updatedJustNow => 'Updated: Just now (Dummy)';

  @override
  String get recentTransactions => 'Recent Transactions';

  @override
  String get transactionsSectionTitle => 'Recent Transactions';

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
  String get recipientIdHint => 'Recipient ID';

  @override
  String get amountHint => 'Amount';

  @override
  String get currencyHint => 'Currency';

  @override
  String get confirmPayment => 'Confirm Payment';

  @override
  String get sendPaymentButton => 'Send Payment';

  @override
  String get processingPayment => 'Processing payment...';

  @override
  String paymentSuccessful(String transactionId) {
    return 'Payment successful! Transaction ID: $transactionId';
  }

  @override
  String get paymentSuccess => 'Payment successful!';

  @override
  String paymentFailed(String errorMessage) {
    return 'Payment failed: $errorMessage';
  }

  @override
  String get paymentLimitExceeded => 'Payment limit exceeded.';

  @override
  String get biometricFailed => 'Biometric authentication failed or cancelled.';

  @override
  String get biometricNotAvailable => 'Biometric authentication is not available on this device or not set up.';

  @override
  String get biometricReason => 'Authenticate to access your account';

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
  String get errorCheckingBiometrics => 'Error checking biometrics capability';

  @override
  String get errorGettingBiometrics => 'Error getting available biometrics';

  @override
  String get errorDuringBiometricAuth => 'Error during biometric authentication';

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
  String get changePasswordTitle => 'Change Password';

  @override
  String get oldPasswordHint => 'Old Password';

  @override
  String get newPasswordHint => 'New Password';

  @override
  String get confirmNewPasswordHint => 'Confirm New Password';

  @override
  String get changePasswordButton => 'Change Password';

  @override
  String get passwordChangeSuccess => 'Password changed successfully!';

  @override
  String passwordChangeFailed(String message) {
    return 'Password change failed: $message';
  }

  @override
  String get forgotPasswordTitle => 'Forgot Password';

  @override
  String get sendResetLinkButton => 'Send Reset Link';

  @override
  String get resetLinkSent => 'Password reset link sent to your email.';

  @override
  String get resetPasswordTitle => 'Reset Password';

  @override
  String get resetPasswordButton => 'Reset Password';

  @override
  String get passwordResetSuccess => 'Password reset successfully!';

  @override
  String passwordResetFailed(String message) {
    return 'Password reset failed: $message';
  }

  @override
  String get setPasscodeTitle => 'Set Passcode';

  @override
  String get passcodeHint => 'Enter 4-digit Passcode';

  @override
  String get confirmPasscodeHint => 'Confirm Passcode';

  @override
  String get setPasscodeButton => 'Set Passcode';

  @override
  String get passcodeSetSuccess => 'Passcode set successfully!';

  @override
  String passcodeSetFailed(String message) {
    return 'Passcode set failed: $message';
  }

  @override
  String get passcodesDoNotMatch => 'Passcodes do not match.';

  @override
  String get passcodeLengthError => 'Passcode must be 4 digits.';

  @override
  String get profileSetupTitle => 'Complete Your Profile';

  @override
  String get scanIdCardButton => 'Scan ID Card';

  @override
  String get scanFaceButton => 'Scan Face';

  @override
  String get completeProfileButton => 'Complete Profile';

  @override
  String get idScanSuccess => 'ID Card scanned successfully!';

  @override
  String get idScanFailed => 'ID Card scan failed.';

  @override
  String get faceScanSuccess => 'Face scanned successfully!';

  @override
  String get faceScanFailed => 'Face scan failed.';

  @override
  String get appTheme => 'App Theme';

  @override
  String get systemTheme => 'System';

  @override
  String get lightTheme => 'Light';

  @override
  String get darkTheme => 'Dark';

  @override
  String get otpVerificationTitle => 'OTP Verification';

  @override
  String otpSentTo(Object destination) {
    return 'OTP sent to $destination';
  }

  @override
  String get enterOtpHint => 'Enter 6-digit OTP';

  @override
  String get verifyOtpButton => 'Verify OTP';

  @override
  String get resendOtpButton => 'Resend OTP';

  @override
  String get confirmYourPhone => 'Confirm your phone';

  @override
  String get verifyYourNumber => 'Verify Your Number';

  @override
  String get invalidOtp => 'Invalid OTP. Please enter a 6-digit code.';

  @override
  String get otpVerificationSuccess => 'OTP verified successfully!';

  @override
  String otpVerificationFailed(Object error) {
    return 'OTP verification failed: $error';
  }

  @override
  String get otpResent => 'OTP resent successfully!';

  @override
  String otpResendFailed(Object error) {
    return 'Failed to resend OTP: $error';
  }

  @override
  String get confirmButtonText => 'Confirm';

  @override
  String get confirmPasscodeLabel => 'Confirm Passcode';

  @override
  String get passcodeLabel => 'Passcode';

  @override
  String get setPasscodeDescription => 'Please set a 4-digit passcode for your account.';

  @override
  String get scanIdTitle => 'Scan Your ID';

  @override
  String get scanIdDescription => 'Please scan the front and back of your ID.';

  @override
  String get scanIdFrontButton => 'Scan Front';

  @override
  String get scanIdBackButton => 'Scan Back';

  @override
  String get nextButtonText => 'Next';

  @override
  String get completeSetupButton => 'Complete Setup';

  @override
  String get takeSelfieButton => 'Take Selfie';

  @override
  String get scanFaceDescription => 'Position your face in the frame.';

  @override
  String get scanFaceTitle => 'Scan Your Face';

  @override
  String get genderLabel => 'Gender';

  @override
  String get dobLabel => 'Date of Birth';

  @override
  String get lastNameLabel => 'Last Name';

  @override
  String get firstNameLabel => 'First Name';

  @override
  String get personalDetailsDescription => 'Please provide your personal details.';

  @override
  String get personalDetailsTitle => 'Personal Details';

  @override
  String get idScanUploadError => 'Failed to upload ID scan.';

  @override
  String get idScanRequired => 'ID scan is required.';

  @override
  String get imagePickError => 'Failed to pick image.';

  @override
  String get faceScanUploadError => 'Failed to upload face scan.';

  @override
  String get selfieRequired => 'Selfie is required.';

  @override
  String get selfieCaptureError => 'Failed to capture selfie.';
}
