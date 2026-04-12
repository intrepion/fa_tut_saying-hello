# Contracts

Create the shared contract files:

```bash
touch workspace/lib/contracts/greeting_response.dart
just format
just check-all
git add --all
git commit --message 'touch workspace/lib/contracts/greeting_response.dart'
touch workspace/lib/contracts/greeting_api.dart
just format
git add --all
git commit --message 'touch workspace/lib/contracts/greeting_api.dart'
```

Put this exact content in `workspace/lib/contracts/greeting_response.dart`:

```dart
class GreetingResponse {
  final String message;

  const GreetingResponse({required this.message});

  factory GreetingResponse.fromJson(Map<String, dynamic> json) {
    return GreetingResponse(message: json['message'] as String);
  }
}
```

Put this exact content in `workspace/lib/contracts/greeting_api.dart`:

```dart
import 'greeting_response.dart';

abstract class GreetingApi {
  Future<GreetingResponse> getGreeting(String name);
}
```

Do not add tests here. Keep this layer limited to interfaces and small shared types.

Then run:

```bash
just format
just check-all
git add --all
git commit --message "Define greeting contracts"
```
