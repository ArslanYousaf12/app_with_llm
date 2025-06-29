import 'package:flutter/material.dart';
import '../core/constants/app_constants.dart';

class ControlButtons extends StatelessWidget {
  final bool isRunning;
  final VoidCallback onStartStop;
  final VoidCallback onReset;

  const ControlButtons({
    super.key,
    required this.isRunning,
    required this.onStartStop,
    required this.onReset,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // Start/Stop button
        _buildButton(
          text: isRunning ? 'STOP' : 'START',
          icon: isRunning ? Icons.pause : Icons.play_arrow,
          backgroundColor: isRunning ? AppConstants.backgroundDark : AppConstants.brightGreen,
          borderColor: isRunning ? AppConstants.brightGreen : AppConstants.brightGreen,
          textColor: isRunning ? AppConstants.brightGreen : AppConstants.textDark,
          onTap: onStartStop,
        ),
        
        // Reset button
        _buildButton(
          text: 'RESET',
          icon: Icons.refresh,
          backgroundColor: AppConstants.backgroundDark,
          borderColor: AppConstants.brightGreen,
          textColor: AppConstants.brightGreen,
          onTap: onReset,
        ),
      ],
    );
  }

  Widget _buildButton({
    required String text,
    required IconData icon,
    required Color backgroundColor,
    required Color borderColor,
    required Color textColor,
    required VoidCallback onTap,
  }) {
    return Column(
      children: [
        Container(
          width: AppConstants.buttonSize,
          height: AppConstants.buttonSize,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: backgroundColor,
            border: Border.all(
              color: borderColor,
              width: AppConstants.buttonBorderWidth,
            ),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(AppConstants.buttonSize / 2),
              onTap: onTap,
              child: Center(
                child: Icon(
                  icon,
                  color: textColor,
                  size: 36,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: AppConstants.paddingSmall),
        Text(
          text,
          style: TextStyle(
            color: AppConstants.brightGreen,
            fontSize: AppConstants.buttonTextSize,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}