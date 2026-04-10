using NSubstitute;
using SayingHello.CommandLine;
using SayingHello.Contracts;
using Xunit;

namespace SayingHello.CommandLine.Tests;

public sealed class CommandLineGreetingTests
{
    [Fact]
    public void Build_message_delegates_to_greeting_service_for_first_argument()
    {
        var greetingService = Substitute.For<IGreetingService>();
        greetingService.Greet("Ada").Returns("Hello, Ada!");
        var sut = new CommandLineGreeting(greetingService);

        var result = sut.BuildMessage(["Ada"]);

        Assert.Equal("Hello, Ada!", result);
        greetingService.Received(1).Greet("Ada");
    }

    [Fact]
    public void Build_message_returns_generic_greeting_when_no_arguments_are_present()
    {
        var greetingService = Substitute.For<IGreetingService>();
        greetingService.Greet("").Returns("Hello!");
        var sut = new CommandLineGreeting(greetingService);

        var result = sut.BuildMessage([]);

        Assert.Equal("Hello!", result);
        greetingService.Received(1).Greet("");
    }
}
