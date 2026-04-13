import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:saying_hello/adapter/greeting_page.dart';
import 'package:saying_hello/code/default_greeting_service.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('submits the form and shows the greeting', (tester) async {
    await tester.pumpWidget(
      MaterialApp(home: GreetingPage(service: DefaultGreetingService())),
    );
    await tester.enterText(find.byKey(const ValueKey('name-input')), 'Ada');
    await tester.tap(find.byKey(const ValueKey('submit-button')));
    await tester.pumpAndSettle();

    expect(find.text('Hello, Ada!'), findsOneWidget);
  });
}
