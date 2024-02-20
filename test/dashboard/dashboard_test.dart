// widget test for dashboard screen
import 'package:ecf_studi2/main.dart';
import 'package:ecf_studi2/users/fragments/Dashboard_of_fragments.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("Dashboard test", () {
    testWidgets('Verify dashboard of fragments is displayed',
        (WidgetTester tester) async {
      runApp(MainApp());

      await tester.pumpWidget(MaterialApp(home: DashboardOfFragments()));
      // await tester.pump();
      // check if the dashboard of fragments is displayed using class name
      expect(find.byKey(Key("dashboardOfFragments")), findsOneWidget);
      // check if the DashboardOfFragments is displayed by calling the widget class itself
      expect(find.byType(DashboardOfFragments), findsOneWidget);
    });

    testWidgets('Verify bottom navigation bar is displayed',
        (WidgetTester tester) async {
      runApp(MainApp());

      await tester.pumpWidget(MaterialApp(home: DashboardOfFragments()));
      // await tester.pump();
      // check if the dashboard of fragments is displayed using class name
      expect(find.byKey(Key("bottomNavigationBar")), findsOneWidget);
      // check if the DashboardOfFragments is displayed by calling the widget class itself
      expect(find.byType(DashboardOfFragments), findsOneWidget);
    });

    testWidgets('Find and Click on the second item in navigation bar',
        (tester) async {
      runApp(MainApp());

      await tester.pumpWidget(MaterialApp(home: DashboardOfFragments()));

      // click on the second navigation button
      expect(find.byIcon(Icons.person_2_outlined), findsOneWidget);
      await tester.tap(find.byIcon(Icons.person_2_outlined));
      await tester.pumpAndSettle();
    });
  });
}
