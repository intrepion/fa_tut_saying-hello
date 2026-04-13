import 'package:saying_hello/code/default_greeting_service.dart';
import 'package:test/test.dart';

void main() {
  test('returns the personalized greeting for a non-empty name', () {
    final service = DefaultGreetingService();

    final result = service.greet('Ada');

    expect(result, 'Hello, Ada!');
  });
}
