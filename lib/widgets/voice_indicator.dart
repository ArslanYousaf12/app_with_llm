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

  bool get _isDisabled => status == 'VOICE DISABLED';

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
        color: _isDisabled ? Colors.grey.shade600 : AppConstants.primary,
        shape: StadiumBorder(
          side: BorderSide(
            color: _isDisabled ? Colors.grey.shade600 : AppConstants.primary,
            width: AppConstants.buttonBorderWidth,
          ),
        ),
      ),
      child: Row(
        children: [
          // Microphone icon - show disabled icon when voice is disabled
          Icon(
            _isDisabled ? Icons.mic_off : Icons.mic, 
            color: _isDisabled ? Colors.grey.shade400 : AppConstants.textDark, 
            size: 24
          ),
          const SizedBox(width: AppConstants.paddingMedium),

          // Status text
          Expanded(
            child: Text(
              _isDisabled ? status : '$status ...',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: _isDisabled ? Colors.grey.shade400 : null,
              ),
            ),
          ),

          // Info icon - show warning when disabled
          Icon(
            _isDisabled ? Icons.warning_outlined : Icons.info_outline, 
            color: _isDisabled ? Colors.grey.shade400 : AppConstants.textDark, 
            size: 20
          ),
        ],
      ),
    );
  }
}
