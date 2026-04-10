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
