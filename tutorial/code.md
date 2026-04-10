# Code

Create the code library and its test library inside `workspace/`.

Both the code library and the code test library should reference the contracts library.

From the workspace root, run:

```bash
dotnet new classlib --language C# --output src/SayingHello --name SayingHello
dotnet new xunit --language C# --output tests/SayingHello.Tests --name SayingHello.Tests
dotnet sln SayingHello.sln add src/SayingHello/SayingHello.csproj
dotnet sln SayingHello.sln add tests/SayingHello.Tests/SayingHello.Tests.csproj
dotnet add src/SayingHello/SayingHello.csproj reference src/SayingHello.Contracts/SayingHello.Contracts.csproj
dotnet add tests/SayingHello.Tests/SayingHello.Tests.csproj reference src/SayingHello.Contracts/SayingHello.Contracts.csproj
dotnet add tests/SayingHello.Tests/SayingHello.Tests.csproj reference src/SayingHello/SayingHello.csproj
```

After those commands finish, stay in the workspace root and continue with the rest of this file.

### Replace The Template Files

From the workspace root, remove the placeholder files that `dotnet new` created:

```bash
rm src/SayingHello/Class1.cs
rm tests/SayingHello.Tests/UnitTest1.cs
```

Create the replacement files now:

```bash
touch src/SayingHello/GreetingService.cs
touch tests/SayingHello.Tests/GreetingServiceTests.cs
```

### 1. Red: Add The First Failing Test

Create `tests/SayingHello.Tests/GreetingServiceTests.cs` with this exact code:

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
dotnet test
```

This should fail because `GreetingService` does not exist yet.

### 2. Green: Add The Smallest Production Code

Create `src/SayingHello/GreetingService.cs` with this exact code:

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
dotnet test
```

This should pass.

### 3. Red: Add The Trimming Test

Replace `tests/SayingHello.Tests/GreetingServiceTests.cs` with this exact code:

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
dotnet test
```

This should fail.

### 4. Green: Make The Trimming Test Pass

Replace `src/SayingHello/GreetingService.cs` with this exact code:

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
dotnet test
```

This should pass.

### 5. Red: Add The Empty-String Test

Replace `tests/SayingHello.Tests/GreetingServiceTests.cs` with this exact code:

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
dotnet test
```

This should fail.

### 6. Green: Make The Empty-String Test Pass

Replace `src/SayingHello/GreetingService.cs` with this exact code:

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
dotnet test
```

This should pass.

### 7. Red: Add The Whitespace-Only Test

Replace `tests/SayingHello.Tests/GreetingServiceTests.cs` with this exact code:

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
dotnet test
```

This should fail.

### 8. Green: Finish The Core Behavior

Replace `src/SayingHello/GreetingService.cs` with this exact code:

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
dotnet test
```

This should pass with all four tests green.
