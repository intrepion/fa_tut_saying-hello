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
