# Contracts

Create the shared contract file:

```bash
touch workspace/lib/contracts/greeting_service.dart
just format
just check-all
git add --all
git commit --message 'touch workspace/lib/contracts/greeting_service.dart'
```

Put this exact content in `workspace/lib/contracts/greeting_service.dart`:

```dart
abstract class GreetingService {
  String greet(String name);
}
```

Do not add tests here. Keep this layer limited to interfaces and small shared types.

Then run:

```bash
just format
just check-all
git add --all
git commit --message "Define greeting service contract"
```
