# Code

### 1. Red: Add The First Failing Code Test

Create the first code test file:

```bash
touch workspace/test/code/load_greeting_test.dart
just format
git add --all
git commit --message 'touch workspace/test/code/load_greeting_test.dart'
```

Put this exact content in `workspace/test/code/load_greeting_test.dart`:

```dart
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
}
```

Run:

```bash
just format
just check-all
git add --all
git commit --message "1. Red: Add The First Failing Code Test"
```

### 2. Green: Return The Personalized Greeting

Create the first production file:

```bash
touch workspace/lib/code/load_greeting.dart
just format
git add --all
git commit --message 'touch workspace/lib/code/load_greeting.dart'
```

Put this exact content in `workspace/lib/code/load_greeting.dart`:

```dart
import '../contracts/greeting_api.dart';

class GreetingViewModel {
  final String submittedName;
  final String message;

  const GreetingViewModel({
    required this.submittedName,
    required this.message,
  });
}

Future<GreetingViewModel> loadGreeting(String name, GreetingApi api) async {
  final response = await api.getGreeting(name);

  return GreetingViewModel(
    submittedName: name,
    message: response.message,
  );
}
```

Run:

```bash
just format
just check-all
git add --all
git commit --message "2. Green: Return The Personalized Greeting"
```

### 3. Red: Trim The Name Before Calling The API

Replace `workspace/test/code/load_greeting_test.dart` with:

```dart
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
}
```

Run:

```bash
just format
just check-all
git add --all
git commit --message "3. Red: Trim The Name Before Calling The API"
```

### 4. Green: Trim The Name Before Calling The API

Replace `workspace/lib/code/load_greeting.dart` with:

```dart
import '../contracts/greeting_api.dart';

class GreetingViewModel {
  final String submittedName;
  final String message;

  const GreetingViewModel({
    required this.submittedName,
    required this.message,
  });
}

Future<GreetingViewModel> loadGreeting(String name, GreetingApi api) async {
  final submittedName = name.trim();
  final response = await api.getGreeting(submittedName);

  return GreetingViewModel(
    submittedName: submittedName,
    message: response.message,
  );
}
```

Run:

```bash
just format
just check-all
git add --all
git commit --message "4. Green: Trim The Name Before Calling The API"
```

### 5. Red: Return A Friendly Message When The API Is Unavailable

Replace `workspace/test/code/load_greeting_test.dart` with:

```dart
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
```

Run:

```bash
just format
just check-all
git add --all
git commit --message "5. Red: Return A Friendly Message When The API Is Unavailable"
```

### 6. Green: Return A Friendly Message When The API Is Unavailable

Replace `workspace/lib/code/load_greeting.dart` with:

```dart
import '../contracts/greeting_api.dart';

class GreetingViewModel {
  final String submittedName;
  final String message;

  const GreetingViewModel({
    required this.submittedName,
    required this.message,
  });
}

Future<GreetingViewModel> loadGreeting(String name, GreetingApi api) async {
  final submittedName = name.trim();

  try {
    final response = await api.getGreeting(submittedName);

    return GreetingViewModel(
      submittedName: submittedName,
      message: response.message,
    );
  } catch (_) {
    return GreetingViewModel(
      submittedName: submittedName,
      message: 'Sorry, the greeting API is unavailable right now.',
    );
  }
}
```

Run:

```bash
just format
just check-all
git add --all
git commit --message "6. Green: Return A Friendly Message When The API Is Unavailable"
```
