# Voice Recognition Feature

These are the requirements for the voice recognition feature:

### App Startup

- Request microphone and speech recognition permissions and show a dialog if the user denies the permission (already implemented)
- If the permissions are granted, initialize the voice recognition service
- If initialization is successful, start a listening loop

### Listening loop

- Start listening for voice commands
- Listen continuously until a command is recognized (e.g. "start", "stop")
- As soon as a command is recognized:
  - stop listening
  - process the command by starting/stopping the timer (using the existing methods in the TimerPage)
  - play a beep sound (for now just add a comment with a TODO, as this will be implemented in step 9 of @plan.md)
- Then, start the listening loop again

Implement the listening loop by creating the appropriate methods and calling them recursively as needed.

### Error handling

- If any errors occur during initialization, recover gracefully by attempting the initialization again (recursive)
- If any errors occur during the listening loop, recover gracefully by attempting the listening loop again (recursive)

### Implementation guidelines

Propose a solution that:

- is simple
- uses as little local state as possible
- keeps the API calls and UI code separate

