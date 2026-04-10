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
