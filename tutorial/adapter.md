# Adapter

Create the adapter library and its test library inside `workspace/`.

Both the adapter library and the adapter test library should reference the contracts library. The adapter library should also reference the code library.

From the repository root, run:

```bash
dotnet new console --language C# --output workspace/src/SayingHello.CommandLine --name SayingHello.CommandLine
dotnet new xunit --language C# --output workspace/tests/SayingHello.CommandLine.Tests --name SayingHello.CommandLine.Tests
dotnet sln workspace/SayingHello.sln add workspace/src/SayingHello.CommandLine/SayingHello.CommandLine.csproj
dotnet sln workspace/SayingHello.sln add workspace/tests/SayingHello.CommandLine.Tests/SayingHello.CommandLine.Tests.csproj
dotnet add workspace/src/SayingHello.CommandLine/SayingHello.CommandLine.csproj reference workspace/src/SayingHello.Contracts/SayingHello.Contracts.csproj
dotnet add workspace/tests/SayingHello.CommandLine.Tests/SayingHello.CommandLine.Tests.csproj reference workspace/src/SayingHello.Contracts/SayingHello.Contracts.csproj
dotnet add workspace/src/SayingHello.CommandLine/SayingHello.CommandLine.csproj reference workspace/src/SayingHello/SayingHello.csproj
dotnet add workspace/tests/SayingHello.CommandLine.Tests/SayingHello.CommandLine.Tests.csproj reference workspace/src/SayingHello.CommandLine/SayingHello.CommandLine.csproj
```

After those commands finish, stay in the repository root and continue with the rest of this file.

### Replace The Template Files

From the repo root, remove the placeholder files that `dotnet new` created:

```bash
rm workspace/src/SayingHello.CommandLine/Program.cs
rm workspace/tests/SayingHello.CommandLine.Tests/UnitTest1.cs
```

Create the replacement files now:

```bash
touch workspace/src/SayingHello.CommandLine/CommandLineGreeting.cs
touch workspace/src/SayingHello.CommandLine/Program.cs
touch workspace/tests/SayingHello.CommandLine.Tests/CommandLineGreetingTests.cs
```

Add NSubstitute to the adapter test project:

```bash
dotnet add workspace/tests/SayingHello.CommandLine.Tests/SayingHello.CommandLine.Tests.csproj package NSubstitute
```

### 1. Red: Add The First Failing Adapter Test

Create `workspace/tests/SayingHello.CommandLine.Tests/CommandLineGreetingTests.cs` with this exact code:

```csharp
using NSubstitute;
using SayingHello.CommandLine;
using SayingHello.Contracts;
using Xunit;

namespace SayingHello.CommandLine.Tests;

public sealed class CommandLineGreetingTests
{
    [Fact]
    public void Build_message_delegates_to_greeting_service_for_first_argument()
    {
        var greetingService = Substitute.For<IGreetingService>();
        greetingService.Greet("Ada").Returns("Hello, Ada!");
        var sut = new CommandLineGreeting(greetingService);

        var result = sut.BuildMessage(["Ada"]);

        Assert.Equal("Hello, Ada!", result);
        greetingService.Received(1).Greet("Ada");
    }
}
```

Run:

```bash
just check-tests
git add -A
git commit -m "1. Red: Add The First Failing Adapter Test"
```

This should fail because `CommandLineGreeting` does not exist yet.

### 2. Green: Add The Thinnest Adapter Code

Create `workspace/src/SayingHello.CommandLine/CommandLineGreeting.cs` with this exact code:

```csharp
using SayingHello.Contracts;

namespace SayingHello.CommandLine;

public sealed class CommandLineGreeting(IGreetingService greetingService)
{
    private readonly IGreetingService _greetingService = greetingService;

    public string BuildMessage(string[] args)
    {
        return _greetingService.Greet(args[0]);
    }
}
```

Create `workspace/src/SayingHello.CommandLine/Program.cs` with this exact code:

```csharp
using SayingHello;
using SayingHello.CommandLine;

var greetingService = new GreetingService();
var adapter = new CommandLineGreeting(greetingService);

Console.WriteLine(adapter.BuildMessage(args));
```

Run:

```bash
just check-tests
git add -A
git commit -m "2. Green: Add The Thinnest Adapter Code"
```

This should pass.

### 3. Red: Add The No-Arguments Test

Replace `workspace/tests/SayingHello.CommandLine.Tests/CommandLineGreetingTests.cs` with this exact code:

```csharp
using NSubstitute;
using SayingHello.CommandLine;
using SayingHello.Contracts;
using Xunit;

namespace SayingHello.CommandLine.Tests;

public sealed class CommandLineGreetingTests
{
    [Fact]
    public void Build_message_delegates_to_greeting_service_for_first_argument()
    {
        var greetingService = Substitute.For<IGreetingService>();
        greetingService.Greet("Ada").Returns("Hello, Ada!");
        var sut = new CommandLineGreeting(greetingService);

        var result = sut.BuildMessage(["Ada"]);

        Assert.Equal("Hello, Ada!", result);
        greetingService.Received(1).Greet("Ada");
    }

    [Fact]
    public void Build_message_returns_generic_greeting_when_no_arguments_are_present()
    {
        var greetingService = Substitute.For<IGreetingService>();
        greetingService.Greet("").Returns("Hello!");
        var sut = new CommandLineGreeting(greetingService);

        var result = sut.BuildMessage([]);

        Assert.Equal("Hello!", result);
        greetingService.Received(1).Greet("");
    }
}
```

Run:

```bash
just check-tests
git add -A
git commit -m "3. Red: Add The No-Arguments Test"
```

This should fail because `BuildMessage` indexes into an empty array.

### 4. Green: Handle The Empty Argument List

Replace `workspace/src/SayingHello.CommandLine/CommandLineGreeting.cs` with this exact code:

```csharp
using SayingHello.Contracts;

namespace SayingHello.CommandLine;

public sealed class CommandLineGreeting(IGreetingService greetingService)
{
    private readonly IGreetingService _greetingService = greetingService;

    public string BuildMessage(string[] args)
    {
        var name = args.Length > 0 ? args[0] : "";

        return _greetingService.Greet(name);
    }
}
```

Run:

```bash
just check-tests
git add -A
git commit -m "4. Green: Handle The Empty Argument List"
```

This should pass.

### 5. Stop At The Contract Boundary

Run:

```bash
just check-tests
git add -A
git commit -m "5. Stop At The Contract Boundary"
```

This should pass with both adapter tests green.

Leave the placeholder `NotImplementedGreetingService` in `Program.cs` for now. Because `tutorial/code.md` comes before this file, the code layer should already exist before you finish wiring the adapter.
