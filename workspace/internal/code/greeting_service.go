package code

type GreetingService struct{}

func (s GreetingService) Greet(name string) string {
	return "Hello, " + name + "!"
}
