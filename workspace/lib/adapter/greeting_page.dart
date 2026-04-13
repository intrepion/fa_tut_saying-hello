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
            Text(_message, key: const ValueKey('greeting-output')),
          ],
        ),
      ),
    );
  }
}
