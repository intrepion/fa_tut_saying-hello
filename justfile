set shell := ["bash", "-eu", "-c"]

workspace := "workspace"
solution := "SayingHello.sln"

format:
	cd {{workspace}} && dotnet format {{solution}}

check-formatting:
	cd {{workspace}} && dotnet format {{solution}} --verify-no-changes

check-tests:
	cd {{workspace}} && dotnet test {{solution}}

check-all:
	just check-formatting
	just check-tests
