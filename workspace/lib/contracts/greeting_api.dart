import 'greeting_response.dart';

abstract class GreetingApi {
  Future<GreetingResponse> getGreeting(String name);
}
