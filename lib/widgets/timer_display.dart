import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class TimerDisplay extends StatefulWidget {
  final Stopwatch stopwatch;

  const TimerDisplay({super.key, required this.stopwatch});

  @override
  State<TimerDisplay> createState() => _TimerDisplayState();
}

class _TimerDisplayState extends State<TimerDisplay>
    with TickerProviderStateMixin {
  late Ticker _ticker;

  @override
  void initState() {
    super.initState();
    _ticker = createTicker(_onTick);
    _ticker.start();
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  void _onTick(Duration elapsed) {
    if (widget.stopwatch.isRunning || mounted) {
      setState(() {});
    }
  }

  String _formatTime(Duration duration) {
    final totalSeconds = duration.inMilliseconds / 1000.0;
    return totalSeconds.toStringAsFixed(1);
  }

  @override
  Widget build(BuildContext context) {
    final elapsed = widget.stopwatch.elapsed;
    final formattedTime = _formatTime(elapsed);

    return Text(
      formattedTime,
      style: Theme.of(context).textTheme.displayLarge?.copyWith(
        fontSize: 120,
        fontWeight: FontWeight.bold,
        color: Theme.of(context).colorScheme.primary,
        fontFamily: 'BabasNeue',
      ),
    );
  }
}
