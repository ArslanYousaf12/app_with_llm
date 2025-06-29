import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:app_with_llm/main.dart';
import 'package:app_with_llm/features/timer/timer_display.dart';
import 'package:app_with_llm/features/timer/start_stop_button.dart';
import 'package:app_with_llm/features/timer/reset_button.dart';

void main() {
  group('Timer App Tests', () {
    testWidgets('App loads with initial timer display', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());

      // Verify initial timer display shows 0.0
      expect(find.text('0.0'), findsOneWidget);
      
      // Verify control buttons are present
      expect(find.text('START'), findsOneWidget);
      expect(find.text('RESET'), findsOneWidget);
    });

    testWidgets('Start button changes to Stop when tapped', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());

      // Find and tap the start button
      final startButton = find.text('START');
      expect(startButton, findsOneWidget);
      
      await tester.tap(startButton);
      await tester.pump();

      // Verify button text changes to STOP
      expect(find.text('STOP'), findsOneWidget);
      expect(find.text('START'), findsNothing);
    });

    testWidgets('Timer display updates when running', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());

      // Start the timer
      await tester.tap(find.text('START'));
      await tester.pump();

      // Advance time and pump frames
      await tester.pump(const Duration(milliseconds: 100));
      
      // Timer should no longer show 0.0
      expect(find.text('0.0'), findsNothing);
    });

    testWidgets('Reset button resets timer to 0.0', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());

      // Start timer
      await tester.tap(find.text('START'));
      await tester.pump(const Duration(milliseconds: 100));

      // Reset timer
      await tester.tap(find.text('RESET'));
      await tester.pump();

      // Should show 0.0 and START button
      expect(find.text('0.0'), findsOneWidget);
      expect(find.text('START'), findsOneWidget);
    });
  });

  group('Timer Display Widget Tests', () {
    testWidgets('TimerDisplay shows formatted time', (WidgetTester tester) async {
      final stopwatch = Stopwatch();
      
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TimerDisplay(stopwatch: stopwatch),
          ),
        ),
      );

      // Should show 0.0 initially
      expect(find.text('0.0'), findsOneWidget);
    });
  });

  group('Voice Indicator Tests', () {
    testWidgets('VoiceIndicator shows appropriate status', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());

      // Should show voice indicator at bottom
      expect(find.text('VOICE DISABLED'), findsOneWidget);
      
      // Should show microphone icon
      expect(find.byIcon(Icons.mic_off), findsOneWidget);
    });
  });
}
