import 'package:permission_handler/permission_handler.dart';
import 'dart:developer';

class PermissionService {
  static Future<bool> requestMicrophonePermission() async {
    try {
      final status = await Permission.microphone.status;
      
      if (status.isDenied) {
        final result = await Permission.microphone.request();
        log('Microphone permission requested: $result');
        return result.isGranted;
      }
      
      if (status.isPermanentlyDenied) {
        log('Microphone permission permanently denied');
        return false;
      }
      
      log('Microphone permission status: $status');
      return status.isGranted;
    } catch (e) {
      log('Error requesting microphone permission: $e');
      return false;
    }
  }
  
  static Future<bool> checkMicrophonePermission() async {
    try {
      final status = await Permission.microphone.status;
      return status.isGranted;
    } catch (e) {
      log('Error checking microphone permission: $e');
      return false;
    }
  }
  
  static Future<void> openSettings() async {
    try {
      await openAppSettings();
    } catch (e) {
      log('Error opening app settings: $e');
    }
  }
}