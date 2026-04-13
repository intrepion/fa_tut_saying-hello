# Finish

Make sure the matching Saying Hello API is running on your development machine at port `25664`.

Then start the Flutter mobile app from the repository root:

```bash
just run
```

If you want to target a specific device, use:

```bash
just run device="<device-id-or-name>"
```

If you are running on Android and need to reach the host machine, use:

```bash
just --set api_base_url http://10.0.2.2:25664 run device="<android-device-id-or-name>"
```

After the first successful iOS run, commit shared CocoaPods project files if they appear in `git status`:

- `workspace/ios/Runner.xcodeproj/project.pbxproj`
- `workspace/ios/Runner.xcworkspace/contents.xcworkspacedata`
- `workspace/ios/Podfile.lock`

A normal Android run usually should not add shared tracked files. Do not commit machine-specific files like `workspace/android/local.properties`, `workspace/.gradle/`, or `workspace/build/`.

Try these inputs:

- enter `Ada` and expect `Hello, Ada!`
- submit an empty value and expect `Hello!`

If the API is unavailable, the app should show `Sorry, the greeting API is unavailable right now.`
