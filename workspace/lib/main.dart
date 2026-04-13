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
