# Adapter

### 1. Red: Add The HTTP Adapter Test

Create the first adapter test file:

```bash
touch workspace/test/adapter/http_greeting_api_test.dart
just format
git add --all
git commit --message 'touch workspace/test/adapter/http_greeting_api_test.dart'
```

Put this exact content in `workspace/test/adapter/http_greeting_api_test.dart`:

```dart
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:saying_hello/adapter/http_greeting_api.dart';
import 'package:test/test.dart';

void main() {
  test('requests the canonical greeting endpoint', () async {
    final client = MockClient((request) async {
      expect(
        request.url.toString(),
        'http://localhost:25616/api/greeting?name=Ada',
      );

      return http.Response(jsonEncode({'message': 'Hello, Ada!'}), 200);
    });

    final api = HttpGreetingApi(
      baseUrl: 'http://localhost:25616',
      client: client,
    );
    final result = await api.getGreeting('Ada');

    expect(result.message, 'Hello, Ada!');
  });
}
```

Run:

```bash
just format
just check-all
git add --all
git commit --message "1. Red: Add The HTTP Adapter Test"
```

### 2. Green: Request The Canonical Greeting Endpoint

Create the first adapter production file:

```bash
touch workspace/lib/adapter/http_greeting_api.dart
just format
git add --all
git commit --message 'touch workspace/lib/adapter/http_greeting_api.dart'
```

Put this exact content in `workspace/lib/adapter/http_greeting_api.dart`:

```dart
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../contracts/greeting_api.dart';
import '../contracts/greeting_response.dart';

class HttpGreetingApi implements GreetingApi {
  final String baseUrl;
  final http.Client client;

  HttpGreetingApi({
    required this.baseUrl,
    http.Client? client,
  }) : client = client ?? http.Client();

  @override
  Future<GreetingResponse> getGreeting(String name) async {
    final trimmedName = name.trim();
    final uri =
        trimmedName.isEmpty
            ? Uri.parse('$baseUrl/api/greeting')
            : Uri.parse('$baseUrl/api/greeting?name=${Uri.encodeQueryComponent(trimmedName)}');

    final response = await client.get(uri);
    final json = jsonDecode(response.body) as Map<String, dynamic>;
    return GreetingResponse.fromJson(json);
  }
}
```

Run:

```bash
just format
just check-all
git add --all
git commit --message "2. Green: Request The Canonical Greeting Endpoint"
```

### 3. Red: Add The Greeting Page Widget Test

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
import 'package:saying_hello/contracts/greeting_api.dart';
import 'package:saying_hello/contracts/greeting_response.dart';

class MockGreetingApi extends Mock implements GreetingApi {}

void main() {
  testWidgets('renders the greeting returned by the API', (tester) async {
    final api = MockGreetingApi();
    when(
      () => api.getGreeting('Ada'),
    ).thenAnswer((_) async => const GreetingResponse(message: 'Hello, Ada!'));

    await tester.pumpWidget(
      MaterialApp(home: GreetingPage(api: api)),
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
git commit --message "3. Red: Add The Greeting Page Widget Test"
```

### 4. Green: Build The Greeting Page

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

import '../code/load_greeting.dart';
import '../contracts/greeting_api.dart';

class GreetingPage extends StatefulWidget {
  final GreetingApi api;

  const GreetingPage({super.key, required this.api});

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

  Future<void> _submit() async {
    final result = await loadGreeting(_controller.text, widget.api);
    setState(() {
      _message = result.message;
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
            Text(
              _message,
              key: const ValueKey('greeting-output'),
            ),
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
git commit --message "4. Green: Build The Greeting Page"
```

### 5. Red: Add The Integration Test

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
```

Run:

```bash
just format
just check-all
git add --all
git commit --message "5. Red: Add The Integration Test"
```

### 6. Green: Wire The Real Application

Replace `workspace/lib/main.dart` with:

```dart
import 'package:flutter/material.dart';

import 'adapter/greeting_page.dart';
import 'adapter/http_greeting_api.dart';

void main() {
  runApp(const SayingHelloApp());
}

class SayingHelloApp extends StatelessWidget {
  const SayingHelloApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Saying Hello',
      home: GreetingPage(
        api: HttpGreetingApi(baseUrl: 'http://localhost:25616'),
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
git commit --message "6. Green: Wire The Real Application"
```
