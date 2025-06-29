import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import '../core/constants/app_constants.dart';

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
    final totalSeconds = duration.inSeconds;
    final minutes = totalSeconds ~/ 60;
    final seconds = totalSeconds % 60;
    final milliseconds = duration.inMilliseconds % 1000;
    final tenths = (milliseconds / 100).floor();
    
    return '$minutes:${seconds.toString().padLeft(2, '0')}.$tenths';
  }

  @override
  Widget build(BuildContext context) {
    final elapsed = widget.stopwatch.elapsed;
    final formattedTime = _formatTime(elapsed);

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(AppConstants.paddingMedium),
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstants.paddingLarge,
        vertical: AppConstants.paddingLarge * 2,
      ),
      decoration: BoxDecoration(
        color: AppConstants.primary,
        borderRadius: BorderRadius.circular(AppConstants.paddingMedium),
      ),
      child: Center(
        child: Text(
          formattedTime,
          style: Theme.of(context).textTheme.displayLarge,
        ),
      ),
    );
  }
}
