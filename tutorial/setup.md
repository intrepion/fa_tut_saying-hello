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

(cd workspace && flutter pub add http)
just format
git add --all
git commit --message "(cd workspace && flutter pub add http)"

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
      greeting_api.dart
      greeting_response.dart
    code/
      load_greeting.dart
    adapter/
      http_greeting_api.dart
      greeting_page.dart
  test/
    code/
      load_greeting_test.dart
    adapter/
      http_greeting_api_test.dart
      greeting_page_test.dart
  integration_test/
    app_test.dart
  lib/main.dart
```

Before you try `just run`, make sure Flutter can see a supported mobile device.

On macOS for iOS, install CocoaPods first if you have not already:

```bash
sudo gem install cocoapods
```

Then open the simulator and list devices:

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

After your first successful iOS run, check `git status`. If CocoaPods added shared iOS project files like these, commit them:

- `workspace/ios/Runner.xcodeproj/project.pbxproj`
- `workspace/ios/Runner.xcworkspace/contents.xcworkspacedata`
- `workspace/ios/Podfile.lock`

Do not commit local machine output like these:

- `workspace/ios/Pods/`
- `workspace/build/`
- `workspace/.dart_tool/`

For Android, a normal first run usually should not add shared tracked files. If it does change shared files under `workspace/android/`, review them carefully and commit only the project-level changes. Do not commit machine-specific files like:

- `workspace/android/local.properties`
- `workspace/.gradle/`
- `workspace/build/`
