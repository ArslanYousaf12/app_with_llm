import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:app_with_llm/main.dart';
import 'package:app_with_llm/widgets/timer_display.dart';
import 'package:app_with_llm/widgets/control_buttons.dart';

void main() {
  group('Timer App Tests', () {
    testWidgets('App loads with initial timer display', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());

      // Verify initial timer display shows 0.0
      expect(find.text('0.0'), findsOneWidget);
      
      // Verify control buttons are present
      expect(find.text('Start'), findsOneWidget);
      expect(find.text('Reset'), findsOneWidget);
    });

    testWidgets('Start button changes to Stop when tapped', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());

      // Find and tap the start button
      final startButton = find.text('Start');
      expect(startButton, findsOneWidget);
      
      await tester.tap(startButton);
      await tester.pump();

      // Verify button text changes to Stop
      expect(find.text('Stop'), findsOneWidget);
      expect(find.text('Start'), findsNothing);
    });

    testWidgets('Timer display updates when running', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());

      // Start the timer
      await tester.tap(find.text('Start'));
      await tester.pump();

      // Advance time and pump frames
      await tester.pump(const Duration(milliseconds: 100));
      
      // Timer should no longer show 0.0
      expect(find.text('0.0'), findsNothing);
    });

    testWidgets('Reset button resets timer to 0.0', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());

      // Start timer
      await tester.tap(find.text('Start'));
      await tester.pump(const Duration(milliseconds: 100));

      // Reset timer
      await tester.tap(find.text('Reset'));
      await tester.pump();

      // Should show 0.0 and Start button
      expect(find.text('0.0'), findsOneWidget);
      expect(find.text('Start'), findsOneWidget);
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

  group('Control Buttons Widget Tests', () {
    testWidgets('ControlButtons displays correct text based on state', (WidgetTester tester) async {
      bool isRunning = false;
      int startStopCalls = 0;
      int resetCalls = 0;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ControlButtons(
              isRunning: isRunning,
              onStartStop: () => startStopCalls++,
              onReset: () => resetCalls++,
            ),
          ),
        ),
      );

      // Should show Start when not running
      expect(find.text('Start'), findsOneWidget);
      expect(find.text('Reset'), findsOneWidget);

      // Tap start button
      await tester.tap(find.text('Start'));
      expect(startStopCalls, equals(1));

      // Test with running state
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ControlButtons(
              isRunning: true,
              onStartStop: () => startStopCalls++,
              onReset: () => resetCalls++,
            ),
          ),
        ),
      );

      // Should show Stop when running
      expect(find.text('Stop'), findsOneWidget);
    });
  });
}
