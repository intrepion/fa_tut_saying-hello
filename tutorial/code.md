# Code

### 1. Red: Add The First Failing Code Test

Create the first code test file:

```bash
touch workspace/test/code/default_greeting_service_test.dart
just format
git add --all
git commit --message 'touch workspace/test/code/default_greeting_service_test.dart'
```

Put this exact content in `workspace/test/code/default_greeting_service_test.dart`:

```dart
import 'package:saying_hello/code/default_greeting_service.dart';
import 'package:test/test.dart';

void main() {
  test('returns the personalized greeting for a non-empty name', () {
    final service = DefaultGreetingService();

    final result = service.greet('Ada');

    expect(result, 'Hello, Ada!');
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
touch workspace/lib/code/default_greeting_service.dart
just format
git add --all
git commit --message 'touch workspace/lib/code/default_greeting_service.dart'
```

Put this exact content in `workspace/lib/code/default_greeting_service.dart`:

```dart
import '../contracts/greeting_service.dart';

class DefaultGreetingService implements GreetingService {
  @override
  String greet(String name) {
    return 'Hello, $name!';
  }
}
```

Run:

```bash
just format
just check-all
git add --all
git commit --message "2. Green: Return The Personalized Greeting"
```

### 3. Red: Trim The Name Before Greeting

Replace `workspace/test/code/default_greeting_service_test.dart` with:

```dart
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
}
```

Run:

```bash
just format
just check-all
git add --all
git commit --message "3. Red: Trim The Name Before Greeting"
```

### 4. Green: Trim The Name Before Greeting

Replace `workspace/lib/code/default_greeting_service.dart` with:

```dart
import '../contracts/greeting_service.dart';

class DefaultGreetingService implements GreetingService {
  @override
  String greet(String name) {
    final trimmedName = name.trim();
    return 'Hello, $trimmedName!';
  }
}
```

Run:

```bash
just format
just check-all
git add --all
git commit --message "4. Green: Trim The Name Before Greeting"
```

### 5. Red: Return The Generic Greeting For Empty Input

Replace `workspace/test/code/default_greeting_service_test.dart` with:

```dart
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
```

Run:

```bash
just format
just check-all
git add --all
git commit --message "5. Red: Return The Generic Greeting For Empty Input"
```

### 6. Green: Return The Generic Greeting For Empty Input

Replace `workspace/lib/code/default_greeting_service.dart` with:

```dart
import '../contracts/greeting_service.dart';

class DefaultGreetingService implements GreetingService {
  @override
  String greet(String name) {
    final trimmedName = name.trim();
    if (trimmedName.isEmpty) {
      return 'Hello!';
    }

    return 'Hello, $trimmedName!';
  }
}
```

Run:

```bash
just format
just check-all
git add --all
git commit --message "6. Green: Return The Generic Greeting For Empty Input"
```
