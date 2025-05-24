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
│ ├── main.dart # App entry point, GoRouter config, Theme setup, App lifecycle
│ ├── core/ # Foundational, reusable components across the app
│ │ ├── di.dart # GetIt dependency injection setup
│ │ ├── theme/ # Custom theming (colors, text styles, theme controller)
│ │ ├── utils/ # Generic utilities (e.g., SecureStorageService)
│ │ ├── services/ # Abstractions for external interactions (APIs, Auth, Biometrics, Location, Device Info)
│ │ └── models/ # Base models, common data structures
│ │ └── widgets/ # Reusable UI components (e.g., AppButton)
│ ├── features/ # Independent, self-contained modules for core functionalities
│ │ ├── auth/
│ │ │ ├── models/ # User authentication data models
│ │ │ ├── controllers/ # Business logic for user authentication (login, logout, session)
│ │ │ └── views/ # User Interface for authentication flows (LoginScreen)
│ │ ├── home/
│ │ │ ├── models/ # Financial data models (Account, Transaction)
│ │ │ ├── controllers/ # Logic for dashboard data fetching and presentation
│ │ │ └── views/ # User Interface for the home dashboard, reusable widgets (PrivacyOverlay)
│ │ ├── payment/
│ │ │ ├── models/ # Payment request/response data models
│ │ │ ├── controllers/ # Orchestrates payment logic, device/location data collection, API calls
│ │ │ └── views/ # User Interface for the payment process
│ │ └── settings/
│ │ ├── controllers/ # Logic for application settings and token management
│ │ └── views/ # User Interface for settings
│ ├── l10n/ # Localization (ARB files) - Source of translatable strings
│ ├── generated/ # Generated localization files by flutter gen-l10n
├── test/ # Unit and widget tests
├── pubspec.yaml # Project dependencies, metadata, and Flutter configuration
├── README.md # Project documentation and setup guide
├── l10n.yaml # Localization configuration for intl
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
