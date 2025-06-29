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
    final totalSeconds = duration.inMilliseconds / 1000.0;
    return totalSeconds.toStringAsFixed(1);
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
        vertical: AppConstants.paddingXLarge * 2,
      ),
      decoration: BoxDecoration(
        color: AppConstants.brightGreen,
        borderRadius: BorderRadius.circular(AppConstants.paddingMedium),
      ),
      child: Center(
        child: Text(
          formattedTime,
          style: TextStyle(
            fontSize: AppConstants.timerDisplayFontSize,
            fontWeight: FontWeight.bold,
            color: AppConstants.textDark,
            fontFamily: 'BebasNeue',
          ),
        ),
      ),
    );
  }
}
