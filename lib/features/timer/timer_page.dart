import 'package:flutter/material.dart';
import 'timer_display.dart';
import 'start_stop_button.dart';
import 'reset_button.dart';
import '../../widgets/voice_indicator.dart';
import '../../services/permission_service.dart';

class TimerPage extends StatefulWidget {
  const TimerPage({super.key});

  @override
  State<TimerPage> createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  final Stopwatch _stopwatch = Stopwatch();
  bool _permissionsGranted = false;

  @override
  void initState() {
    super.initState();
    _requestPermissions();
  }

  Future<void> _requestPermissions() async {
    final granted = await PermissionService.requestPermissions();
    setState(() {
      _permissionsGranted = granted;
    });

    if (!granted && mounted) {
      await PermissionService.showPermissionDialog(context);
    }
  }

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
        leading: IconButton(
          icon: const Icon(Icons.settings, color: Colors.white),
          onPressed: () {
            // TODO: Navigate to settings page
          },
        ),
        title: const Text('STOPWATCH'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(flex: 7, child: TimerDisplay(stopwatch: _stopwatch)),
          SizedBox(height: 80),
          Expanded(
            flex: 2,
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
          // Voice indicator at the bottom
          VoiceIndicator(
            isListening: _stopwatch.isRunning,
            status: 'LISTENING',
            confidence: 0.99,
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
