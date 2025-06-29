import 'package:flutter/material.dart';
import '../core/constants/app_constants.dart';

class VoiceIndicator extends StatelessWidget {
  final bool isListening;
  final String status;
  final double confidence;

  const VoiceIndicator({
    super.key,
    required this.isListening,
    required this.status,
    this.confidence = 0.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppConstants.voiceIndicatorHeight,
      margin: const EdgeInsets.all(AppConstants.paddingMedium),
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstants.paddingLarge,
        vertical: AppConstants.paddingMedium,
      ),
      decoration: BoxDecoration(
        color: AppConstants.backgroundDark,
        border: Border.all(
          color: AppConstants.brightGreen,
          width: AppConstants.buttonBorderWidth,
        ),
        borderRadius: BorderRadius.circular(AppConstants.voiceIndicatorBorderRadius),
      ),
      child: Row(
        children: [
          // Microphone icon
          Icon(
            Icons.mic,
            color: AppConstants.brightGreen,
            size: 24,
          ),
          const SizedBox(width: AppConstants.paddingMedium),
          
          // Status text
          Expanded(
            child: Text(
              status,
              style: TextStyle(
                color: AppConstants.brightGreen,
                fontSize: AppConstants.buttonTextSize,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          
          // Confidence indicator or info icon
          if (confidence > 0) ...[
            Text(
              '${(confidence * 100).toInt()}%',
              style: TextStyle(
                color: AppConstants.brightGreen,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ] else ...[
            Icon(
              Icons.info_outline,
              color: AppConstants.brightGreen,
              size: 20,
            ),
          ],
        ],
      ),
    );
  }
}