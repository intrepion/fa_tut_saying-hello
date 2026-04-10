# Contracts

Create the contracts library inside `workspace/` first.

From the workspace root, run:

```bash
dotnet new classlib --language C# --output src/SayingHello.Contracts --name SayingHello.Contracts
dotnet sln SayingHello.sln add src/SayingHello.Contracts/SayingHello.Contracts.csproj
```

After those commands finish, stay in the workspace root and continue with the rest of this file.

### Replace The Template Files

From the workspace root, remove the placeholder files that `dotnet new` created:

```bash
rm src/SayingHello.Contracts/Class1.cs
```

Create the replacement file now:

```bash
touch src/SayingHello.Contracts/IGreetingService.cs
```

### Define The Greeting Contract

Create `src/SayingHello.Contracts/IGreetingService.cs` with this exact code:

```csharp
namespace SayingHello.Contracts;

public interface IGreetingService
{
    string Greet(string name);
}
```

After the contract file exists, make this commit:

```bash
git add src/SayingHello.Contracts/IGreetingService.cs
git commit -m "Define Greeting Service Contract"
```
