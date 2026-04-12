# Setup

Keep the repository root for shared files like `README.md`, `LICENSE`, `.gitignore`, `.github/`, `justfile`, and `tutorial/`.

Put all Flutter code inside a single `workspace/` folder.

From the repository root, run each setup command and checkpoint it before moving to the next one:

```bash
flutter create --platforms=android,ios --org com.intrepion --project-name saying_hello workspace
git add --all
git commit --message "flutter create --platforms=android,ios --org com.intrepion --project-name saying_hello workspace"

rm workspace/test/widget_test.dart
just format
git add --all
git commit --message "rm workspace/test/widget_test.dart"

mkdir -p workspace/integration_test
just format
git add --all
git commit --message "mkdir -p workspace/integration_test"

mkdir -p workspace/lib/contracts
just format
git add --all
git commit --message "mkdir -p workspace/lib/contracts"

mkdir -p workspace/lib/code
just format
git add --all
git commit --message "mkdir -p workspace/lib/code"

mkdir -p workspace/lib/adapter
just format
git add --all
git commit --message "mkdir -p workspace/lib/adapter"

mkdir -p workspace/test/code
just format
git add --all
git commit --message "mkdir -p workspace/test/code"

mkdir -p workspace/test/adapter
just format
git add --all
git commit --message "mkdir -p workspace/test/adapter"

(cd workspace && flutter pub add --dev test)
just format
git add --all
git commit --message "(cd workspace && flutter pub add --dev test)"

(cd workspace && flutter pub add --dev mocktail)
just format
git add --all
git commit --message "(cd workspace && flutter pub add --dev mocktail)"

(cd workspace && flutter pub add --dev integration_test --sdk flutter)
just format
git add --all
git commit --message "(cd workspace && flutter pub add --dev integration_test --sdk flutter)"
```

When the full workspace is finished, it should contain these files:

```text
workspace/
  pubspec.yaml
  lib/
    contracts/
      greeting_service.dart
    code/
      default_greeting_service.dart
    adapter/
      greeting_page.dart
  test/
    code/
      default_greeting_service_test.dart
    adapter/
      greeting_page_test.dart
  integration_test/
    app_test.dart
  lib/main.dart
```

Before you try `just run`, make sure Flutter can see a supported mobile device.

On macOS for iOS, open the simulator and then list devices:

```bash
open -a Simulator
just devices
```

For Android, list available emulators, launch one, and then list devices again:

```bash
just emulators
flutter emulators --launch <emulator-id>
just devices
```

Once `just devices` shows a supported iOS simulator or Android emulator, run the app with:

```bash
just run
```

If you want to target a specific device id or name, use:

```bash
just run device="<device-id-or-name>"
```
