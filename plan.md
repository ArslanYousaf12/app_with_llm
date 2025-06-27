# Voice Timer App Implementation Plan

## Phase 1: Project Structure and Theme Setup

### 1. Set up project structure ✅
- [x] Create `lib/features/timer/` for timer-specific code
- [x] Create `lib/shared/widgets/` for reusable UI components
- [x] Create `lib/core/theme/` for theme configuration

### 2. Configure dark theme ✅
- [x] Create `app_theme.dart` with MaterialApp dark theme
- [x] Define color scheme, text styles, and button themes
- [x] Apply theme to MaterialApp

## Phase 2: Core Timer UI Implementation (Testable at Each Step)

### 3. Create TimerDisplay widget with BebasNeue font and TimerPage ✅
- [x] Configure pubspec.yaml to include BebasNeue font
- [x] Build `TimerDisplay` widget that:
  - [x] Shows elapsed time in SS.S format (e.g., "72.3" for 1:12.3)
  - [x] Uses Ticker for smooth UI refresh at screen refresh rate
  - [x] Takes Stopwatch as parameter
  - [x] Uses BebasNeue font
- [x] Create basic `TimerPage` with just TimerDisplay
- **App is now testable with timer display**

### 4. Create control buttons and update TimerPage ✅
- [x] Build `TimerControlButton` reusable widget
- [x] Create `StartStopButton` that toggles between start/stop states
- [x] Create `ResetButton` with proper styling
- [x] Update `TimerPage` to include buttons below timer
- **App is now testable with full UI**

### 5. Implement timer logic in TimerPage 
- [] Declare Stopwatch directly in `TimerPage` as stateful widget
- [] Pass Stopwatch to TimerDisplay
- [] Wire up button callbacks to start/stop/reset Stopwatch
- **App is now fully functional for manual timer control**

### 6. Refine timer page layout and modernize UI design 
- [] Update theme to use BebasNeue font throughout app
- [] Implement modern dark design with bright green accents using AppColors
- [] Create full-width timer display with green background and black text
- [] Design circular buttons - filled green for start/stop, outlined for reset
- [] Add STOPWATCH title to AppBar with settings icon
- [] Create two-section responsive layout (timer display 2/3, controls 1/3)
- [] Build VoiceIndicator widget with microphone icon and border
- [] Match screenshot design with proper spacing and colors
- [] Repurpose the TimerControlButton to match the new button style (used by the StartStopButton and ResetButton), including a label underneath the button
- [] Add a start/stop label to the StartStopButton
- [] Add a reset label to the ResetButton
- [] Use a StadiumBorder inside the VoiceIndicator
- [] Make the font bigger in the TimerDisplay
- [] Update the flex factors to 3/2 in the TimerPage so there's more space for the buttons and voice indicator


## Phase 3: Voice Features

### 7. Set up iOS permissions 
- [] Add permission_handler package
- [] Add microphone permission to Info.plist
- [] Configure iOS Podfile with PERMISSION_MICROPHONE=1 preprocessor definition
- [] Run pod install to apply iOS permission configuration
- [] Create permission request flow on app startup
- [] Add speech recognition permission to Info.plist and Podfile
- [] Request both microphone and speech recognition permissions together in the PermissionService, only return true if they are both granted
- [] If permissions are denied, show an alert dialog with instructions and "Cancel" and "Open Settings" buttons

### 8. Implement voice recognition 
- [] Add speech_to_text package to pubspec.yaml dependencies
- [] Create `VoiceCommandService` in `lib/core/services/voice_command_service.dart` with:
  - [] Stateless service with initialize method taking onStatus/onError callbacks
  - [] TimerCommand enum for start/stop commands
  - [] startListening method that returns Future<TimerCommand> using Completer
  - [] Command processing to recognize "start"/"stop" commands with proper logging
  - [] Proper speech recognition configuration with US locale and confirmation mode
- [] Integrate with TimerPage:
  - [] Initialize VoiceCommandService after permissions are granted
  - [] Implement continuous listening loop with error recovery
  - [] Connect voice commands to timer control logic
  - [] Update VoiceIndicator to show actual listening status from the service
  - [] Add TODO comment for beep sound (to be implemented in step 9)
- [] Update VoiceIndicator widget to accept dynamic listening state and show appropriate visual feedback

### 9. Add audio feedback
- [ ] Add audioplayers package
- [ ] Create `AudioService` to play beep sound
- [ ] Trigger beep when voice command recognized

## Phase 4: Polish and Error Handling

### 10. Handle permission denial
- [ ] Show appropriate UI when permissions denied
- [ ] Disable voice features gracefully
- [ ] Maintain manual-only mode functionality

### 11. Testing and refinement
- [ ] Test voice command recognition accuracy
- [ ] Add proper logging with dart:developer
- [ ] Polish UI animations and transitions

## Key Implementation Notes
- Time format: SS.S (seconds with one decimal)
- TimerDisplay uses Ticker for smooth refresh
- Stopwatch lives in TimerPage, passed to TimerDisplay
- Each phase produces a testable app
- No ChangeNotifier needed for simple timer logic