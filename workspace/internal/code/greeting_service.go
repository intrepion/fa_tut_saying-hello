package code

import "strings"

type GreetingService struct{}

func (s GreetingService) Greet(name string) string {
	trimmed := strings.TrimSpace(name)
	if trimmed == "" {
		return "Hello!"
	}

	return "Hello, " + trimmed + "!"
}
