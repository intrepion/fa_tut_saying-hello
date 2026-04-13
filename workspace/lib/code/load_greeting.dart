import '../contracts/greeting_api.dart';

class GreetingViewModel {
  final String submittedName;
  final String message;

  const GreetingViewModel({required this.submittedName, required this.message});
}

Future<GreetingViewModel> loadGreeting(String name, GreetingApi api) async {
  final submittedName = name.trim();
  final response = await api.getGreeting(submittedName);

  return GreetingViewModel(
    submittedName: submittedName,
    message: response.message,
  );
}
