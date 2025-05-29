import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_fr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('fr')
  ];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'Reliance'**
  String get appName;

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Reliance'**
  String get appTitle;

  /// No description provided for @welcomeMessage.
  ///
  /// In en, this message translates to:
  /// **'Welcome to Reliance'**
  String get welcomeMessage;

  /// No description provided for @loginButton.
  ///
  /// In en, this message translates to:
  /// **'Login Securely'**
  String get loginButton;

  /// No description provided for @usernameHint.
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get usernameHint;

  /// No description provided for @emailOrPhoneHint.
  ///
  /// In en, this message translates to:
  /// **'Email or Phone Number'**
  String get emailOrPhoneHint;

  /// No description provided for @emailHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your email'**
  String get emailHint;

  /// No description provided for @phoneNumberHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your phone number'**
  String get phoneNumberHint;

  /// No description provided for @passwordHint.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get passwordHint;

  /// No description provided for @confirmPasswordHint.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirmPasswordHint;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password?'**
  String get forgotPassword;

  /// No description provided for @alreadyHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have account?'**
  String get alreadyHaveAccount;

  /// No description provided for @signUp.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signUp;

  /// No description provided for @signIn.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get signIn;

  /// No description provided for @noAccountText.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get noAccountText;

  /// No description provided for @registerLink.
  ///
  /// In en, this message translates to:
  /// **'Register Now'**
  String get registerLink;

  /// No description provided for @registerButton.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get registerButton;

  /// No description provided for @fullNameHint.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get fullNameHint;

  /// No description provided for @loginSuccess.
  ///
  /// In en, this message translates to:
  /// **'Login successful!'**
  String get loginSuccess;

  /// No description provided for @loginFailed.
  ///
  /// In en, this message translates to:
  /// **'Login failed: {message}'**
  String loginFailed(String message);

  /// No description provided for @logoutSuccess.
  ///
  /// In en, this message translates to:
  /// **'Logged out successfully.'**
  String get logoutSuccess;

  /// No description provided for @registrationSuccess.
  ///
  /// In en, this message translates to:
  /// **'Registration successful!'**
  String get registrationSuccess;

  /// No description provided for @registrationFailed.
  ///
  /// In en, this message translates to:
  /// **'Registration failed: {message}'**
  String registrationFailed(String message);

  /// No description provided for @requiredField.
  ///
  /// In en, this message translates to:
  /// **'All fields are required.'**
  String get requiredField;

  /// No description provided for @passwordsDoNotMatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match.'**
  String get passwordsDoNotMatch;

  /// No description provided for @passwordLengthError.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 8 characters.'**
  String get passwordLengthError;

  /// No description provided for @invalidEmail.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email address.'**
  String get invalidEmail;

  /// No description provided for @dashboardTitle.
  ///
  /// In en, this message translates to:
  /// **'Dashboard'**
  String get dashboardTitle;

  /// No description provided for @currentBalance.
  ///
  /// In en, this message translates to:
  /// **'Current Balance'**
  String get currentBalance;

  /// No description provided for @balanceSectionTitle.
  ///
  /// In en, this message translates to:
  /// **'Current Balance'**
  String get balanceSectionTitle;

  /// No description provided for @updatedJustNow.
  ///
  /// In en, this message translates to:
  /// **'Updated: Just now (Dummy)'**
  String get updatedJustNow;

  /// No description provided for @recentTransactions.
  ///
  /// In en, this message translates to:
  /// **'Recent Transactions'**
  String get recentTransactions;

  /// No description provided for @transactionsSectionTitle.
  ///
  /// In en, this message translates to:
  /// **'Recent Transactions'**
  String get transactionsSectionTitle;

  /// No description provided for @noTransactions.
  ///
  /// In en, this message translates to:
  /// **'No transactions found.'**
  String get noTransactions;

  /// No description provided for @makePaymentButton.
  ///
  /// In en, this message translates to:
  /// **'Make Payment'**
  String get makePaymentButton;

  /// No description provided for @paymentScreenTitle.
  ///
  /// In en, this message translates to:
  /// **'Make a Secure Payment'**
  String get paymentScreenTitle;

  /// No description provided for @enterPaymentDetails.
  ///
  /// In en, this message translates to:
  /// **'Enter payment details:'**
  String get enterPaymentDetails;

  /// No description provided for @recipientHint.
  ///
  /// In en, this message translates to:
  /// **'Recipient Account/ID'**
  String get recipientHint;

  /// No description provided for @recipientIdHint.
  ///
  /// In en, this message translates to:
  /// **'Recipient ID'**
  String get recipientIdHint;

  /// No description provided for @amountHint.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get amountHint;

  /// No description provided for @currencyHint.
  ///
  /// In en, this message translates to:
  /// **'Currency'**
  String get currencyHint;

  /// No description provided for @confirmPayment.
  ///
  /// In en, this message translates to:
  /// **'Confirm Payment'**
  String get confirmPayment;

  /// No description provided for @sendPaymentButton.
  ///
  /// In en, this message translates to:
  /// **'Send Payment'**
  String get sendPaymentButton;

  /// No description provided for @processingPayment.
  ///
  /// In en, this message translates to:
  /// **'Processing payment...'**
  String get processingPayment;

  /// No description provided for @paymentSuccessful.
  ///
  /// In en, this message translates to:
  /// **'Payment successful! Transaction ID: {transactionId}'**
  String paymentSuccessful(String transactionId);

  /// No description provided for @paymentSuccess.
  ///
  /// In en, this message translates to:
  /// **'Payment successful!'**
  String get paymentSuccess;

  /// No description provided for @paymentFailed.
  ///
  /// In en, this message translates to:
  /// **'Payment failed: {errorMessage}'**
  String paymentFailed(String errorMessage);

  /// No description provided for @paymentLimitExceeded.
  ///
  /// In en, this message translates to:
  /// **'Payment limit exceeded.'**
  String get paymentLimitExceeded;

  /// No description provided for @biometricFailed.
  ///
  /// In en, this message translates to:
  /// **'Biometric authentication failed or cancelled.'**
  String get biometricFailed;

  /// No description provided for @biometricNotAvailable.
  ///
  /// In en, this message translates to:
  /// **'Biometric authentication is not available on this device or not set up.'**
  String get biometricNotAvailable;

  /// No description provided for @biometricReason.
  ///
  /// In en, this message translates to:
  /// **'Authenticate to access your account'**
  String get biometricReason;

  /// No description provided for @securityReminderBackend.
  ///
  /// In en, this message translates to:
  /// **'All payments are processed securely via encrypted channels and validated on the backend.'**
  String get securityReminderBackend;

  /// No description provided for @secureStorageTitle.
  ///
  /// In en, this message translates to:
  /// **'App Settings & Tokens'**
  String get secureStorageTitle;

  /// No description provided for @authTokensSection.
  ///
  /// In en, this message translates to:
  /// **'Authentication Tokens (Stored Securely)'**
  String get authTokensSection;

  /// No description provided for @authTokenLabel.
  ///
  /// In en, this message translates to:
  /// **'Auth Token:'**
  String get authTokenLabel;

  /// No description provided for @refreshTokenLabel.
  ///
  /// In en, this message translates to:
  /// **'Refresh Token:'**
  String get refreshTokenLabel;

  /// No description provided for @enterNewTokenHint.
  ///
  /// In en, this message translates to:
  /// **'Enter new dummy auth token'**
  String get enterNewTokenHint;

  /// No description provided for @storeTokensButton.
  ///
  /// In en, this message translates to:
  /// **'Store Dummy Tokens'**
  String get storeTokensButton;

  /// No description provided for @clearTokensButton.
  ///
  /// In en, this message translates to:
  /// **'Clear All Tokens'**
  String get clearTokensButton;

  /// No description provided for @securityReminderSensitiveData.
  ///
  /// In en, this message translates to:
  /// **'Sensitive data (passwords, card numbers) are NEVER stored here. Only securely managed tokens.'**
  String get securityReminderSensitiveData;

  /// No description provided for @errorTitle.
  ///
  /// In en, this message translates to:
  /// **'Error:'**
  String get errorTitle;

  /// No description provided for @retryButton.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retryButton;

  /// No description provided for @contentHidden.
  ///
  /// In en, this message translates to:
  /// **'Content Hidden for Your Security'**
  String get contentHidden;

  /// No description provided for @returnToApp.
  ///
  /// In en, this message translates to:
  /// **'Return to the app to continue.'**
  String get returnToApp;

  /// No description provided for @transactionApproved.
  ///
  /// In en, this message translates to:
  /// **'Transaction Approved with Biometrics!'**
  String get transactionApproved;

  /// No description provided for @transactionAuthFailed.
  ///
  /// In en, this message translates to:
  /// **'Transaction Authentication Failed.'**
  String get transactionAuthFailed;

  /// No description provided for @errorCheckingBiometrics.
  ///
  /// In en, this message translates to:
  /// **'Error checking biometrics capability'**
  String get errorCheckingBiometrics;

  /// No description provided for @errorGettingBiometrics.
  ///
  /// In en, this message translates to:
  /// **'Error getting available biometrics'**
  String get errorGettingBiometrics;

  /// No description provided for @errorDuringBiometricAuth.
  ///
  /// In en, this message translates to:
  /// **'Error during biometric authentication'**
  String get errorDuringBiometricAuth;

  /// No description provided for @authenticationRequired.
  ///
  /// In en, this message translates to:
  /// **'Authentication required. No token found.'**
  String get authenticationRequired;

  /// No description provided for @sessionExpired.
  ///
  /// In en, this message translates to:
  /// **'Session expired. Please re-login.'**
  String get sessionExpired;

  /// No description provided for @networkError.
  ///
  /// In en, this message translates to:
  /// **'Network error: Check your internet connection.'**
  String get networkError;

  /// No description provided for @unexpectedError.
  ///
  /// In en, this message translates to:
  /// **'An unexpected error occurred.'**
  String get unexpectedError;

  /// No description provided for @invalidInput.
  ///
  /// In en, this message translates to:
  /// **'Invalid input: {message}'**
  String invalidInput(String message);

  /// No description provided for @operationFailed.
  ///
  /// In en, this message translates to:
  /// **'Operation failed: {statusCode} - {body}'**
  String operationFailed(int statusCode, String body);

  /// No description provided for @changePasswordTitle.
  ///
  /// In en, this message translates to:
  /// **'Change Password'**
  String get changePasswordTitle;

  /// No description provided for @oldPasswordHint.
  ///
  /// In en, this message translates to:
  /// **'Old Password'**
  String get oldPasswordHint;

  /// No description provided for @newPasswordHint.
  ///
  /// In en, this message translates to:
  /// **'New Password'**
  String get newPasswordHint;

  /// No description provided for @confirmNewPasswordHint.
  ///
  /// In en, this message translates to:
  /// **'Confirm New Password'**
  String get confirmNewPasswordHint;

  /// No description provided for @changePasswordButton.
  ///
  /// In en, this message translates to:
  /// **'Change Password'**
  String get changePasswordButton;

  /// No description provided for @passwordChangeSuccess.
  ///
  /// In en, this message translates to:
  /// **'Password changed successfully!'**
  String get passwordChangeSuccess;

  /// No description provided for @passwordChangeFailed.
  ///
  /// In en, this message translates to:
  /// **'Password change failed: {message}'**
  String passwordChangeFailed(String message);

  /// No description provided for @forgotPasswordTitle.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password'**
  String get forgotPasswordTitle;

  /// No description provided for @sendResetLinkButton.
  ///
  /// In en, this message translates to:
  /// **'Send Reset Link'**
  String get sendResetLinkButton;

  /// No description provided for @resetLinkSent.
  ///
  /// In en, this message translates to:
  /// **'Password reset link sent to your email.'**
  String get resetLinkSent;

  /// No description provided for @resetPasswordTitle.
  ///
  /// In en, this message translates to:
  /// **'Reset Password'**
  String get resetPasswordTitle;

  /// No description provided for @resetPasswordButton.
  ///
  /// In en, this message translates to:
  /// **'Reset Password'**
  String get resetPasswordButton;

  /// No description provided for @passwordResetSuccess.
  ///
  /// In en, this message translates to:
  /// **'Password reset successfully!'**
  String get passwordResetSuccess;

  /// No description provided for @passwordResetFailed.
  ///
  /// In en, this message translates to:
  /// **'Password reset failed: {message}'**
  String passwordResetFailed(String message);

  /// No description provided for @setPasscodeTitle.
  ///
  /// In en, this message translates to:
  /// **'Set Passcode'**
  String get setPasscodeTitle;

  /// No description provided for @passcodeHint.
  ///
  /// In en, this message translates to:
  /// **'Enter 4-digit Passcode'**
  String get passcodeHint;

  /// No description provided for @confirmPasscodeHint.
  ///
  /// In en, this message translates to:
  /// **'Confirm Passcode'**
  String get confirmPasscodeHint;

  /// No description provided for @setPasscodeButton.
  ///
  /// In en, this message translates to:
  /// **'Set Passcode'**
  String get setPasscodeButton;

  /// No description provided for @passcodeSetSuccess.
  ///
  /// In en, this message translates to:
  /// **'Passcode set successfully!'**
  String get passcodeSetSuccess;

  /// No description provided for @passcodeSetFailed.
  ///
  /// In en, this message translates to:
  /// **'Passcode set failed: {message}'**
  String passcodeSetFailed(String message);

  /// No description provided for @passcodesDoNotMatch.
  ///
  /// In en, this message translates to:
  /// **'Passcodes do not match.'**
  String get passcodesDoNotMatch;

  /// No description provided for @passcodeLengthError.
  ///
  /// In en, this message translates to:
  /// **'Passcode must be 4 digits.'**
  String get passcodeLengthError;

  /// No description provided for @profileSetupTitle.
  ///
  /// In en, this message translates to:
  /// **'Complete Your Profile'**
  String get profileSetupTitle;

  /// No description provided for @scanIdCardButton.
  ///
  /// In en, this message translates to:
  /// **'Scan ID Card'**
  String get scanIdCardButton;

  /// No description provided for @scanFaceButton.
  ///
  /// In en, this message translates to:
  /// **'Scan Face'**
  String get scanFaceButton;

  /// No description provided for @completeProfileButton.
  ///
  /// In en, this message translates to:
  /// **'Complete Profile'**
  String get completeProfileButton;

  /// No description provided for @idScanSuccess.
  ///
  /// In en, this message translates to:
  /// **'ID Card scanned successfully!'**
  String get idScanSuccess;

  /// No description provided for @idScanFailed.
  ///
  /// In en, this message translates to:
  /// **'ID Card scan failed.'**
  String get idScanFailed;

  /// No description provided for @faceScanSuccess.
  ///
  /// In en, this message translates to:
  /// **'Face scanned successfully!'**
  String get faceScanSuccess;

  /// No description provided for @faceScanFailed.
  ///
  /// In en, this message translates to:
  /// **'Face scan failed.'**
  String get faceScanFailed;

  /// No description provided for @appTheme.
  ///
  /// In en, this message translates to:
  /// **'App Theme'**
  String get appTheme;

  /// No description provided for @systemTheme.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get systemTheme;

  /// No description provided for @lightTheme.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get lightTheme;

  /// No description provided for @darkTheme.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get darkTheme;

  /// No description provided for @otpVerificationTitle.
  ///
  /// In en, this message translates to:
  /// **'OTP Verification'**
  String get otpVerificationTitle;

  /// No description provided for @otpSentTo.
  ///
  /// In en, this message translates to:
  /// **'OTP sent to {destination}'**
  String otpSentTo(Object destination);

  /// No description provided for @enterOtpHint.
  ///
  /// In en, this message translates to:
  /// **'Enter 6-digit OTP'**
  String get enterOtpHint;

  /// No description provided for @verifyOtpButton.
  ///
  /// In en, this message translates to:
  /// **'Verify OTP'**
  String get verifyOtpButton;

  /// No description provided for @resendOtpButton.
  ///
  /// In en, this message translates to:
  /// **'Resend OTP'**
  String get resendOtpButton;

  /// No description provided for @confirmYourPhone.
  ///
  /// In en, this message translates to:
  /// **'Confirm your phone'**
  String get confirmYourPhone;

  /// No description provided for @verifyYourNumber.
  ///
  /// In en, this message translates to:
  /// **'Verify Your Number'**
  String get verifyYourNumber;

  /// No description provided for @invalidOtp.
  ///
  /// In en, this message translates to:
  /// **'Invalid OTP. Please enter a 6-digit code.'**
  String get invalidOtp;

  /// No description provided for @otpVerificationSuccess.
  ///
  /// In en, this message translates to:
  /// **'OTP verified successfully!'**
  String get otpVerificationSuccess;

  /// No description provided for @otpVerificationFailed.
  ///
  /// In en, this message translates to:
  /// **'OTP verification failed: {error}'**
  String otpVerificationFailed(Object error);

  /// No description provided for @otpResent.
  ///
  /// In en, this message translates to:
  /// **'OTP resent successfully!'**
  String get otpResent;

  /// No description provided for @otpResendFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to resend OTP: {error}'**
  String otpResendFailed(Object error);

  /// No description provided for @confirmButtonText.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirmButtonText;

  /// No description provided for @confirmPasscodeLabel.
  ///
  /// In en, this message translates to:
  /// **'Confirm Passcode'**
  String get confirmPasscodeLabel;

  /// No description provided for @passcodeLabel.
  ///
  /// In en, this message translates to:
  /// **'Passcode'**
  String get passcodeLabel;

  /// No description provided for @setPasscodeDescription.
  ///
  /// In en, this message translates to:
  /// **'Please set a 4-digit passcode for your account.'**
  String get setPasscodeDescription;

  /// No description provided for @scanIdTitle.
  ///
  /// In en, this message translates to:
  /// **'Scan Your ID'**
  String get scanIdTitle;

  /// No description provided for @scanIdDescription.
  ///
  /// In en, this message translates to:
  /// **'Please scan the front and back of your ID.'**
  String get scanIdDescription;

  /// No description provided for @scanIdFrontButton.
  ///
  /// In en, this message translates to:
  /// **'Scan Front'**
  String get scanIdFrontButton;

  /// No description provided for @scanIdBackButton.
  ///
  /// In en, this message translates to:
  /// **'Scan Back'**
  String get scanIdBackButton;

  /// No description provided for @nextButtonText.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get nextButtonText;

  /// No description provided for @completeSetupButton.
  ///
  /// In en, this message translates to:
  /// **'Complete Setup'**
  String get completeSetupButton;

  /// No description provided for @takeSelfieButton.
  ///
  /// In en, this message translates to:
  /// **'Take Selfie'**
  String get takeSelfieButton;

  /// No description provided for @scanFaceDescription.
  ///
  /// In en, this message translates to:
  /// **'Position your face in the frame.'**
  String get scanFaceDescription;

  /// No description provided for @scanFaceTitle.
  ///
  /// In en, this message translates to:
  /// **'Scan Your Face'**
  String get scanFaceTitle;

  /// No description provided for @genderLabel.
  ///
  /// In en, this message translates to:
  /// **'Gender'**
  String get genderLabel;

  /// No description provided for @dobLabel.
  ///
  /// In en, this message translates to:
  /// **'Date of Birth'**
  String get dobLabel;

  /// No description provided for @lastNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Last Name'**
  String get lastNameLabel;

  /// No description provided for @firstNameLabel.
  ///
  /// In en, this message translates to:
  /// **'First Name'**
  String get firstNameLabel;

  /// No description provided for @personalDetailsDescription.
  ///
  /// In en, this message translates to:
  /// **'Please provide your personal details.'**
  String get personalDetailsDescription;

  /// No description provided for @personalDetailsTitle.
  ///
  /// In en, this message translates to:
  /// **'Personal Details'**
  String get personalDetailsTitle;

  /// No description provided for @idScanUploadError.
  ///
  /// In en, this message translates to:
  /// **'Failed to upload ID scan.'**
  String get idScanUploadError;

  /// No description provided for @idScanRequired.
  ///
  /// In en, this message translates to:
  /// **'ID scan is required.'**
  String get idScanRequired;

  /// No description provided for @imagePickError.
  ///
  /// In en, this message translates to:
  /// **'Failed to pick image.'**
  String get imagePickError;

  /// No description provided for @faceScanUploadError.
  ///
  /// In en, this message translates to:
  /// **'Failed to upload face scan.'**
  String get faceScanUploadError;

  /// No description provided for @selfieRequired.
  ///
  /// In en, this message translates to:
  /// **'Selfie is required.'**
  String get selfieRequired;

  /// No description provided for @selfieCaptureError.
  ///
  /// In en, this message translates to:
  /// **'Failed to capture selfie.'**
  String get selfieCaptureError;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'fr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'fr': return AppLocalizationsFr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
