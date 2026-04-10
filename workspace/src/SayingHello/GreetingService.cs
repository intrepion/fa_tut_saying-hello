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
