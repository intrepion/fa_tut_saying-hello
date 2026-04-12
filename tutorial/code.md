# Code

### 1. Red: Add The First Failing Code Test

Create the first test file:

```bash
touch workspace/internal/code/greeting_service_test.go
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
```

Run:

```bash
just format
just check-all
git add --all
git commit --message "1. Red: Add The First Failing Code Test"
```

### 2. Green: Return The Personalized Greeting

Create the first production file:

```bash
touch workspace/internal/code/greeting_service.go
```

Put this exact content in `workspace/internal/code/greeting_service.go`:

```go
package code

type GreetingService struct{}

func (s GreetingService) Greet(name string) string {
	return "Hello, " + name + "!"
}
```

Run:

```bash
just format
just check-all
git add --all
git commit --message "2. Green: Return The Personalized Greeting"
```

### 3. Red: Add The Trimming Test

Replace `workspace/internal/code/greeting_service_test.go` with:

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
```

Run:

```bash
just format
just check-all
git add --all
git commit --message "3. Red: Add The Trimming Test"
```

### 4. Green: Trim The Name Before Greeting

Replace `workspace/internal/code/greeting_service.go` with:

```go
package code

import "strings"

type GreetingService struct{}

func (s GreetingService) Greet(name string) string {
	trimmed := strings.TrimSpace(name)
	return "Hello, " + trimmed + "!"
}
```

Run:

```bash
just format
just check-all
git add --all
git commit --message "4. Green: Trim The Name Before Greeting"
```

### 5. Red: Add Empty-Input Tests

Replace `workspace/internal/code/greeting_service_test.go` with:

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

Run:

```bash
just format
just check-all
git add --all
git commit --message "5. Red: Add Empty-Input Tests"
```

### 6. Green: Return The Generic Greeting For Empty Input

Replace `workspace/internal/code/greeting_service.go` with:

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

Run:

```bash
just format
just check-all
git add --all
git commit --message "6. Green: Return The Generic Greeting For Empty Input"
```
