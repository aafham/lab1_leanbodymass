// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:lab1_leanbodymass/main.dart';

void main() {
  testWidgets('renders calculator form and actions', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Lean Body Mass Calculator'), findsOneWidget);
    expect(find.text('Height (cm)'), findsOneWidget);
    expect(find.text('Weight (kg)'), findsOneWidget);
    expect(find.text('Calculate'), findsOneWidget);
    expect(find.text('Clear'), findsOneWidget);
  });
}
