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

devices:
	(cd {{workspace}} && flutter devices)

emulators:
	(cd {{workspace}} && flutter emulators)

run device="":
	#!/usr/bin/env bash
	set -euo pipefail
	normalized_device='{{device}}'
	normalized_device="${normalized_device#\"}"
	normalized_device="${normalized_device%\"}"
	normalized_device="${normalized_device#device=}"
	if [ -n "$normalized_device" ]; then
	  (cd {{workspace}} && flutter run -d "$normalized_device")
	else
	  (cd {{workspace}} && flutter run)
	fi

check-all:
	just check-formatting
	just check-tests
