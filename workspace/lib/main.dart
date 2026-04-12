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
        api: HttpGreetingApi(baseUrl: 'http://localhost:25664'),
      ),
    );
  }
}
