# Finish

For web, start the Flutter app from the repository root with:

```bash
just run
```

or:

```bash
just run-web
```

Then open `http://localhost:25616` in your browser.

For iOS, use:

```bash
just run-ios
```

or target a specific simulator:

```bash
just run-ios device="<ios-device-id-or-name>"
```

For Android, use:

```bash
just run-android device="<android-device-id-or-name>"
```

For macOS desktop, use:

```bash
just run-macos
```

For Windows or Linux, run the matching command on that host platform:

```bash
just run-windows
just run-linux
```

After the first successful iOS run, if CocoaPods added shared iOS project files like these:

- `workspace/ios/Runner.xcodeproj/project.pbxproj`
- `workspace/ios/Runner.xcworkspace/contents.xcworkspacedata`
- `workspace/ios/Podfile.lock`

then run:

```bash
git add --all
git commit --message "Add iOS CocoaPods workspace files"
```

A normal Android run usually should not add shared tracked files. Do not commit machine-specific files like `workspace/android/local.properties`, `workspace/.gradle/`, or `workspace/build/`.

Try these inputs:

- enter `Ada` and expect `Hello, Ada!`
- submit an empty value and expect `Hello!`
