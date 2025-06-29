import 'package:flutter/material.dart';
import '../../core/constants/app_constants.dart';

class TimerControlButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;
  final bool isPrimary;
  final String label;

  const TimerControlButton({
    super.key,
    required this.onPressed,
    required this.icon,
    required this.label,
    this.isPrimary = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: AppConstants.buttonSize,
          height: AppConstants.buttonSize,
          child: isPrimary
              ? ElevatedButton(
                  onPressed: onPressed,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppConstants.primary,
                    foregroundColor: AppConstants.textDark,
                    shape: const CircleBorder(),
                    padding: EdgeInsets.zero,
                  ),
                  child: Icon(icon, size: AppConstants.buttonIconSize),
                )
              : OutlinedButton(
                  onPressed: onPressed,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppConstants.primary,
                    side: BorderSide(color: AppConstants.primary, width: AppConstants.buttonBorderWidth),
                    shape: const CircleBorder(),
                    padding: EdgeInsets.zero,
                  ),
                  child: Icon(icon, size: AppConstants.buttonIconSize),
                ),
        ),
        const SizedBox(height: AppConstants.paddingSmall),
        Flexible(
          child: Text(
            label,
            style: Theme.of(context).textTheme.labelLarge,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}