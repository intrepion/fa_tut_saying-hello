import '../contracts/greeting_service.dart';

class DefaultGreetingService implements GreetingService {
  @override
  String greet(String name) {
    return 'Hello, $name!';
  }
}
