import 'dart:convert';

import 'package:http/http.dart' as http;

import '../contracts/greeting_api.dart';
import '../contracts/greeting_response.dart';

class HttpGreetingApi implements GreetingApi {
  final String baseUrl;
  final http.Client client;

  HttpGreetingApi({required this.baseUrl, http.Client? client})
    : client = client ?? http.Client();

  @override
  Future<GreetingResponse> getGreeting(String name) async {
    final trimmedName = name.trim();
    final uri = trimmedName.isEmpty
        ? Uri.parse('$baseUrl/api/greeting')
        : Uri.parse(
            '$baseUrl/api/greeting?name=${Uri.encodeQueryComponent(trimmedName)}',
          );

    final response = await client.get(uri);
    final json = jsonDecode(response.body) as Map<String, dynamic>;
    return GreetingResponse.fromJson(json);
  }
}
