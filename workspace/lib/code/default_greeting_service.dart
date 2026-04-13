import '../contracts/greeting_service.dart';

class DefaultGreetingService implements GreetingService {
  @override
  String greet(String name) {
    final trimmedName = name.trim();
    return 'Hello, $trimmedName!';
  }
}
