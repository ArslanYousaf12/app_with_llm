import 'package:flutter/material.dart';
import 'dart:developer';
import '../widgets/timer_display.dart';
import '../widgets/control_buttons.dart';
import '../services/permission_service.dart';
import '../services/speech_service.dart';
import '../services/audio_service.dart';

class TimerPage extends StatefulWidget {
  const TimerPage({super.key});

  @override
  State<TimerPage> createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  final Stopwatch _stopwatch = Stopwatch();
  bool _hasMicrophonePermission = false;
  bool _isSpeechInitialized = false;
  
  @override
  void initState() {
    super.initState();
    _initializeServices();
  }
  
  Future<void> _initializeServices() async {
    await _checkPermissions();
    if (_hasMicrophonePermission) {
      await _initializeSpeech();
    }
  }
  
  Future<void> _checkPermissions() async {
    final hasPermission = await PermissionService.checkMicrophonePermission();
    setState(() {
      _hasMicrophonePermission = hasPermission;
    });
    
    if (!hasPermission) {
      _requestPermissions();
    }
  }
  
  Future<void> _requestPermissions() async {
    final granted = await PermissionService.requestMicrophonePermission();
    setState(() {
      _hasMicrophonePermission = granted;
    });
    
    if (granted) {
      await _initializeSpeech();
    } else {
      log('Microphone permission denied - voice features disabled');
    }
  }
  
  Future<void> _initializeSpeech() async {
    final initialized = await SpeechService.initialize();
    setState(() {
      _isSpeechInitialized = initialized;
    });
    
    if (initialized) {
      _startListening();
    } else {
      log('Speech recognition initialization failed');
    }
  }
  
  void _startListening() {
    if (_hasMicrophonePermission && _isSpeechInitialized) {
      SpeechService.startListening(
        onResult: _handleVoiceCommand,
      );
    }
  }
  
  void _handleVoiceCommand(String command) {
    log('Voice command received: $command');
    
    final cleanCommand = command.toLowerCase().trim();
    
    // Parse start commands
    if (_isStartCommand(cleanCommand)) {
      if (!_stopwatch.isRunning) {
        setState(() {
          _stopwatch.start();
        });
        log('Timer started via voice command');
        _playBeep(); // Will implement in next step
      }
    }
    // Parse stop commands  
    else if (_isStopCommand(cleanCommand)) {
      if (_stopwatch.isRunning) {
        setState(() {
          _stopwatch.stop();
        });
        log('Timer stopped via voice command');
        _playBeep(); // Will implement in next step
      }
    }
    
    // Continue listening for more commands
    Future.delayed(const Duration(milliseconds: 500), () {
      _startListening();
    });
  }
  
  bool _isStartCommand(String command) {
    const startVariations = [
      'start',
      'start timer',
      'begin',
      'go',
      'start it',
      'start now',
    ];
    
    return startVariations.any((variation) => 
      command.contains(variation) || 
      _fuzzyMatch(command, variation)
    );
  }
  
  bool _isStopCommand(String command) {
    const stopVariations = [
      'stop',
      'stop timer',
      'pause',
      'halt',
      'stop it',
      'stop now',
    ];
    
    return stopVariations.any((variation) => 
      command.contains(variation) || 
      _fuzzyMatch(command, variation)
    );
  }
  
  bool _fuzzyMatch(String command, String target) {
    // Simple fuzzy matching for voice recognition variations
    if (command.length < target.length) return false;
    
    int matches = 0;
    for (int i = 0; i < target.length; i++) {
      if (command.contains(target[i])) {
        matches++;
      }
    }
    
    return matches >= (target.length * 0.7); // 70% character match
  }
  
  Future<void> _playBeep() async {
    await AudioService.playBeep();
  }
  
  @override
  void dispose() {
    AudioService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.height < 600;
    
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              // Top spacer (responsive)
              Flexible(
                flex: isSmallScreen ? 2 : 3,
                child: Container(),
              ),
              
              // Timer display with responsive sizing
              Flexible(
                flex: 4,
                child: Center(
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: TimerDisplay(stopwatch: _stopwatch),
                  ),
                ),
              ),
              
              // Middle spacer
              Flexible(
                flex: isSmallScreen ? 1 : 2,
                child: Container(),
              ),
              
              // Control buttons
              Flexible(
                flex: 2,
                child: Center(
                  child: ControlButtons(
                    isRunning: _stopwatch.isRunning,
                    onStartStop: () {
                      setState(() {
                        if (_stopwatch.isRunning) {
                          _stopwatch.stop();
                        } else {
                          _stopwatch.start();
                        }
                      });
                    },
                    onReset: () {
                      setState(() {
                        _stopwatch.reset();
                      });
                    },
                  ),
                ),
              ),
              
              // Permission status indicator with responsive text
              if (!_hasMicrophonePermission)
                Flexible(
                  flex: 1,
                  child: Container(
                    margin: const EdgeInsets.only(top: 12),
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.orange.shade800,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.mic_off, color: Colors.white, size: 14),
                        const SizedBox(width: 6),
                        Flexible(
                          child: Text(
                            isSmallScreen 
                                ? 'Voice disabled' 
                                : 'Voice features disabled - microphone access required',
                            style: TextStyle(
                              color: Colors.white, 
                              fontSize: isSmallScreen ? 10 : 12,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              
              // Bottom spacer
              Flexible(
                flex: 1,
                child: Container(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}