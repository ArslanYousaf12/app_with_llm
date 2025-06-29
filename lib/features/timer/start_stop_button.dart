import 'package:flutter/material.dart';
import '../../shared/widgets/timer_control_button.dart';

class StartStopButton extends StatelessWidget {
  final bool isRunning;
  final VoidCallback onPressed;

  const StartStopButton({
    super.key,
    required this.isRunning,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TimerControlButton(
      onPressed: onPressed,
      icon: isRunning ? Icons.pause : Icons.play_arrow,
      label: isRunning ? 'STOP' : 'START',
      isPrimary: !isRunning,
    );
  }
}