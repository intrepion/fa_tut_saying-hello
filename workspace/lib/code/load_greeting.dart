import '../contracts/greeting_api.dart';

class GreetingViewModel {
  final String submittedName;
  final String message;

  const GreetingViewModel({required this.submittedName, required this.message});
}

Future<GreetingViewModel> loadGreeting(String name, GreetingApi api) async {
  final response = await api.getGreeting(name);

  return GreetingViewModel(submittedName: name, message: response.message);
}
