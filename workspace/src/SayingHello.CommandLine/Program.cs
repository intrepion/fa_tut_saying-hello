using SayingHello.CommandLine;
using SayingHello.Contracts;

var greetingService = new NotImplementedGreetingService();
var adapter = new CommandLineGreeting(greetingService);

Console.WriteLine(adapter.BuildMessage(args));

internal sealed class NotImplementedGreetingService : IGreetingService
{
    public string Greet(string name)
    {
        throw new NotImplementedException(
            "Finish the matching core tutorial, then replace this placeholder with the real core implementation."
        );
    }
}
