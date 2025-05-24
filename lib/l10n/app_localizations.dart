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

  /// No description provided for @passwordHint.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get passwordHint;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password?'**
  String get forgotPassword;

  /// No description provided for @loginFailed.
  ///
  /// In en, this message translates to:
  /// **'Login failed. Please check your credentials.'**
  String get loginFailed;

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

  /// No description provided for @amountHint.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get amountHint;

  /// No description provided for @confirmPayment.
  ///
  /// In en, this message translates to:
  /// **'Confirm Payment'**
  String get confirmPayment;

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

  /// No description provided for @paymentFailed.
  ///
  /// In en, this message translates to:
  /// **'Payment failed: {errorMessage}'**
  String paymentFailed(String errorMessage);

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
  /// **'Error checking biometrics capability.'**
  String get errorCheckingBiometrics;

  /// No description provided for @errorGettingBiometrics.
  ///
  /// In en, this message translates to:
  /// **'Error getting available biometrics.'**
  String get errorGettingBiometrics;

  /// No description provided for @errorDuringBiometricAuth.
  ///
  /// In en, this message translates to:
  /// **'Error during biometric authentication.'**
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
