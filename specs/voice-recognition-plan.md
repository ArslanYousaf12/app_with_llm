# Voice Recognition Implementation Plan

## Overview
Implement voice recognition feature for the Flutter timer app that listens continuously for "start" and "stop" commands, following the specifications in `specs/voice-recognition.md`.

## Implementation Strategy

### 1. Add Speech Recognition Package
- Add `speech_to_text: ^6.6.0` to pubspec.yaml dependencies
- This package provides cross-platform speech recognition with continuous listening capabilities

### 2. Create VoiceCommandService
Create `lib/core/services/voice_command_service.dart` with:
- **Initialization method**: Initialize speech recognition, handle errors with recursive retry
- **Continuous listening loop**: Start listening → process commands → restart listening
- **Command processing**: Recognize "start"/"stop" commands and call timer callbacks
- **Error handling**: Graceful recovery with recursive retry for both init and listening failures
- **Minimal state**: Only track listening status and initialization state

### 3. Integrate with TimerPage
Modify `lib/features/timer/timer_page.dart` to:
- Initialize VoiceCommandService after permissions are granted
- Pass timer control methods (`_toggleTimer`) as callbacks to the service
- Update VoiceIndicator to show actual listening status
- Add TODO comment for beep sound (step 9 in plan.md)

### 4. Update VoiceIndicator Widget
Modify `lib/features/timer/widgets/voice_indicator.dart` to:
- Accept dynamic listening state from TimerPage
- Show appropriate visual feedback based on listening status

## Architecture Principles
- **Separation of concerns**: Keep voice recognition logic separate from UI
- **Minimal state**: Service manages only essential listening state
- **Recursive error handling**: Graceful recovery from initialization and listening failures
- **Simple integration**: Timer methods passed as callbacks to avoid tight coupling

## Files to Modify/Create
1. `pubspec.yaml` - Add speech_to_text dependency
2. `lib/core/services/voice_command_service.dart` - New service (main implementation)
3. `lib/features/timer/timer_page.dart` - Integration and initialization
4. `lib/features/timer/widgets/voice_indicator.dart` - Dynamic status display

This approach keeps the implementation simple, maintains separation between voice recognition and UI, and follows the recursive error handling pattern specified in the requirements.