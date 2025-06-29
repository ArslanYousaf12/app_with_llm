import 'package:flutter/material.dart';
import 'dart:developer';
import 'timer_display.dart';
import 'start_stop_button.dart';
import 'reset_button.dart';
import '../../widgets/voice_indicator.dart';
import '../../services/permission_service.dart';
import '../../services/audio_service.dart';
import '../../core/services/voice_command_service.dart';

class TimerPage extends StatefulWidget {
  const TimerPage({super.key});

  @override
  State<TimerPage> createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  final Stopwatch _stopwatch = Stopwatch();
  bool _permissionsGranted = false;
  bool _isVoiceListening = false;
  bool _isVoiceInitialized = false;
  final VoiceCommandService _voiceService = VoiceCommandService();

  @override
  void initState() {
    super.initState();
    _requestPermissions();
  }

  Future<void> _requestPermissions() async {
    final granted = await PermissionService.requestPermissions();
    setState(() {
      _permissionsGranted = granted;
    });

    if (!granted && mounted) {
      _showPermissionDialog();
    } else if (granted) {
      // Initialize voice service after permissions are granted
      _initializeVoiceService();
    }
  }

  /// Initialize VoiceCommandService after permissions are granted
  Future<void> _initializeVoiceService() async {
    try {
      await _voiceService.initialize(
        onStatus: (status) {
          setState(() {
            _isVoiceListening = status == 'listening';
          });
        },
        onError: (error) {
          setState(() {
            _isVoiceListening = false;
          });
          // Retry initialization after error
          _retryVoiceInitialization();
        },
      );
      
      setState(() {
        _isVoiceInitialized = true;
      });
      
      // Start continuous listening loop
      _startContinuousListening();
    } catch (e) {
      setState(() {
        _isVoiceInitialized = false;
      });
      _retryVoiceInitialization();
    }
  }

  /// Start continuous listening loop
  void _startContinuousListening() async {
    if (!_isVoiceInitialized || !mounted) return;

    try {
      log('[TimerPage] Starting voice listening cycle');
      final command = await _voiceService.startListening();
      
      // Handle the recognized command
      switch (command) {
        case TimerCommand.start:
          _handleVoiceStart();
          break;
        case TimerCommand.stop:
          _handleVoiceStop();
          break;
      }
      
      // Restart listening for next command
      _startContinuousListening();
    } catch (e) {
      log('[TimerPage] Voice listening error: $e');
      // Handle listening error and retry
      _retryVoiceInitialization();
    }
  }

  /// Retry voice initialization
  void _retryVoiceInitialization() {
    if (mounted && _permissionsGranted) {
      _initializeVoiceService();
    }
  }

  /// Get the appropriate status text for VoiceIndicator based on permission and listening state
  /// Provides clear visual feedback when voice features are unavailable
  String _getVoiceIndicatorStatus() {
    if (!_permissionsGranted) {
      return 'VOICE DISABLED';  // Shows when permissions are denied
    } else if (_isVoiceListening) {
      return 'LISTENING';       // Shows when actively listening for commands
    } else if (_isVoiceInitialized) {
      return 'READY';           // Shows when ready to listen
    } else {
      return 'INITIALIZING';    // Shows during voice service setup
    }
  }

  Future<void> _showPermissionDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Permissions Required'),
          content: const Text(
            'This app needs microphone and speech recognition permissions to provide voice control features. Please grant these permissions in Settings.',
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Open Settings'),
              onPressed: () {
                Navigator.of(context).pop();
                PermissionService.openSettings();
              },
            ),
          ],
        );
      },
    );
  }

  /// Handle manual start/stop button - works regardless of voice permission status
  void _handleStartStop() {
    setState(() {
      if (_stopwatch.isRunning) {
        _stopwatch.stop();
      } else {
        _stopwatch.start();
      }
    });
  }

  /// Handle voice start command
  void _handleVoiceStart() {
    log('[TimerPage] Voice start command received');
    if (!_stopwatch.isRunning) {
      setState(() {
        _stopwatch.start();
      });
      AudioService.playBeep();
      log('[TimerPage] Timer started via voice command');
    }
  }

  /// Handle voice stop command  
  void _handleVoiceStop() {
    log('[TimerPage] Voice stop command received');
    if (_stopwatch.isRunning) {
      setState(() {
        _stopwatch.stop();
      });
      AudioService.playBeep();
      log('[TimerPage] Timer stopped via voice command');
    }
  }

  /// Handle manual reset button - works regardless of voice permission status
  void _handleReset() {
    setState(() {
      _stopwatch.reset();
    });
  }

  @override
  void dispose() {
    _voiceService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.settings, color: Colors.white),
          onPressed: () {
            // TODO: Navigate to settings page
          },
        ),
        title: const Text('STOPWATCH'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(flex: 5, child: TimerDisplay(stopwatch: _stopwatch)),
          SizedBox(height: 20),
          Expanded(
            flex: 3,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ResetButton(onPressed: _handleReset),
                  StartStopButton(
                    isRunning: _stopwatch.isRunning,
                    onPressed: _handleStartStop,
                  ),
                ],
              ),
            ),
          ),
          // Voice indicator at the bottom
          VoiceIndicator(
            isListening: _isVoiceListening,
            status: _getVoiceIndicatorStatus(),
            confidence: 0.99,
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
