import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:saying_hello/adapter/greeting_page.dart';
import 'package:saying_hello/contracts/greeting_service.dart';

class MockGreetingService extends Mock implements GreetingService {}

void main() {
  testWidgets('renders the greeting returned by the service', (tester) async {
    final service = MockGreetingService();
    when(() => service.greet('Ada')).thenReturn('Hello, Ada!');

    await tester.pumpWidget(MaterialApp(home: GreetingPage(service: service)));

    await tester.enterText(find.byKey(const ValueKey('name-input')), 'Ada');
    await tester.tap(find.byKey(const ValueKey('submit-button')));
    await tester.pumpAndSettle();

    expect(find.text('Hello, Ada!'), findsOneWidget);
  });
}
