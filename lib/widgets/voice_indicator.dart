import 'package:flutter/material.dart';
import '../core/constants/app_constants.dart';

class VoiceIndicator extends StatelessWidget {
  final bool isListening;
  final String status;
  final double confidence;

  const VoiceIndicator({
    super.key,
    required this.isListening,
    this.status = 'STOP',
    this.confidence = 0.99,
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
      decoration: ShapeDecoration(
        color: AppConstants.primary,
        shape: StadiumBorder(
          side: BorderSide(
            color: AppConstants.primary,
            width: AppConstants.buttonBorderWidth,
          ),
        ),
      ),
      child: Row(
        children: [
          // Microphone icon
          Icon(Icons.mic, color: AppConstants.textDark, size: 24),
          const SizedBox(width: AppConstants.paddingMedium),

          // Status text with confidence
          Expanded(
            child: Text(
              '$status - ${(confidence * 100).toInt()}%',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),

          // Info icon
          Icon(Icons.info_outline, color: AppConstants.textDark, size: 20),
        ],
      ),
    );
  }
}
