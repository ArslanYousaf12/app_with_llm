import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';
import 'dart:developer';

class PermissionService {
  static Future<bool> requestPermissions() async {
    try {
      log('Requesting microphone and speech recognition permissions');
      
      // Request both permissions
      Map<Permission, PermissionStatus> permissions = await [
        Permission.microphone,
        Permission.speech,
      ].request();
      
      final microphoneStatus = permissions[Permission.microphone]!;
      final speechStatus = permissions[Permission.speech]!;
      
      log('Microphone permission: $microphoneStatus');
      log('Speech recognition permission: $speechStatus');
      
      // Both permissions must be granted
      bool allGranted = microphoneStatus.isGranted && speechStatus.isGranted;
      
      if (allGranted) {
        log('All permissions granted successfully');
      } else {
        log('One or more permissions denied');
      }
      
      return allGranted;
    } catch (e) {
      log('Error requesting permissions: $e');
      return false;
    }
  }
  
  
  static Future<bool> checkPermissions() async {
    try {
      final microphoneStatus = await Permission.microphone.status;
      final speechStatus = await Permission.speech.status;
      
      return microphoneStatus.isGranted && speechStatus.isGranted;
    } catch (e) {
      log('Error checking permissions: $e');
      return false;
    }
  }
  
  // Legacy methods for backward compatibility
  static Future<bool> requestMicrophonePermission() async {
    return requestPermissions();
  }
  
  static Future<bool> checkMicrophonePermission() async {
    return checkPermissions();
  }
  
  static Future<void> openSettings() async {
    try {
      await openAppSettings();
    } catch (e) {
      log('Error opening app settings: $e');
    }
  }
}