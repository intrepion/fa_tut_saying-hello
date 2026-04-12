import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:saying_hello/adapter/greeting_page.dart';
import 'package:saying_hello/contracts/greeting_api.dart';
import 'package:saying_hello/contracts/greeting_response.dart';

class MockGreetingApi extends Mock implements GreetingApi {}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('submits the form and shows the greeting', (tester) async {
    final api = MockGreetingApi();
    when(
      () => api.getGreeting('Ada'),
    ).thenAnswer((_) async => const GreetingResponse(message: 'Hello, Ada!'));

    await tester.pumpWidget(MaterialApp(home: GreetingPage(api: api)));
    await tester.enterText(find.byKey(const ValueKey('name-input')), 'Ada');
    await tester.tap(find.byKey(const ValueKey('submit-button')));
    await tester.pumpAndSettle();

    expect(find.text('Hello, Ada!'), findsOneWidget);
  });
}
