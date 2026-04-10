using SayingHello;
using Xunit;

namespace SayingHello.Tests;

public sealed class GreetingServiceTests
{
    [Fact]
    public void Greet_returns_personalized_greeting_for_non_empty_name()
    {
        var sut = new GreetingService();

        var result = sut.Greet("Ada");

        Assert.Equal("Hello, Ada!", result);
    }

    [Fact]
    public void Greet_trims_leading_and_trailing_whitespace()
    {
        var sut = new GreetingService();

        var result = sut.Greet("  Ada  ");

        Assert.Equal("Hello, Ada!", result);
    }

    [Fact]
    public void Greet_returns_generic_greeting_for_empty_string()
    {
        var sut = new GreetingService();

        var result = sut.Greet("");

        Assert.Equal("Hello!", result);
    }

    [Fact]
    public void Greet_returns_generic_greeting_for_whitespace_only_input()
    {
        var sut = new GreetingService();

        var result = sut.Greet("   ");

        Assert.Equal("Hello!", result);
    }
}
