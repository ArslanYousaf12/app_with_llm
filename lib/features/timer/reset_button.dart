import 'package:flutter/material.dart';
import '../../shared/widgets/timer_control_button.dart';

class ResetButton extends StatelessWidget {
  final VoidCallback onPressed;

  const ResetButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TimerControlButton(
      onPressed: onPressed,
      icon: Icons.refresh,
      isPrimary: false,
    );
  }
}