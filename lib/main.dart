import 'package:flutter/material.dart';
import 'screens/timer_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Voice Timer',
      theme: ThemeData.dark().copyWith(
        colorScheme: ColorScheme.dark(
          primary: Colors.blue.shade400,
          secondary: Colors.blueAccent,
          surface: Colors.grey.shade900,
          background: Colors.black,
        ),
        useMaterial3: true,
      ),
      home: const TimerPage(),
    );
  }
}

