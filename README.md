
# 📚 AI Study Assistant

A Flutter-based mobile application designed to make study assistance more accessible through a mobile interface. This project explores mobile UI development, backend integration, and Firebase-powered application services.

**Built with Flutter and Dart.**

## ✨ Overview

AI Study Assistant is a mobile application project focused on creating a convenient learning experience for students. It combines a Flutter frontend with a backend component to explore how mobile applications can connect to services and data.

## 🚀 Key Highlights

- 📱 **Cross-platform development:** Built with Flutter and Dart.
- 🔥 **Firebase integration:** Uses Firebase Core, Firebase Authentication, and Cloud Firestore dependencies.
- 🌐 **HTTP communication:** Includes the HTTP package for making network requests.
- 🔄 **Real-time communication support:** Includes Socket.IO client dependency.
- 🆔 **Unique identifiers:** Uses the UUID package.
- 🧩 **Backend component:** Includes a `studybot_backend/` directory.
- 🧪 **Testing support:** Includes Flutter test dependencies.

> Features available in the running application depend on the implemented code and configured services.

## 🛠️ Tech Stack

| Category | Technologies |
|---|---|
| Mobile framework | Flutter |
| Programming language | Dart |
| Authentication services | Firebase Authentication |
| Cloud database | Cloud Firestore |
| Firebase integration | Firebase Core |
| Networking | HTTP |
| Real-time communication library | Socket.IO Client |
| Testing | Flutter Test |
| Development tools | Android Studio, VS Code |

## 📂 Project Structure

```text
AI-STUDY-ASSISTANT/
├── android/              # Android platform configuration
├── ios/                  # iOS platform configuration
├── lib/                  # Flutter application source code
├── test/                 # Flutter tests
├── web/                  # Web platform configuration
├── linux/                # Linux platform configuration
├── macos/                # macOS platform configuration
├── windows/              # Windows platform configuration
├── studybot_backend/     # Backend component
├── pubspec.yaml          # Flutter dependencies and configuration
├── pubspec.lock          # Locked dependency versions
└── README.md             # Project documentation
```

## ⚙️ Getting Started

### Prerequisites

Install the following tools:

- [Flutter SDK](https://docs.flutter.dev/get-started/install)
- [Dart SDK](https://dart.dev/get-dart) (included with Flutter)
- [Android Studio](https://developer.android.com/studio) or Visual Studio Code
- Git
- An Android emulator or a physical Android device

### 1. Clone the repository

```bash
git clone https://github.com/anushkakashyap31/AI-STUDY-ASSISTANT.git
cd AI-STUDY-ASSISTANT
```

### 2. Check your Flutter environment

```bash
flutter doctor
```

Resolve any required SDK or device setup issues reported by the command.

### 3. Install dependencies

```bash
flutter pub get
```

### 4. Configure Firebase

If your selected application features require Firebase:

1. Create or open a project in the [Firebase Console](https://console.firebase.google.com/).
2. Register the appropriate Android application.
3. Configure Firebase for Flutter using the official setup instructions.
4. Enable the Firebase services required by the application.
5. Keep private credentials and secrets out of version control.

Follow the repository's actual Firebase configuration and backend requirements when setting up the project.

### 5. Run the Flutter application

```bash
flutter run
```

Select an available emulator or connected device when prompted.

### 6. Run tests

```bash
flutter test
```

## 🔐 Configuration and Security

- Never commit API keys, passwords, service-account credentials, or private environment files.
- Configure Firebase and backend services according to their official documentation.
- Store secrets securely and use environment-specific configuration where appropriate.

## 🧪 Development

Useful Flutter commands:

```bash
# Check Flutter and Dart setup
flutter doctor

# Install dependencies
flutter pub get

# Analyze source code
flutter analyze

# Run automated tests
flutter test

# Build an Android APK
flutter build apk
```

## 🗺️ Future Improvements

Potential improvements, depending on the current implementation:

- Improve mobile UI consistency and accessibility.
- Add automated tests for important application flows.
- Improve error handling and loading states.
- Document backend setup and API integration.
- Add screenshots and a demonstration video.
- Improve application performance and maintainability.

## 👩‍💻 Author

**Anushka Kashyap**

- GitHub: [@anushkakashyap31](https://github.com/anushkakashyap31)
- Project: [AI Study Assistant](https://github.com/anushkakashyap31/AI-STUDY-ASSISTANT)

---

*Developed as a mobile application project to explore Flutter development and application integration.*
