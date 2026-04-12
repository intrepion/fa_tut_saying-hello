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
        'http://localhost:25664/api/greeting?name=Ada',
      );

      return http.Response(jsonEncode({'message': 'Hello, Ada!'}), 200);
    });

    final api = HttpGreetingApi(
      baseUrl: 'http://localhost:25664',
      client: client,
    );
    final result = await api.getGreeting('Ada');

    expect(result.message, 'Hello, Ada!');
  });
}
