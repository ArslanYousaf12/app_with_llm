import 'package:flutter/material.dart';

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
        // Start/Stop button styled like iOS stopwatch
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isRunning 
                ? Colors.red.shade600 
                : Colors.green.shade600,
            border: Border.all(
              color: isRunning 
                  ? Colors.red.shade400 
                  : Colors.green.shade400,
              width: 3,
            ),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(40),
              onTap: onStartStop,
              child: Center(
                child: Text(
                  isRunning ? 'Stop' : 'Start',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ),
        
        // Reset button
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.grey.shade700,
            border: Border.all(
              color: Colors.grey.shade500,
              width: 3,
            ),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(40),
              onTap: onReset,
              child: Center(
                child: Text(
                  'Reset',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}