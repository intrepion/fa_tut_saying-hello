import 'package:saying_hello/code/default_greeting_service.dart';
import 'package:test/test.dart';

void main() {
  test('returns the personalized greeting for a non-empty name', () {
    final service = DefaultGreetingService();

    final result = service.greet('Ada');

    expect(result, 'Hello, Ada!');
  });

  test('trims whitespace before greeting', () {
    final service = DefaultGreetingService();

    final result = service.greet('  Ada  ');

    expect(result, 'Hello, Ada!');
  });

  test('returns the generic greeting for empty input', () {
    final service = DefaultGreetingService();

    final result = service.greet('');

    expect(result, 'Hello!');
  });

  test('returns the generic greeting for whitespace-only input', () {
    final service = DefaultGreetingService();

    final result = service.greet('   ');

    expect(result, 'Hello!');
  });
}
