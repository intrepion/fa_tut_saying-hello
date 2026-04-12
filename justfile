set shell := ["bash", "-eu", "-c"]

workspace := "workspace"

restore:
	npm --prefix {{workspace}} ci

format:
	npm --prefix {{workspace}} run format

check-formatting:
	npm --prefix {{workspace}} run check-formatting

check-tests:
	npm --prefix {{workspace}} run test

run:
	npm --prefix {{workspace}} run dev

check-all:
	just check-formatting
	just check-tests
