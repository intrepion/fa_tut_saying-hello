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
}
