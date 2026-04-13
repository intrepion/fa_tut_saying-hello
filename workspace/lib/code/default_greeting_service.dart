import '../contracts/greeting_service.dart';

class DefaultGreetingService implements GreetingService {
  @override
  String greet(String name) {
    final trimmedName = name.trim();
    if (trimmedName.isEmpty) {
      return 'Hello!';
    }

    return 'Hello, $trimmedName!';
  }
}
