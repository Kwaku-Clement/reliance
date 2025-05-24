// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'Reliance';

  @override
  String get welcomeMessage => 'Bienvenue chez Reliance';

  @override
  String get loginButton => 'Se connecter en toute sécurité';

  @override
  String get usernameHint => 'Nom d\'utilisateur';

  @override
  String get passwordHint => 'Mot de passe';

  @override
  String get forgotPassword => 'Mot de passe oublié ?';

  @override
  String get loginFailed => 'Échec de la connexion. Veuillez vérifier vos identifiants.';

  @override
  String get dashboardTitle => 'Tableau de bord';

  @override
  String get currentBalance => 'Solde actuel';

  @override
  String get updatedJustNow => 'Mis à jour : À l\'instant (Fictif)';

  @override
  String get recentTransactions => 'Transactions récentes';

  @override
  String get noTransactions => 'Aucune transaction trouvée.';

  @override
  String get makePaymentButton => 'Effectuer un paiement';

  @override
  String get paymentScreenTitle => 'Effectuer un paiement sécurisé';

  @override
  String get enterPaymentDetails => 'Saisissez les détails du paiement :';

  @override
  String get recipientHint => 'Compte/ID du bénéficiaire';

  @override
  String get amountHint => 'Montant';

  @override
  String get confirmPayment => 'Confirmer le paiement';

  @override
  String get processingPayment => 'Traitement du paiement...';

  @override
  String paymentSuccessful(String transactionId) {
    return 'Paiement réussi ! ID de transaction : $transactionId';
  }

  @override
  String paymentFailed(String errorMessage) {
    return 'Échec du paiement : $errorMessage';
  }

  @override
  String get biometricFailed => 'L\'authentification biométrique a échoué ou a été annulée.';

  @override
  String get biometricNotAvailable => 'L\'authentification biométrique n\'est pas disponible sur cet appareil ou n\'est pas configurée.';

  @override
  String get securityReminderBackend => 'Tous les paiements sont traités de manière sécurisée via des canaux cryptés et validés sur le backend.';

  @override
  String get secureStorageTitle => 'Paramètres de l\'application et jetons';

  @override
  String get authTokensSection => 'Jetons d\'authentification (stockés en toute sécurité)';

  @override
  String get authTokenLabel => 'Jeton d\'authentification :';

  @override
  String get refreshTokenLabel => 'Jeton d\'actualisation :';

  @override
  String get enterNewTokenHint => 'Saisir un nouveau jeton d\'authentification fictif';

  @override
  String get storeTokensButton => 'Stocker les jetons fictifs';

  @override
  String get clearTokensButton => 'Effacer tous les jetons';

  @override
  String get securityReminderSensitiveData => 'Les données sensibles (mots de passe, numéros de carte) ne sont JAMAIS stockées ici. Seuls les jetons gérés de manière sécurisée le sont.';

  @override
  String get errorTitle => 'Erreur :';

  @override
  String get retryButton => 'Réessayer';

  @override
  String get contentHidden => 'Contenu masqué pour votre sécurité';

  @override
  String get returnToApp => 'Retourner à l\'application pour continuer.';

  @override
  String get transactionApproved => 'Transaction approuvée par biométrie !';

  @override
  String get transactionAuthFailed => 'Échec de l\'authentification de la transaction.';

  @override
  String get errorCheckingBiometrics => 'Erreur lors de la vérification des capacités biométriques.';

  @override
  String get errorGettingBiometrics => 'Erreur lors de l\'obtention des biometrics disponibles.';

  @override
  String get errorDuringBiometricAuth => 'Erreur lors de l\'authentification biométrique.';

  @override
  String get authenticationRequired => 'Authentification requise. Aucun jeton trouvé.';

  @override
  String get sessionExpired => 'Session expirée. Veuillez vous reconnecter.';

  @override
  String get networkError => 'Erreur réseau : Vérifiez votre connexion internet.';

  @override
  String get unexpectedError => 'Une erreur inattendue est survenue.';

  @override
  String invalidInput(String message) {
    return 'Saisie invalide : $message';
  }

  @override
  String operationFailed(int statusCode, String body) {
    return 'Opération échouée : $statusCode - $body';
  }

  @override
  String get appTheme => 'Thème de l\'application';

  @override
  String get systemTheme => 'Système';

  @override
  String get lightTheme => 'Clair';

  @override
  String get darkTheme => 'Foncé';
}
