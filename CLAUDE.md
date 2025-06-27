# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

The complete plan for the project has been written to @plan.md

## Project Overview

This is a Flutter app for a voice-activated timer designed for hands-free use during calisthenics exercises. The app is currently in early development with basic Flutter boilerplate code.

### Key Requirements (from specs/initial_requirements.md)
- Voice-activated timer with "start" and "stop" commands
- Simple stopwatch UI with elapsed time display
- Dark mode only theming
- Microphone and speaker access for voice commands
- Audio feedback (beep) when voice commands are recognized
- Uses `Stopwatch` object for time tracking

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

## Code Architecture Guidelines

### Folder Structure Requirements
- Maintain proper separation of concerns with suitable folder structure
- Prefer small composable widgets over large ones
- Keep main.dart as entry point, organize features in subdirectories under lib/

### Flutter-Specific Conventions
- Use `log` from `dart:developer` instead of `print` or `debugPrint`
- Prefer flex values over hardcoded sizes in Rows/Columns for responsive design
- Implement dark mode theming through MaterialApp theme rather than hardcoded colors

### Current State
- Currently has basic Flutter counter app boilerplate in lib/main.dart
- Single widget test in test/widget_test.dart
- Uses flutter_lints for code quality (configured in analysis_options.yaml)
- Dependencies: cupertino_icons, flutter_lints
- Target SDK: Dart ^3.7.0

### Future Implementation Areas
The app will need voice recognition, audio playback, and timer functionality to be implemented according to the specifications in specs/initial_requirements.md.

## Key Files
- `specs/initial_requirements.md` - Complete feature requirements and specifications
- `lib/main.dart` - Main app entry point (currently boilerplate)
- `test/widget_test.dart` - Main widget test file
- `pubspec.yaml` - Dependencies and project configuration