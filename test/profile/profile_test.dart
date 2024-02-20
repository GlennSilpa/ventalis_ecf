// unit & widget test for dashboard screen
import 'package:ecf_studi2/main.dart';
import 'package:ecf_studi2/users/fragments/profile_fragment_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("Profile test", () {
    testWidgets('Verify profile screen is displayed',
        (WidgetTester tester) async {
      runApp(MainApp());

      await tester.pumpWidget(MaterialApp(home: ProfileFragmentScreen()));
      // await tester.pump();
      // check if the dashboard of fragments is displayed using class name
      expect(find.byKey(Key("listViewProfile")), findsOneWidget);
      // check if the DashboardOfFragments is displayed by calling the widget class itself
      expect(find.byType(ProfileFragmentScreen), findsOneWidget);
    });

    testWidgets('Verify profile image', (WidgetTester tester) async {
      runApp(MainApp());

      await tester.pumpWidget(MaterialApp(home: ProfileFragmentScreen()));

      expect(find.byKey(Key("profileImage")), findsOneWidget);
    });

    testWidgets('Verify profile name', (WidgetTester tester) async {
      runApp(MainApp());

      await tester.pumpWidget(MaterialApp(home: ProfileFragmentScreen()));

      expect(find.byKey(Key("usernameKey")), findsOneWidget);
    });

    testWidgets('Verify profile email', (WidgetTester tester) async {
      runApp(MainApp());

      await tester.pumpWidget(MaterialApp(home: ProfileFragmentScreen()));

      expect(find.byKey(Key("emailKey")), findsOneWidget);
    });

    testWidgets('Verify logout Button', (WidgetTester tester) async {
      runApp(MainApp());

      await tester.pumpWidget(MaterialApp(home: ProfileFragmentScreen()));

      expect(find.byKey(Key("logoutButton")), findsOneWidget);
    });
  });
}
