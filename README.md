# Bit Key - Secure Password Manager

A secure password manager application built with Flutter that allows users to store and manage sensitive information like login credentials, credit card details, and personal identities with military-grade encryption.

## 🚀 Features

- **Secure Storage**: Encrypts all sensitive data using AES-256 encryption
- **Biometric Authentication**: Supports fingerprint and face recognition for quick access
- **Master Password Protection**: Primary security layer with a master password
- **Password Generator**: Built-in secure password generation tools
- **Multi-category Storage**: Organize data into logins, credit cards, and personal identities
- **Folder Organization**: Group related items in custom folders
- **Search Functionality**: Quickly find stored information
- **Session Management**: Automatic app locking after inactivity
- **Jailbreak/Root Detection**: Prevents use on compromised devices
- **Screenshot Protection**: Prevents screenshots of sensitive data
- **Shake to Lock**: Quick security feature to lock the app by shaking the device
- **Import/Export**: Securely backup and restore your data
- **Recycle Bin**: Temporary storage for deleted items

## 🛠️ Technical Stack

- **Framework**: Flutter (Dart)
- **Architecture**: Clean Architecture with BLoC pattern
- **State Management**: Flutter BLoC
- **Database**: Hive (local NoSQL database)
- **Encryption**: AES-256 cipher with secure key derivation
- **Dependency Injection**: GetIt
- **Navigation**: GoRouter
- **UI Components**: Custom glassmorphism design with liquid glass effects

## 📋 Data Categories

### Logins

- Website/Application name
- Username/Email
- Encrypted password
- Custom fields

### Credit Cards

- Card number
- Expiration date
- CVV
- Cardholder name
- Card type

### Identities

- Personal information
- Addresses
- Phone numbers
- Email addresses

## 🔐 Security Features

- **End-to-End Encryption**: All data encrypted locally with master key
- **Secure Key Storage**: Master key never stored in plain text
- **Biometric Authentication**: Device-level security integration
- **Device Integrity Checks**: Prevents use on jailbroken/rooted devices
- **Session Management**: Automatic timeout and lock
- **Secure Storage**: Flutter Secure Storage for sensitive keys
- **No Network Transmission**: All data stored locally on device

## 🏗️ Architecture

The app follows Clean Architecture principles:

```
presentation (UI layer)
├── bloc (state management)
domain (business logic)
├── repo (repository interfaces)
data (data sources)
├── repo (repository implementations)
```

### Key Components:

- **BLoC Pattern**: For state management and business logic
- **Repository Pattern**: For data abstraction
- **Dependency Injection**: For loose coupling
- **Hive Database**: For local data persistence
- **Secure Storage**: For sensitive key management

## 🛡️ Security Implementation

- **Salt Generation**: Unique salt for each user
- **Key Derivation**: PBKDF2 for master key hashing
- **Session Keys**: Temporary keys for active sessions
- **Encrypted Master Key**: Master key encrypted with session key
- **Biometric Integration**: Local Authentication package
- **Device Security Checks**: Jailbreak/Root detection
- **Screenshot Prevention**: No Screenshot package integration

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (3.9.2 or higher)
- Dart SDK (bundled with Flutter)
- Android Studio / VS Code
- iOS or Android device/simulator

### Installation

1. Clone the repository:

```bash
git clone <repository-url>
cd bit_key
```

2. Install dependencies:

```bash
flutter pub get
```

3. Run the application:

```bash
flutter run
```

### Build for Production

```bash
# Android
flutter build apk --release

# iOS
flutter build ios --release
```

## 🧪 Testing

The project includes unit and widget tests:

```bash
flutter test
```

## 📱 Supported Platforms

- Android 5.0+ (API level 21+)
- iOS 9.0+
- Web (planned)
- Desktop (planned)

## ⚠️ Security Best Practices

1. **Use a Strong Master Password**: Choose a unique, complex master password
2. **Enable Biometrics**: Use fingerprint or face recognition for convenience
3. **Regular Backups**: Export your data regularly to secure locations
4. **Device Security**: Keep your device secure with screen lock
5. **Physical Security**: Don't leave your device unattended
6. **Session Timeout**: Configure appropriate session timeout values

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 🐛 Issues & Support

If you encounter any issues or have questions, please file an issue in the GitHub repository.

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- All the open-source packages that made this project possible
- The security community for best practices and guidance

## 🖼️ Screenshots

Below are example screenshots to showcase the app. Place your images in the `assets/screenshots/` folder (or another path you prefer) and update `pubspec.yaml` accordingly.

| Screen              |                                  Description | Example path                          |
| ------------------- | -------------------------------------------: | ------------------------------------- |
| Login / Unlock      |           Master password / biometric screen | ![](flutter_01.png)                   |
| Vault page          |          All logins/cards/identities/folders | ![](flutter_02.png)                   |
| Generator password  | Generate password with any custom parameters |  ![](flutter_03.png)                  |
| Settings            |                                              | ![](flutter_04.png)                   |
| Settings / Security |            App settings and security options | ![](flutter_05.png)                   |
| Settings / Language |                                              | ![](flutter_06.png)                   |
| Settings / About app|                                              | ![](flutter_07.png)                   |

How to add screenshots:

1. Create the folder (if missing):

```bash
mkdir -p assets/screenshots
```

2. Copy your PNG/JPEG images into `assets/screenshots/` and name them as used in the table.

3. Register the assets in `pubspec.yaml` (example):

```yaml
flutter:
	assets:
		- assets/screenshots/home.png
		- assets/screenshots/login.png
		- assets/screenshots/vault_logins.png
		- assets/screenshots/create_item.png
		- assets/screenshots/settings.png
```

4. (Optional) For many images, register the whole folder:

```yaml
flutter:
	assets:
		- assets/screenshots/
```

Recommended image size: 1080x1920 (or scaled down for README previews). Use compressed PNG/JPEG to keep repo size small.

---

> **Note**: This application is designed for personal use. Always ensure you have proper backups of your important data.
