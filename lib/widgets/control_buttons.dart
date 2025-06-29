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
          context: context,
          text: isRunning ? 'STOP' : 'START',
          icon: isRunning ? Icons.pause : Icons.play_arrow,
          onTap: onStartStop,
          isFilled: !isRunning,
        ),
        
        // Reset button
        _buildButton(
          context: context,
          text: 'RESET',
          icon: Icons.refresh,
          onTap: onReset,
          isFilled: false,
        ),
      ],
    );
  }

  Widget _buildButton({
    required BuildContext context,
    required String text,
    required IconData icon,
    required VoidCallback onTap,
    required bool isFilled,
  }) {
    final backgroundColor =
        isFilled ? AppConstants.primary : AppConstants.background;
    final iconColor = isFilled ? AppConstants.textDark : AppConstants.textLight;
    final borderColor = AppConstants.primary;

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
              borderRadius:
                  BorderRadius.circular(AppConstants.buttonBorderRadius),
              onTap: onTap,
              child: Center(
                child: Icon(
                  icon,
                  color: iconColor,
                  size: AppConstants.buttonIconSize,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: AppConstants.paddingSmall),
        Text(
          text,
          style: Theme.of(context).textTheme.labelLarge,
        ),
      ],
    );
  }
}