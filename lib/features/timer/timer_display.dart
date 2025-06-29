import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import '../../core/constants/app_constants.dart';

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
    _ticker = createTicker((_) => setState(() {}));
    _ticker.start();
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  String _formatTime(Duration duration) {
    final totalSeconds = duration.inMilliseconds / 1000.0;
    return totalSeconds.toStringAsFixed(1);
  }

  @override
  Widget build(BuildContext context) {
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
          _formatTime(widget.stopwatch.elapsed),
          style: Theme.of(context).textTheme.displayLarge,
        ),
      ),
    );
  }
}
