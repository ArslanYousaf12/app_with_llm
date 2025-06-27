import 'package:speech_to_text/speech_to_text.dart';
import 'dart:developer';

class SpeechService {
  static final SpeechToText _speechToText = SpeechToText();
  static bool _isInitialized = false;
  static bool _isListening = false;
  
  static bool get isListening => _isListening;
  static bool get isInitialized => _isInitialized;
  
  static Future<bool> initialize() async {
    try {
      _isInitialized = await _speechToText.initialize(
        onError: (error) {
          log('Speech recognition error: ${error.errorMsg}');
          _isListening = false;
        },
        onStatus: (status) {
          log('Speech recognition status: $status');
          _isListening = status == 'listening';
        },
      );
      
      log('Speech recognition initialized: $_isInitialized');
      return _isInitialized;
    } catch (e) {
      log('Error initializing speech recognition: $e');
      return false;
    }
  }
  
  static Future<void> startListening({
    required Function(String) onResult,
  }) async {
    if (!_isInitialized) {
      log('Speech recognition not initialized');
      return;
    }
    
    if (_isListening) {
      log('Already listening');
      return;
    }
    
    try {
      await _speechToText.listen(
        onResult: (result) {
          if (result.finalResult) {
            log('Speech result: ${result.recognizedWords}');
            onResult(result.recognizedWords.toLowerCase());
          }
        },
        listenFor: const Duration(seconds: 30),
        pauseFor: const Duration(seconds: 3),
        partialResults: false,
        cancelOnError: true,
        listenMode: ListenMode.confirmation,
      );
      
      _isListening = true;
      log('Started listening for voice commands');
    } catch (e) {
      log('Error starting speech recognition: $e');
    }
  }
  
  static Future<void> stopListening() async {
    if (!_isListening) return;
    
    try {
      await _speechToText.stop();
      _isListening = false;
      log('Stopped listening for voice commands');
    } catch (e) {
      log('Error stopping speech recognition: $e');
    }
  }
  
  static Future<void> cancelListening() async {
    if (!_isListening) return;
    
    try {
      await _speechToText.cancel();
      _isListening = false;
      log('Cancelled speech recognition');
    } catch (e) {
      log('Error cancelling speech recognition: $e');
    }
  }
}