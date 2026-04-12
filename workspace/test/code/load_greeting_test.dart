import 'package:mocktail/mocktail.dart';
import 'package:saying_hello/code/load_greeting.dart';
import 'package:saying_hello/contracts/greeting_api.dart';
import 'package:saying_hello/contracts/greeting_response.dart';
import 'package:test/test.dart';

class MockGreetingApi extends Mock implements GreetingApi {}

void main() {
  test('returns the personalized greeting for a non-empty name', () async {
    final api = MockGreetingApi();
    when(
      () => api.getGreeting('Ada'),
    ).thenAnswer((_) async => const GreetingResponse(message: 'Hello, Ada!'));

    final result = await loadGreeting('Ada', api);

    expect(result.submittedName, 'Ada');
    expect(result.message, 'Hello, Ada!');
  });

  test('trims the name before calling the API', () async {
    final api = MockGreetingApi();
    when(
      () => api.getGreeting('Ada'),
    ).thenAnswer((_) async => const GreetingResponse(message: 'Hello, Ada!'));

    final result = await loadGreeting('  Ada  ', api);

    expect(result.submittedName, 'Ada');
    expect(result.message, 'Hello, Ada!');
  });

  test('returns a friendly message when the API is unavailable', () async {
    final api = MockGreetingApi();
    when(() => api.getGreeting('Ada')).thenThrow(Exception('network error'));

    final result = await loadGreeting('Ada', api);

    expect(result.submittedName, 'Ada');
    expect(result.message, 'Sorry, the greeting API is unavailable right now.');
  });
}
