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
