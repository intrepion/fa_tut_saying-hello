import 'package:flutter/material.dart';

import 'adapter/greeting_page.dart';
import 'adapter/http_greeting_api.dart';

const apiBaseUrl = String.fromEnvironment(
  'API_BASE_URL',
  defaultValue: 'http://localhost:25664',
);

void main() {
  runApp(const SayingHelloApp());
}

class SayingHelloApp extends StatelessWidget {
  const SayingHelloApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Saying Hello',
      home: GreetingPage(api: HttpGreetingApi(baseUrl: apiBaseUrl)),
    );
  }
}
