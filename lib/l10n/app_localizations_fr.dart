// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appName => 'Reliance';

  @override
  String get appTitle => 'Reliance';

  @override
  String get welcomeMessage => 'Bienvenue sur Reliance';

  @override
  String get loginButton => 'Connexion sécurisée';

  @override
  String get usernameHint => 'Nom d\'utilisateur';

  @override
  String get emailOrPhoneHint => 'Email ou numéro de téléphone';

  @override
  String get emailHint => 'Entrez votre email';

  @override
  String get phoneNumberHint => 'Entrez votre numéro de téléphone';

  @override
  String get passwordHint => 'Mot de passe';

  @override
  String get confirmPasswordHint => 'Confirmer le mot de passe';

  @override
  String get forgotPassword => 'Mot de passe oublié ?';

  @override
  String get alreadyHaveAccount => 'Vous avez déjà un compte ?';

  @override
  String get signUp => 'S\'inscrire';

  @override
  String get signIn => 'Se connecter';

  @override
  String get noAccountText => 'Vous n\'avez pas de compte ?';

  @override
  String get registerLink => 'Inscrivez-vous maintenant';

  @override
  String get registerButton => 'S\'inscrire';

  @override
  String get fullNameHint => 'Nom complet';

  @override
  String get loginSuccess => 'Connexion réussie !';

  @override
  String loginFailed(String message) {
    return 'Échec de la connexion : $message';
  }

  @override
  String get logoutSuccess => 'Déconnexion réussie.';

  @override
  String get registrationSuccess => 'Inscription réussie !';

  @override
  String registrationFailed(String message) {
    return 'Échec de l\'inscription : $message';
  }

  @override
  String get requiredField => 'Tous les champs sont requis.';

  @override
  String get passwordsDoNotMatch => 'Les mots de passe ne correspondent pas.';

  @override
  String get passwordLengthError => 'Le mot de passe doit comporter au moins 8 caractères.';

  @override
  String get invalidEmail => 'Veuillez entrer une adresse email valide.';

  @override
  String get dashboardTitle => 'Tableau de bord';

  @override
  String get currentBalance => 'Solde actuel';

  @override
  String get balanceSectionTitle => 'Solde actuel';

  @override
  String get updatedJustNow => 'Mis à jour : À l\'instant (fictif)';

  @override
  String get recentTransactions => 'Transactions récentes';

  @override
  String get transactionsSectionTitle => 'Transactions récentes';

  @override
  String get noTransactions => 'Aucune transaction trouvée.';

  @override
  String get makePaymentButton => 'Effectuer un paiement';

  @override
  String get paymentScreenTitle => 'Effectuer un paiement sécurisé';

  @override
  String get enterPaymentDetails => 'Entrez les détails du paiement :';

  @override
  String get recipientHint => 'Compte/ID du destinataire';

  @override
  String get recipientIdHint => 'ID du destinataire';

  @override
  String get amountHint => 'Montant';

  @override
  String get currencyHint => 'Devise';

  @override
  String get confirmPayment => 'Confirmer le paiement';

  @override
  String get sendPaymentButton => 'Envoyer le paiement';

  @override
  String get processingPayment => 'Traitement du paiement...';

  @override
  String paymentSuccessful(String transactionId) {
    return 'Paiement réussi ! ID de transaction : $transactionId';
  }

  @override
  String get paymentSuccess => 'Paiement réussi !';

  @override
  String paymentFailed(String errorMessage) {
    return 'Échec du paiement : $errorMessage';
  }

  @override
  String get paymentLimitExceeded => 'Limite de paiement dépassée.';

  @override
  String get biometricFailed => 'L\'authentification biométrique a échoué ou a été annulée.';

  @override
  String get biometricNotAvailable => 'L\'authentification biométrique n\'est pas disponible sur cet appareil ou n\'est pas configurée.';

  @override
  String get biometricReason => 'Authentifiez-vous pour accéder à votre compte';

  @override
  String get securityReminderBackend => 'Tous les paiements sont traités de manière sécurisée via des canaux cryptés et validés en backend.';

  @override
  String get secureStorageTitle => 'Paramètres de l\'application et jetons';

  @override
  String get authTokensSection => 'Jetons d\'authentification (stockés de manière sécurisée)';

  @override
  String get authTokenLabel => 'Jeton d\'authentification :';

  @override
  String get refreshTokenLabel => 'Jeton de rafraîchissement :';

  @override
  String get enterNewTokenHint => 'Entrez un nouveau jeton d\'authentification fictif';

  @override
  String get storeTokensButton => 'Stocker les jetons fictifs';

  @override
  String get clearTokensButton => 'Supprimer tous les jetons';

  @override
  String get securityReminderSensitiveData => 'Les données sensibles (mots de passe, numéros de carte) ne sont JAMAIS stockées ici. Seuls les jetons gérés de manière sécurisée le sont.';

  @override
  String get errorTitle => 'Erreur :';

  @override
  String get retryButton => 'Réessayer';

  @override
  String get contentHidden => 'Contenu masqué pour votre sécurité';

  @override
  String get returnToApp => 'Retournez à l\'application pour continuer.';

  @override
  String get transactionApproved => 'Transaction approuvée avec la biométrie !';

  @override
  String get transactionAuthFailed => 'Échec de l\'authentification de la transaction.';

  @override
  String get errorCheckingBiometrics => 'Erreur lors de la vérification de la capacité biométrique';

  @override
  String get errorGettingBiometrics => 'Erreur lors de l\'obtention des biométries disponibles';

  @override
  String get errorDuringBiometricAuth => 'Erreur lors de l\'authentification biométrique';

  @override
  String get authenticationRequired => 'Authentification requise. Aucun jeton trouvé.';

  @override
  String get sessionExpired => 'Session expirée. Veuillez vous reconnecter.';

  @override
  String get networkError => 'Erreur réseau : Vérifiez votre connexion Internet.';

  @override
  String get unexpectedError => 'Une erreur inattendue s\'est produite.';

  @override
  String invalidInput(String message) {
    return 'Entrée invalide : $message';
  }

  @override
  String operationFailed(int statusCode, String body) {
    return 'Opération échouée : $statusCode - $body';
  }

  @override
  String get changePasswordTitle => 'Changer le mot de passe';

  @override
  String get oldPasswordHint => 'Ancien mot de passe';

  @override
  String get newPasswordHint => 'Nouveau mot de passe';

  @override
  String get confirmNewPasswordHint => 'Confirmer le nouveau mot de passe';

  @override
  String get changePasswordButton => 'Changer le mot de passe';

  @override
  String get passwordChangeSuccess => 'Mot de passe changé avec succès !';

  @override
  String passwordChangeFailed(String message) {
    return 'Échec du changement de mot de passe : $message';
  }

  @override
  String get forgotPasswordTitle => 'Mot de passe oublié';

  @override
  String get sendResetLinkButton => 'Envoyer le lien de réinitialisation';

  @override
  String get resetLinkSent => 'Lien de réinitialisation du mot de passe envoyé à votre email.';

  @override
  String get resetPasswordTitle => 'Réinitialiser le mot de passe';

  @override
  String get resetPasswordButton => 'Réinitialiser le mot de passe';

  @override
  String get passwordResetSuccess => 'Mot de passe réinitialisé avec succès !';

  @override
  String passwordResetFailed(String message) {
    return 'Échec de la réinitialisation du mot de passe : $message';
  }

  @override
  String get setPasscodeTitle => 'Définir le code d\'accès';

  @override
  String get passcodeHint => 'Entrez un code d\'accès à 4 chiffres';

  @override
  String get confirmPasscodeHint => 'Confirmer le code d\'accès';

  @override
  String get setPasscodeButton => 'Définir le code d\'accès';

  @override
  String get passcodeSetSuccess => 'Code d\'accès défini avec succès !';

  @override
  String passcodeSetFailed(String message) {
    return 'Échec de la définition du code d\'accès : $message';
  }

  @override
  String get passcodesDoNotMatch => 'Les codes d\'accès ne correspondent pas.';

  @override
  String get passcodeLengthError => 'Le code d\'accès doit comporter 4 chiffres.';

  @override
  String get profileSetupTitle => 'Compléter votre profil';

  @override
  String get scanIdCardButton => 'Scanner la carte d\'identité';

  @override
  String get scanFaceButton => 'Scanner le visage';

  @override
  String get completeProfileButton => 'Compléter le profil';

  @override
  String get idScanSuccess => 'Carte d\'identité scannée avec succès !';

  @override
  String get idScanFailed => 'Échec du scan de la carte d\'identité.';

  @override
  String get faceScanSuccess => 'Visage scanné avec succès !';

  @override
  String get faceScanFailed => 'Échec du scan du visage.';

  @override
  String get appTheme => 'Thème de l\'application';

  @override
  String get systemTheme => 'Système';

  @override
  String get lightTheme => 'Clair';

  @override
  String get darkTheme => 'Sombre';

  @override
  String get otpVerificationTitle => 'Vérification OTP';

  @override
  String otpSentTo(Object destination) {
    return 'OTP envoyé à $destination';
  }

  @override
  String get enterOtpHint => 'Entrez le code OTP à 6 chiffres';

  @override
  String get verifyOtpButton => 'Vérifier l\'OTP';

  @override
  String get resendOtpButton => 'Renvoyer l\'OTP';

  @override
  String get confirmYourPhone => 'Confirmez votre téléphone';

  @override
  String get verifyYourNumber => 'Vérifiez votre numéro';

  @override
  String get invalidOtp => 'OTP invalide. Veuillez entrer un code à 6 chiffres.';

  @override
  String get otpVerificationSuccess => 'OTP vérifié avec succès !';

  @override
  String otpVerificationFailed(Object error) {
    return 'Échec de la vérification OTP : $error';
  }

  @override
  String get otpResent => 'OTP renvoyé avec succès !';

  @override
  String otpResendFailed(Object error) {
    return 'Échec du renvoi de l\'OTP : $error';
  }

  @override
  String get confirmButtonText => 'Confirmer';

  @override
  String get confirmPasscodeLabel => 'Confirmer le code secret';

  @override
  String get passcodeLabel => 'Code secret';

  @override
  String get setPasscodeDescription => 'Veuillez définir un code secret à 4 chiffres pour votre compte.';

  @override
  String get scanIdTitle => 'Scannez votre pièce d\'identité';

  @override
  String get scanIdDescription => 'Veuillez scanner le recto et le verso de votre pièce d\'identité.';

  @override
  String get scanIdFrontButton => 'Scanner le recto';

  @override
  String get scanIdBackButton => 'Scanner le verso';

  @override
  String get nextButtonText => 'Suivant';

  @override
  String get completeSetupButton => 'Terminer la configuration';

  @override
  String get takeSelfieButton => 'Prendre un selfie';

  @override
  String get scanFaceDescription => 'Positionnez votre visage dans le cadre.';

  @override
  String get scanFaceTitle => 'Scannez votre visage';

  @override
  String get genderLabel => 'Sexe';

  @override
  String get dobLabel => 'Date de naissance';

  @override
  String get lastNameLabel => 'Nom de famille';

  @override
  String get firstNameLabel => 'Prénom';

  @override
  String get personalDetailsDescription => 'Veuillez fournir vos informations personnelles.';

  @override
  String get personalDetailsTitle => 'Détails personnels';

  @override
  String get idScanUploadError => 'Échec du téléchargement du scan d\'identité.';

  @override
  String get idScanRequired => 'Le scan d\'identité est requis.';

  @override
  String get imagePickError => 'Échec de la sélection de l\'image.';

  @override
  String get faceScanUploadError => 'Échec du téléchargement du scan facial.';

  @override
  String get selfieRequired => 'Un selfie est requis.';

  @override
  String get selfieCaptureError => 'Échec de la capture du selfie.';
}
