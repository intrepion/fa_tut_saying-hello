# Contracts

From the repository root, run:

```bash
dotnet new classlib --language C# --output workspace/src/SayingHello.Contracts --name SayingHello.Contracts
dotnet sln workspace/SayingHello.sln add workspace/src/SayingHello.Contracts/SayingHello.Contracts.csproj
```

### Replace The Template Files

From the repo root, remove the placeholder files that `dotnet new` created:

```bash
rm workspace/src/SayingHello.Contracts/Class1.cs
```

Create the replacement file now:

```bash
touch workspace/src/SayingHello.Contracts/IGreetingService.cs
```

### Define The Greeting Contract

Create `workspace/src/SayingHello.Contracts/IGreetingService.cs` with this exact code:

```csharp
namespace SayingHello.Contracts;

public interface IGreetingService
{
    string Greet(string name);
}
```

After the contract file exists, make this commit:

```bash
git add workspace/src/SayingHello.Contracts/IGreetingService.cs
git commit -m "Define Greeting Service Contract"
```
