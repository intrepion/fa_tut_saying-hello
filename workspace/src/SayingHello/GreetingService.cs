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
