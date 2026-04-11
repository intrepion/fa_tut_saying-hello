# Code

Both the code library and the code test library should reference the contracts library.

From the repository root, run:

```bash
dotnet new classlib --language C# --output workspace/src/SayingHello --name SayingHello
dotnet new xunit --language C# --output workspace/tests/SayingHello.Tests --name SayingHello.Tests
dotnet sln workspace/SayingHello.sln add workspace/src/SayingHello/SayingHello.csproj
dotnet sln workspace/SayingHello.sln add workspace/tests/SayingHello.Tests/SayingHello.Tests.csproj
dotnet add workspace/src/SayingHello/SayingHello.csproj reference workspace/src/SayingHello.Contracts/SayingHello.Contracts.csproj
dotnet add workspace/tests/SayingHello.Tests/SayingHello.Tests.csproj reference workspace/src/SayingHello.Contracts/SayingHello.Contracts.csproj
dotnet add workspace/tests/SayingHello.Tests/SayingHello.Tests.csproj reference workspace/src/SayingHello/SayingHello.csproj
```

Then run:

```bash
just format
just check-all
git add --all
git commit --message "Create code and test projects"
```

### Replace The Template Files

From the repo root, remove the placeholder files that `dotnet new` created:

```bash
rm workspace/src/SayingHello/Class1.cs
rm workspace/tests/SayingHello.Tests/UnitTest1.cs
```

Create the replacement files now:

```bash
touch workspace/src/SayingHello/GreetingService.cs
just format
git add --all
git commit --message 'touch workspace/src/SayingHello/GreetingService.cs'
touch workspace/tests/SayingHello.Tests/GreetingServiceTests.cs
just format
git add --all
git commit --message 'touch workspace/tests/SayingHello.Tests/GreetingServiceTests.cs'
```

### 1. Red: Add The First Failing Test

Create `workspace/tests/SayingHello.Tests/GreetingServiceTests.cs` with this exact code:

```csharp
using SayingHello;
using Xunit;

namespace SayingHello.Tests;

public sealed class GreetingServiceTests
{
    [Fact]
    public void Greet_returns_personalized_greeting_for_non_empty_name()
    {
        var sut = new GreetingService();

        var result = sut.Greet("Ada");

        Assert.Equal("Hello, Ada!", result);
    }
}
```

Run:

```bash
just format
just check-all
git add --all
git commit --message "1. Red: Add The First Failing Test"
```

This should fail because `GreetingService` does not exist yet.

### 2. Green: Add The Smallest Production Code

Create `workspace/src/SayingHello/GreetingService.cs` with this exact code:

```csharp
using SayingHello.Contracts;

namespace SayingHello;

public sealed class GreetingService : IGreetingService
{
    public string Greet(string name)
    {
        return $"Hello, {name}!";
    }
}
```

Run:

```bash
just format
just check-all
git add --all
git commit --message "2. Green: Add The Smallest Production Code"
```

This should pass.

### 3. Red: Add The Trimming Test

Replace `workspace/tests/SayingHello.Tests/GreetingServiceTests.cs` with this exact code:

```csharp
using SayingHello;
using Xunit;

namespace SayingHello.Tests;

public sealed class GreetingServiceTests
{
    [Fact]
    public void Greet_returns_personalized_greeting_for_non_empty_name()
    {
        var sut = new GreetingService();

        var result = sut.Greet("Ada");

        Assert.Equal("Hello, Ada!", result);
    }

    [Fact]
    public void Greet_trims_leading_and_trailing_whitespace()
    {
        var sut = new GreetingService();

        var result = sut.Greet("  Ada  ");

        Assert.Equal("Hello, Ada!", result);
    }
}
```

Run:

```bash
just format
just check-all
git add --all
git commit --message "3. Red: Add The Trimming Test"
```

This should fail.

### 4. Green: Make The Trimming Test Pass

Replace `workspace/src/SayingHello/GreetingService.cs` with this exact code:

```csharp
using SayingHello.Contracts;

namespace SayingHello;

public sealed class GreetingService : IGreetingService
{
    public string Greet(string name)
    {
        var trimmedName = name.Trim();

        return $"Hello, {trimmedName}!";
    }
}
```

Run:

```bash
just format
just check-all
git add --all
git commit --message "4. Green: Make The Trimming Test Pass"
```

This should pass.

### 5. Red: Add The Empty-String Test

Replace `workspace/tests/SayingHello.Tests/GreetingServiceTests.cs` with this exact code:

```csharp
using SayingHello;
using Xunit;

namespace SayingHello.Tests;

public sealed class GreetingServiceTests
{
    [Fact]
    public void Greet_returns_personalized_greeting_for_non_empty_name()
    {
        var sut = new GreetingService();

        var result = sut.Greet("Ada");

        Assert.Equal("Hello, Ada!", result);
    }

    [Fact]
    public void Greet_trims_leading_and_trailing_whitespace()
    {
        var sut = new GreetingService();

        var result = sut.Greet("  Ada  ");

        Assert.Equal("Hello, Ada!", result);
    }

    [Fact]
    public void Greet_returns_generic_greeting_for_empty_string()
    {
        var sut = new GreetingService();

        var result = sut.Greet("");

        Assert.Equal("Hello!", result);
    }
}
```

Run:

```bash
just format
just check-all
git add --all
git commit --message "5. Red: Add The Empty-String Test"
```

This should fail.

### 6. Green: Make The Empty-String Test Pass

Replace `workspace/src/SayingHello/GreetingService.cs` with this exact code:

```csharp
using SayingHello.Contracts;

namespace SayingHello;

public sealed class GreetingService : IGreetingService
{
    public string Greet(string name)
    {
        if (name.Length == 0)
        {
            return "Hello!";
        }

        var trimmedName = name.Trim();

        return $"Hello, {trimmedName}!";
    }
}
```

Run:

```bash
just format
just check-all
git add --all
git commit --message "6. Green: Make The Empty-String Test Pass"
```

This should pass.

### 7. Red: Add The Whitespace-Only Test

Replace `workspace/tests/SayingHello.Tests/GreetingServiceTests.cs` with this exact code:

```csharp
using SayingHello;
using Xunit;

namespace SayingHello.Tests;

public sealed class GreetingServiceTests
{
    [Fact]
    public void Greet_returns_personalized_greeting_for_non_empty_name()
    {
        var sut = new GreetingService();

        var result = sut.Greet("Ada");

        Assert.Equal("Hello, Ada!", result);
    }

    [Fact]
    public void Greet_trims_leading_and_trailing_whitespace()
    {
        var sut = new GreetingService();

        var result = sut.Greet("  Ada  ");

        Assert.Equal("Hello, Ada!", result);
    }

    [Fact]
    public void Greet_returns_generic_greeting_for_empty_string()
    {
        var sut = new GreetingService();

        var result = sut.Greet("");

        Assert.Equal("Hello!", result);
    }

    [Fact]
    public void Greet_returns_generic_greeting_for_whitespace_only_input()
    {
        var sut = new GreetingService();

        var result = sut.Greet("   ");

        Assert.Equal("Hello!", result);
    }
}
```

Run:

```bash
just format
just check-all
git add --all
git commit --message "7. Red: Add The Whitespace-Only Test"
```

This should fail.

### 8. Green: Finish The Core Behavior

Replace `workspace/src/SayingHello/GreetingService.cs` with this exact code:

```csharp
using SayingHello.Contracts;

namespace SayingHello;

public sealed class GreetingService : IGreetingService
{
    public string Greet(string name)
    {
        var trimmedName = name.Trim();

        if (trimmedName.Length == 0)
        {
            return "Hello!";
        }

        return $"Hello, {trimmedName}!";
    }
}
```

Run:

```bash
just format
just check-all
git add --all
git commit --message "8. Green: Finish The Core Behavior"
```

This should pass with all four tests green.
