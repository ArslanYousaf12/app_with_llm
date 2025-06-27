# Voice-Activated Timer App Implementation Plan

## Overview
Building a Flutter voice-activated timer app for hands-free use during calisthenics exercises with dark mode theming and SS.S time format.

## Phase 1: Foundation & UI (Primary Focus)

### ✅ Step 1: Project Setup & Dependencies
- [x] Add required packages: `speech_to_text`, `permission_handler`, `audioplayers`
- [x] Configure iOS/Android permissions in manifest files for microphone access
- [x] Run `flutter pub get` to install dependencies

### ✅ Step 2: Dark Theme Implementation
- [x] Replace default MaterialApp theme with dark ColorScheme
- [x] Define consistent dark theme colors following Material Design
- [x] Update app title to "Voice Timer"

### ✅ Step 3: Architecture, Font Setup & Basic Timer Page
- [x] Create organized folder structure: `lib/screens/`, `lib/widgets/`, `lib/services/`
- [x] Setup BabasNeue font configuration in pubspec.yaml
- [x] Create basic TimerPage with placeholder UI for early testing
- [x] Update main.dart to use TimerPage as home screen
- [x] Remove boilerplate counter app code

### Step 4: Timer Display UI Component with Ticker (SS.S Format)
- [ ] Create TimerDisplay widget using Ticker for smooth refresh rate
- [ ] Implement SS.S format (e.g., "72.3" for 1:12.3)
- [ ] Use BabasNeue font for timer display
- [ ] Style with large, readable text using theme colors
- [ ] Handle time formatting logic (minutes to total seconds conversion)

### Step 5: Control Buttons UI & Updated Timer Page Testing
- [ ] Create ControlButtons widget with Start/Stop/Reset buttons
- [ ] Style buttons similar to iOS stopwatch app
- [ ] Use proper spacing and flex layout for responsive design
- [ ] Update TimerPage to include new ControlButtons widget
- [ ] Test UI layout and button interactions

### Step 6: Stopwatch Logic Implementation (Simplified)
- [ ] Declare Stopwatch directly in TimerScreen state
- [ ] Pass Stopwatch as argument to TimerDisplay widget
- [ ] Implement start, stop, and reset operations
- [ ] Connect button actions to Stopwatch methods
- [ ] Ensure proper state management and UI updates

## Phase 2: Voice Integration

### Step 7: Permission Handling
- [ ] Request microphone permissions on app startup
- [ ] Handle permission denied states gracefully
- [ ] Disable voice features when permissions not granted
- [ ] Show appropriate UI feedback for permission status

### Step 8: Speech Recognition Setup
- [ ] Initialize speech_to_text service
- [ ] Implement continuous listening for voice commands
- [ ] Handle speech recognition lifecycle (start/stop listening)
- [ ] Add error handling for speech service failures

### Step 9: Voice Command Parsing
- [ ] Add voice command parsing for "start" and "stop" commands
- [ ] Implement command validation and filtering
- [ ] Handle different pronunciations and variations
- [ ] Add logging for voice recognition events

### Step 10: Audio Feedback Implementation
- [ ] Implement beep sound playback on command recognition
- [ ] Handle audio permissions and playback errors
- [ ] Add audio assets for beep sounds
- [ ] Test audio feedback on different devices

### Step 11: Voice-Timer Integration
- [ ] Connect voice commands to existing timer actions
- [ ] Ensure voice commands work seamlessly with UI controls
- [ ] Handle conflicts between voice and manual controls
- [ ] Test complete voice-activated workflow

## Phase 3: Testing & Polish

### Step 12: Widget Testing
- [ ] Widget tests for TimerDisplay component
- [ ] Widget tests for ControlButtons component
- [ ] Integration tests for timer functionality
- [ ] Test timer accuracy and performance

### Step 13: Final Polish & Responsive Design
- [ ] Test responsive design across different screen sizes
- [ ] UI accessibility improvements
- [ ] Error handling and edge case management
- [ ] Performance optimization and cleanup

## Technical Requirements

### Time Format
- Display format: SS.S (e.g., "72.3" for 1 minute 12.3 seconds)
- Convert minutes:seconds to total seconds for display
- Use decimal precision for sub-second timing

### UI Components
- **TimerDisplay**: Uses Ticker for smooth refresh at screen refresh rate
- **ControlButtons**: Start/Stop/Reset styled like iOS stopwatch
- **TimerPage**: Main screen container with proper layout

### Architecture
- Stopwatch declared directly in TimerScreen state (no ChangeNotifier needed)
- TimerDisplay receives Stopwatch as parameter
- Clean separation between UI and business logic

### Testing Strategy
- Manual testing possible at each major step
- Each phase builds incrementally for continuous validation
- UI testing prioritized for immediate feedback

## Current Status
- ✅ Steps 1-3 completed
- 🔄 Next: Step 4 (Timer Display with Ticker)
- 📋 Remaining: Steps 4-13

## Notes
- Focus on UI-first approach for immediate testability
- Voice features added after core timer functionality is solid
- Dark mode only as specified in requirements
- BabasNeue font integrated for professional timer display