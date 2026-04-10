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
