set shell := ["bash", "-eu", "-c"]

workspace := "workspace"
solution := "SayingHello.sln"
adapter_project := "workspace/src/SayingHello.CommandLine"

restore:
	dotnet restore {{workspace}}/{{solution}}

format:
	dotnet format {{workspace}}/{{solution}}

check-formatting:
	dotnet format {{workspace}}/{{solution}} --verify-no-changes

check-tests:
	dotnet test {{workspace}}/{{solution}}

run *args:
	dotnet run --project {{adapter_project}} -- {{args}}

check-all:
	just check-formatting
	just check-tests
