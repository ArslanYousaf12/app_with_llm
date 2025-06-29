import 'dart:async';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'dart:developer';

enum TimerCommand { start, stop }

class VoiceCommandService {
  static final VoiceCommandService _instance = VoiceCommandService._internal();
  factory VoiceCommandService() => _instance;
  VoiceCommandService._internal();

  final SpeechToText _speechToText = SpeechToText();

  /// Initialize the speech recognition service
  Future<void> initialize({
    Function(String)? onStatus,
    Function(String)? onError,
  }) async {
    try {
      log('[VoiceCommandService] Initializing speech recognition...');
      bool available = await _speechToText.initialize(
        onError: (error) {
          log('[VoiceCommandService] Speech recognition error: ${error.errorMsg}');
          onError?.call(error.errorMsg);
        },
        onStatus: (status) {
          log('[VoiceCommandService] Speech recognition status: $status');
          onStatus?.call(status);
        },
      );

      if (!available) {
        throw Exception('Speech recognition not available');
      }
      
      log('[VoiceCommandService] Initialized successfully');
    } catch (e) {
      log('[VoiceCommandService] Initialization error: $e');
      onError?.call(e.toString());
      rethrow;
    }
  }

  /// Start listening for voice commands and return the recognized command
  Future<TimerCommand> startListening() async {
    final completer = Completer<TimerCommand>();
    
    try {
      log('Starting voice listening...');
      await _speechToText.listen(
        onResult: (SpeechRecognitionResult result) {
          if (!result.finalResult) return;

          final recognizedWords = result.recognizedWords.toLowerCase().trim();
          log('Voice command recognized: "$recognizedWords"');

          TimerCommand? command;

          // Check for start commands
          const startCommands = ['start', 'begin', 'go', 'play', 'resume'];
          if (startCommands.any((cmd) => recognizedWords.contains(cmd))) {
            command = TimerCommand.start;
            log('Start command detected');
          }
          // Check for stop commands
          else {
            const stopCommands = ['stop', 'pause', 'halt', 'end', 'finish'];
            if (stopCommands.any((cmd) => recognizedWords.contains(cmd))) {
              command = TimerCommand.stop;
              log('Stop command detected');
            }
          }

          if (command != null && !completer.isCompleted) {
            _speechToText.stop();
            completer.complete(command);
          }
        },
        listenOptions: SpeechListenOptions(
          listenMode: ListenMode.confirmation,
          cancelOnError: false,
          partialResults: false,
        ),
        localeId: 'en_US',
      );
    } catch (e) {
      log('Error starting listening: $e');
      if (!completer.isCompleted) {
        completer.completeError(e);
      }
    }

    return completer.future;
  }

  /// Stop the service and clean up resources
  void dispose() {
    log('Disposing VoiceCommandService...');
    _speechToText.stop();
  }
}