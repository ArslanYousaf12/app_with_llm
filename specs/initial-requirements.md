
I want to build a voice-activated timer iOS app, that I can use hands-free when performing my calisthenics exercises.

The app should be built with Flutter and have the following features:

## Basic UI

Simple page app with:

- Simple timer UI which shows the elapsed time
- Start/stop button and reset button like on the iOS stopwatch app
- Use a `Stopwatch` object to keep track of the time

## Voice mode

- On app startup, the app should request for microphone and speakers access
- If access is denied, the corresponding features will be disabled
- When I say "start", the app should immediately start the timer (if the timer was already running and previously paused, continue from where it left off).
- When I say "stop", the app should immediately stop the timer
- Play a beep sound when a voice command is recognized ("start" or "stop")

## Other requirements

### Theming

- The app uses dark mode only
- Theming should be done by setting the `theme` in the `MaterialApp`, rather than hardcoding colors and sizes in the widgets themselves

### Code Style

- Ensure proper separation of concerns by creating a suitable folder structure
- Prefer small composable widgets over large ones
- Prefer using flex values over hardcoded sizes when creating widgets inside rows/columns, ensuring the UI adapts to various screen sizes
- Use `log` from `dart:developer` rather than `print` or `debugPrint` for logging