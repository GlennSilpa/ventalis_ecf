import 'dart:io';

import 'package:ecf_studi2/main.dart';
import 'package:ecf_studi2/users/authentication/login_screen.dart';
import 'package:ecf_studi2/users/fragments/Dashboard_of_fragments.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.setMockInitialValues({}); //set values here

  bool isEmailValid(String email) {
    // Regular expression pattern for email validation
    final pattern = r'^[\w-]+(\.[\w-]+)*@([a-zA-Z0-9-]+\.)+[a-zA-Z]{2,7}$';
    final regex = RegExp(pattern);

    return regex.hasMatch(email);
  }

  setUpAll(() {
    HttpOverrides.global = MyHttpOverrides();
  });

  group('Login Page', () {
    testWidgets('Verify material app built', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: LoginScreen()));

      expect(find.byType(MaterialApp), findsOneWidget);
    });

    testWidgets('Verify header in login screen', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: LoginScreen()));

      expect(find.byKey(Key('loginHeader')), findsOneWidget);
    });

    testWidgets('Verify email field exist', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: LoginScreen()));

      expect(find.byKey(Key('emailKey')), findsOneWidget);
    });

    testWidgets('Enter email in text field', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: LoginScreen()));

      final emailWidget = find.byKey(Key('emailKey'));

      await tester.enterText(emailWidget, 'test@gmail.com');
    });

    testWidgets('Email validation', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: LoginScreen()));

      final emailWidget = find.byKey(Key('emailKey'));

      await tester.enterText(emailWidget, 'test@gmail.com');

      expect(isEmailValid('luc@gmail.com'), true);

      expect(isEmailValid('lucgmail.com'), false);
    });

    testWidgets('Verify password field exist', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: LoginScreen()));

      expect(find.byKey(Key('passwordKey')), findsOneWidget);
    });

    testWidgets('Enter password in text field', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: LoginScreen()));

      final passwordWidget = find.byKey(Key('passwordKey'));

      await tester.enterText(passwordWidget, 'password');
    });

    testWidgets('Verify login button exist', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: LoginScreen()));

      expect(find.byKey(Key('loginButton')), findsOneWidget);
    });

    testWidgets('Verify login button text', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: LoginScreen()));

      expect(find.text('Se Connecter'), findsOneWidget);
    });

    testWidgets('Try to login user with wrong credentials',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: LoginScreen()));

      final emailWidget = find.byKey(Key('emailKey'));
      final passwordWidget = find.byKey(Key('passwordKey'));
      final loginButton = find.byKey(Key('loginButton'));

      await tester.enterText(emailWidget, 'luc@gmail.com');
      await tester.enterText(passwordWidget, 'password');

      await tester.tap(loginButton);

      await tester.pumpAndSettle();

      expect(find.byKey(Key("dashboardOfFragments")), findsNothing);
    });

    testWidgets('Try to login user with correct credentials',
        (WidgetTester tester) async {
      runApp(MainApp());
      await tester.pumpWidget(MaterialApp(home: LoginScreen()));

      final emailWidget = find.byKey(Key('emailKey'));
      final passwordWidget = find.byKey(Key('passwordKey'));
      final loginButton = find.byKey(Key('loginButton'));

      await tester.enterText(emailWidget, 'luc@gmail.com');
      await tester.enterText(passwordWidget, 'luc');

      await tester.tap(loginButton);
      await tester.pumpAndSettle(const Duration(seconds: 2));
    });

    testWidgets('Go to profile screen and check user profile data',
        (WidgetTester tester) async {
      runApp(MainApp());
      await tester.pumpWidget(MaterialApp(home: LoginScreen()));

      final emailWidget = find.byKey(Key('emailKey'));
      final passwordWidget = find.byKey(Key('passwordKey'));
      final loginButton = find.byKey(Key('loginButton'));

      await tester.enterText(emailWidget, 'luc@gmail.com');
      await tester.enterText(passwordWidget, 'luc');

      await tester.tap(loginButton);
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // check if the DashboardOfFragments is displayed by calling the widget class itself
      expect(find.byType(DashboardOfFragments), findsOneWidget);

      // click on the second navigation button
      expect(find.byIcon(Icons.person_2_outlined), findsOneWidget);
      await tester.tap(find.byIcon(Icons.person_2_outlined));

      await tester.pumpAndSettle();

      expect(find.byKey(Key("listViewProfile")), findsOneWidget);

      final username = find.byKey(Key('usernameKey'));

      expect(username, findsOneWidget);

      final usernameData = find.byKey(Key('usernameDataKey'));
      final usernameText = tester.widget<Text>(usernameData).data;
      expect(usernameText, equals('Luc'));

      final email = find.byKey(Key('emailKey'));

      expect(email, findsOneWidget);

      final emailData = find.byKey(Key('emailDataKey'));
      final emailDataText = tester.widget<Text>(emailData).data;
      expect(emailDataText, equals('luc@gmail.com'));
    });

    testWidgets('Go to profile screen and logout user',
        (WidgetTester tester) async {
      runApp(MainApp());
      await tester.pumpWidget(MaterialApp(home: LoginScreen()));

      final emailWidget = find.byKey(Key('emailKey'));
      final passwordWidget = find.byKey(Key('passwordKey'));
      final loginButton = find.byKey(Key('loginButton'));

      await tester.enterText(emailWidget, 'luc@gmail.com');
      await tester.enterText(passwordWidget, 'luc');

      await tester.tap(loginButton);
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // check if the DashboardOfFragments is displayed by calling the widget class itself
      expect(find.byType(DashboardOfFragments), findsOneWidget);

      // click on the second navigation button
      expect(find.byIcon(Icons.person_2_outlined), findsOneWidget);
      await tester.tap(find.byIcon(Icons.person_2_outlined));

      await tester.pumpAndSettle();

      expect(find.byKey(Key("listViewProfile")), findsOneWidget);

      final logoutButton = find.byKey(Key('logoutButton'));

      expect(logoutButton, findsOneWidget);

      await tester.tap(logoutButton);
      await tester.pumpAndSettle();

      expect(find.text('Déconnexion'), findsOneWidget);

      final ouiButton = find.text('Oui');
      expect(ouiButton, findsOneWidget);

      await tester.tap(ouiButton);

      await tester.pumpAndSettle();

      expect(find.byType(LoginScreen), findsWidgets);
    });
  });
}
