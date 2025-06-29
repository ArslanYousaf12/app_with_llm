import 'package:flutter/material.dart';
import 'features/timer/timer_page.dart';
import 'core/theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Voice Timer',
      theme: AppTheme.themeData,
      home: const TimerPage(),
    );
  }
}
