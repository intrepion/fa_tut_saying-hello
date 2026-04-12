set shell := ["bash", "-eu", "-c"]

workspace := "workspace"

restore:
	(cd {{workspace}} && flutter pub get)

format:
	(cd {{workspace}} && dart format lib test integration_test)

check-formatting:
	(cd {{workspace}} && dart format --output=none --set-exit-if-changed lib test integration_test)

check-tests:
	(cd {{workspace}} && flutter test)

run:
	(cd {{workspace}} && flutter run -d chrome --web-port 25616)

check-all:
	just check-formatting
	just check-tests
