import 'package:flutter/material.dart';
import 'timer_display.dart';
import 'start_stop_button.dart';
import 'reset_button.dart';

class TimerPage extends StatefulWidget {
  const TimerPage({super.key});

  @override
  State<TimerPage> createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  final Stopwatch _stopwatch = Stopwatch();

  void _handleStartStop() {
    setState(() {
      if (_stopwatch.isRunning) {
        _stopwatch.stop();
      } else {
        _stopwatch.start();
      }
    });
  }

  void _handleReset() {
    setState(() {
      _stopwatch.reset();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('STOPWATCH'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: TimerDisplay(stopwatch: _stopwatch),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ResetButton(onPressed: _handleReset),
                  StartStopButton(
                    isRunning: _stopwatch.isRunning,
                    onPressed: _handleStartStop,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}