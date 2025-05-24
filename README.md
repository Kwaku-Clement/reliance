Reliance App is a secure, multi-language (English/French) mobile banking app built with Flutter. It features robust security, scalable architecture, and an intuitive UI for real-world fintech use.
Key Features

    Multi-language Support: Switch between English and French.
    Dynamic Theming: Light, dark, or system themes.
    Secure Authentication: JWTs, refresh tokens, and biometric login (Face ID/Touch ID).
    Transaction Management: Real-time transaction history with credit/debit details.
    Secure Payments: Includes device and location data for fraud detection.
    Privacy Overlay: Hides sensitive content when the app is in the background.
    Scalable MVC Architecture: Organized for maintainability and testability.
    State Management: Uses provider for reactive UI updates.
    Dependency Injection: Uses get_it for testable services.
    Routing: go_router for type-safe navigation.
    Error Handling & Logging: Comprehensive error management with logger.
    Custom UI: Consistent design with AppButton, AppColors, and AppTextStyles.

Folder Structure
text
reliance_app/
├── lib/
│ ├── main.dart # App entry, routing, and theme setup
│ ├── core/ # Shared utilities, services, and themes
│ ├── features/ # Modules for auth, home, payment, settings
│ ├── l10n/ # Localization files
│ ├── generated/ # Generated localization code
├── test/ # Unit and widget tests
├── pubspec.yaml # Dependencies and config
├── README.md # Documentation
├── l10n.yaml # Localization config
Technologies

    Flutter & Dart: Cross-platform framework and language.
    Provider: State management.
    GetIt: Dependency injection.
    GoRouter: Navigation.
    Packages: http, flutter_secure_storage, local_auth, geolocator, device_info_plus, intl, logger, uuid, mocktail.
    Linting: flutter_lints for code quality.

Setup

    Prerequisites:
        Install Flutter SDK, IDE (VS Code/Android Studio), and device/emulator.
        Configure Android (ACCESS_FINE_LOCATION, USE_BIOMETRIC) and iOS (NSLocationWhenInUseUsageDescription, NSFaceIDUsageDescription) permissions.
    Clone & Install:
    bash

git clone [repository-url]
cd reliance_app
flutter pub get
flutter gen-l10n
Run:
bash
flutter run
Test Credentials:

    Username: user@example.com
    Password: SecurePassword123!

Tests:
bash

    flutter test

Simulated Backend

    Uses dummy data for login, balance, transactions, and payments.
    Device/location data is logged, simulating backend integration.
    Uncomment live API calls in ApiService and AuthService for production.

Security

    Secure token storage, biometric authentication, and privacy overlay.
    No sensitive data (passwords, card numbers) stored locally or logged.

Future Enhancements

    Live backend integration, push notifications, 2FA, and CI/CD.

License

MIT License.
