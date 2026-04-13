import '../contracts/greeting_api.dart';

class GreetingViewModel {
  final String submittedName;
  final String message;

  const GreetingViewModel({required this.submittedName, required this.message});
}

Future<GreetingViewModel> loadGreeting(String name, GreetingApi api) async {
  final submittedName = name.trim();

  try {
    final response = await api.getGreeting(submittedName);

    return GreetingViewModel(
      submittedName: submittedName,
      message: response.message,
    );
  } catch (_) {
    return GreetingViewModel(
      submittedName: submittedName,
      message: 'Sorry, the greeting API is unavailable right now.',
    );
  }
}
