import 'package:flutter/material.dart';

class TimerControlButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;
  final bool isPrimary;

  const TimerControlButton({
    super.key,
    required this.onPressed,
    required this.icon,
    this.isPrimary = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 80,
      height: 80,
      child: isPrimary
          ? ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.black,
                shape: const CircleBorder(),
                padding: EdgeInsets.zero,
              ),
              child: Icon(icon, size: 32),
            )
          : OutlinedButton(
              onPressed: onPressed,
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.white,
                side: const BorderSide(color: Colors.white, width: 2),
                shape: const CircleBorder(),
                padding: EdgeInsets.zero,
              ),
              child: Icon(icon, size: 32),
            ),
    );
  }
}