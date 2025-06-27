# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a **completed** Flutter voice-activated timer app designed for hands-free use during calisthenics exercises. The app implements all core features including voice recognition, audio feedback, responsive UI, and comprehensive testing.

### Key Features
- Voice commands: "start" and "stop" with variations and fuzzy matching
- SS.S time format display (e.g., "72.3" for 1:12.3)
- Dark mode only theming with Material 3 design
- iOS-style circular control buttons
- Audio beep feedback on voice recognition
- Responsive design with flexible layouts
- Comprehensive permission handling
- Full test coverage

## Development Commands

### Core Flutter Commands
- `flutter run` - Run the app in development mode
- `flutter build apk` - Build Android APK
- `flutter build ios` - Build iOS app
- `flutter test` - Run all tests
- `flutter analyze` - Run static analysis and linting

### Package Management
- `flutter pub get` - Install dependencies
- `flutter pub upgrade` - Upgrade dependencies
- `flutter pub outdated` - Check for outdated packages

### Platform-Specific Testing
- `flutter run -d ios` - Run on iOS simulator/device
- `flutter run -d android` - Run on Android emulator/device

### Testing Commands
- `flutter test test/widget_test.dart` - Run single test file
- `flutter test --coverage` - Run tests with coverage report

## Architecture Overview

### Core Components
- **TimerPage** (`lib/screens/timer_page.dart`) - Main screen with responsive layout, manages Stopwatch state and voice integration
- **TimerDisplay** (`lib/widgets/timer_display.dart`) - Uses Ticker for smooth 60fps updates, formats time as SS.S
- **ControlButtons** (`lib/widgets/control_buttons.dart`) - iOS-style circular Start/Stop/Reset buttons with state-dependent styling

### Service Layer
- **SpeechService** (`lib/services/speech_service.dart`) - Handles speech_to_text initialization, continuous listening, and lifecycle management
- **AudioService** (`lib/services/audio_service.dart`) - Manages beep sound playback with fallback mechanisms
- **PermissionService** (`lib/services/permission_service.dart`) - Microphone permission handling with graceful degradation

### Key Dependencies
- `speech_to_text: ^7.0.0` - Voice recognition
- `permission_handler: ^11.3.1` - Runtime permissions
- `audioplayers: ^6.1.0` - Audio feedback

### Architecture Principles
- **Stopwatch State Management**: Declared directly in TimerPage state (no ChangeNotifier), passed to TimerDisplay as parameter
- **Voice Integration**: Continuous listening with automatic restart, fuzzy matching for command variations
- **Responsive Design**: Uses Flexible widgets and MediaQuery for screen size adaptation
- **Error Handling**: Comprehensive error handling with logging and graceful fallbacks

## Code Style Conventions

### Flutter-Specific
- Use `log` from `dart:developer` for all logging
- Prefer Flexible/Expanded over fixed sizes for responsive design
- Dark theme implementation via MaterialApp theme, not hardcoded colors
- Small composable widgets over large monolithic components

### Voice Recognition
- Command parsing includes fuzzy matching for pronunciation variations
- Continuous listening with 500ms restart delay
- Beep feedback on successful command recognition
- Graceful degradation when permissions denied

### Time Formatting
- SS.S format: Total seconds with 1 decimal place (e.g., "72.3" for 1:12.3)
- Uses `duration.inMilliseconds / 1000.0` for precise timing
- Ticker-based updates for smooth 60fps refresh rate

## Key Files
- `specs/initial-requirements.md` - Original feature requirements
- `plan.md` - Complete implementation plan with all 13 steps
- `lib/main.dart` - App entry point with dark theme configuration
- `lib/screens/timer_page.dart` - Main screen with full feature integration
- `test/widget_test.dart` - Comprehensive widget and integration tests
- `pubspec.yaml` - Dependencies and project configuration