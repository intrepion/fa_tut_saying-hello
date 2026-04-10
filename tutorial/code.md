# Code

Create the code files:

```bash
touch workspace/internal/code/greeting_service.go
touch workspace/internal/code/greeting_service_test.go
```

Put this exact content in `workspace/internal/code/greeting_service.go`:

```go
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
```

Put this exact content in `workspace/internal/code/greeting_service_test.go`:

```go
package code

import (
	"testing"

	"github.com/stretchr/testify/assert"
)

func TestGreetingService_GreetReturnsPersonalGreetingForNonEmptyName(t *testing.T) {
	service := GreetingService{}

	result := service.Greet("Ada")

	assert.Equal(t, "Hello, Ada!", result)
}

func TestGreetingService_GreetTrimsWhitespaceBeforeGreeting(t *testing.T) {
	service := GreetingService{}

	result := service.Greet("  Ada  ")

	assert.Equal(t, "Hello, Ada!", result)
}

func TestGreetingService_GreetReturnsGenericGreetingForEmptyName(t *testing.T) {
	service := GreetingService{}

	result := service.Greet("")

	assert.Equal(t, "Hello!", result)
}

func TestGreetingService_GreetReturnsGenericGreetingForWhitespaceOnlyName(t *testing.T) {
	service := GreetingService{}

	result := service.Greet("   ")

	assert.Equal(t, "Hello!", result)
}
```

Then run:

```bash
just check-tests
git add -A
git commit -m "Implement greeting service"
```
