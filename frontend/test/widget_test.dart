import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:frontend/main.dart';
import 'package:frontend/features/home/home_screen.dart';
import 'package:frontend/profile_screen.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(Main());

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });

  testWidgets('HomeScreen displays buttons', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: HomeScreen()));

    // Verify that the HomeScreen displays the correct buttons.
    expect(find.text('Start a Workout'), findsOneWidget);
    expect(find.text('Plan a workout'), findsOneWidget);
  });

  testWidgets('ProfileScreen displays text', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: ProfileScreen()));

    // Verify that the ProfileScreen displays the correct text.
    expect(find.text('Profile Screen'), findsOneWidget);
  });

  testWidgets('Navigation to ProfileScreen works', (WidgetTester tester) async {
    await tester.pumpWidget(Main());

    // Tap the profile icon to navigate to the ProfileScreen.
    await tester.tap(find.byIcon(Icons.person));
    await tester.pumpAndSettle();

    // Verify that the ProfileScreen is displayed.
    expect(find.text('Profile Screen'), findsOneWidget);
  });

  testWidgets('HomeScreen button taps', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: HomeScreen()));

    // Verify that the buttons are initially disabled.
    final startButton = find.text('Start a Workout');
    final planButton = find.text('Plan a workout');
    expect(tester.widget<ElevatedButton>(startButton).enabled, false);
    expect(tester.widget<ElevatedButton>(planButton).enabled, false);
  });

  testWidgets('ProfileScreen state change', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: ProfileScreen()));

    // Verify initial state.
    expect(find.text('Profile Screen'), findsOneWidget);

    // Simulate a state change.
    final state = tester.state<ProfileScreenState>(find.byType(ProfileScreen));
    state.notifyListeners();
    await tester.pump();

    // Verify state change effect.
    expect(find.text('Profile Screen'), findsOneWidget);
  });

  testWidgets('MainLayout displays correct initial screen', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: MainLayout(currentIndex: 0, child: HomeScreen())));

    // Verify that the HomeScreen is displayed initially.
    expect(find.text('Start a Workout'), findsOneWidget);
    expect(find.text('Plan a workout'), findsOneWidget);
  });

  testWidgets('MainLayout navigation works', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: MainLayout(currentIndex: 0, child: HomeScreen())));

    // Tap the profile icon to navigate to the ProfileScreen.
    await tester.tap(find.byIcon(Icons.person));
    await tester.pumpAndSettle();

    // Verify that the ProfileScreen is displayed.
    expect(find.text('Profile Screen'), findsOneWidget);
  });

  testWidgets('ProfileScreen displays correct layout', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: ProfileScreen()));

    // Verify that the ProfileScreen displays the correct layout.
    expect(find.byType(Center), findsOneWidget);
    expect(find.text('Profile Screen'), findsOneWidget);
  });

  testWidgets('HomeScreen displays correct layout', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: HomeScreen()));

    // Verify that the HomeScreen displays the correct layout.
    expect(find.byType(Column), findsOneWidget);
    expect(find.text('Start a Workout'), findsOneWidget);
    expect(find.text('Plan a workout'), findsOneWidget);
  });
}
