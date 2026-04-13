# Adapter

### 1. Red: Add The Greeting Page Widget Test

Create the widget test file:

```bash
touch workspace/test/adapter/greeting_page_test.dart
just format
git add --all
git commit --message 'touch workspace/test/adapter/greeting_page_test.dart'
```

Put this exact content in `workspace/test/adapter/greeting_page_test.dart`:

```dart
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

    await tester.pumpWidget(
      MaterialApp(home: GreetingPage(service: service)),
    );

    await tester.enterText(find.byKey(const ValueKey('name-input')), 'Ada');
    await tester.tap(find.byKey(const ValueKey('submit-button')));
    await tester.pumpAndSettle();

    expect(find.text('Hello, Ada!'), findsOneWidget);
  });
}
```

Run:

```bash
just format
just check-all
git add --all
git commit --message "1. Red: Add The Greeting Page Widget Test"
```

### 2. Green: Build The Greeting Page

Create the greeting page file:

```bash
touch workspace/lib/adapter/greeting_page.dart
just format
git add --all
git commit --message 'touch workspace/lib/adapter/greeting_page.dart'
```

Put this exact content in `workspace/lib/adapter/greeting_page.dart`:

```dart
import 'package:flutter/material.dart';

import '../contracts/greeting_service.dart';

class GreetingPage extends StatefulWidget {
  final GreetingService service;

  const GreetingPage({super.key, required this.service});

  @override
  State<GreetingPage> createState() => _GreetingPageState();
}

class _GreetingPageState extends State<GreetingPage> {
  final _controller = TextEditingController();
  String _message = '';

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _submit() {
    final message = widget.service.greet(_controller.text);
    setState(() {
      _message = message;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Saying Hello')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              key: const ValueKey('name-input'),
              controller: _controller,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              key: const ValueKey('submit-button'),
              onPressed: _submit,
              child: const Text('Say hello'),
            ),
            const SizedBox(height: 12),
            Text(_message, key: const ValueKey('greeting-output')),
          ],
        ),
      ),
    );
  }
}
```

Run:

```bash
just format
just check-all
git add --all
git commit --message "2. Green: Build The Greeting Page"
```

### 3. Red: Add The Integration Test

Create the integration test file:

```bash
touch workspace/integration_test/app_test.dart
just format
git add --all
git commit --message 'touch workspace/integration_test/app_test.dart'
```

Put this exact content in `workspace/integration_test/app_test.dart`:

```dart
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
```

Run:

```bash
just format
just check-all
git add --all
git commit --message "3. Red: Add The Integration Test"
```

### 4. Green: Wire The Real Application

Replace `workspace/lib/main.dart` with:

```dart
import 'package:flutter/material.dart';

import 'adapter/greeting_page.dart';
import 'code/default_greeting_service.dart';

void main() {
  runApp(const SayingHelloApp());
}

class SayingHelloApp extends StatelessWidget {
  const SayingHelloApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Saying Hello',
      home: GreetingPage(service: DefaultGreetingService()),
    );
  }
}
```

Run:

```bash
just format
just check-all
git add --all
git commit --message "4. Green: Wire The Real Application"
```
