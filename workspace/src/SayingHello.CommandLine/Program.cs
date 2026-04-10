using SayingHello;
using SayingHello.CommandLine;

var greetingService = new GreetingService();
var adapter = new CommandLineGreeting(greetingService);

Console.WriteLine(adapter.BuildMessage(args));
