# Adapter

Create the adapter files:

```bash
touch workspace/internal/adapter/http/greeting_handler.go
touch workspace/internal/adapter/http/greeting_handler_test.go
touch workspace/cmd/server/main.go
```

Put this exact content in `workspace/internal/adapter/http/greeting_handler.go`:

```go
package httpadapter

import (
	"net/http"

	"github.com/intrepion/fa_tut_saying-hello/workspace/internal/contracts"
	"github.com/labstack/echo/v4"
)

type GreetingHandler struct {
	service contracts.GreetingService
}

func NewGreetingHandler(service contracts.GreetingService) *GreetingHandler {
	return &GreetingHandler{service: service}
}

func (h *GreetingHandler) GetGreeting(c echo.Context) error {
	name := c.QueryParam("name")

	return c.JSON(http.StatusOK, contracts.GreetingResponse{
		Message: h.service.Greet(name),
	})
}
```

Put this exact content in `workspace/internal/adapter/http/greeting_handler_test.go`:

```go
package httpadapter

import (
	"encoding/json"
	"net/http"
	"net/http/httptest"
	"testing"

	"github.com/intrepion/fa_tut_saying-hello/workspace/internal/contracts"
	"github.com/labstack/echo/v4"
	"github.com/stretchr/testify/assert"
	"github.com/stretchr/testify/mock"
)

type MockGreetingService struct {
	mock.Mock
}

func (m *MockGreetingService) Greet(name string) string {
	args := m.Called(name)
	return args.String(0)
}

func TestGreetingHandler_GetGreetingReturnsCanonicalJson(t *testing.T) {
	e := echo.New()
	req := httptest.NewRequest(http.MethodGet, "/api/greeting?name=Ada", nil)
	rec := httptest.NewRecorder()
	ctx := e.NewContext(req, rec)

	service := new(MockGreetingService)
	service.On("Greet", "Ada").Return("Hello, Ada!")

	handler := NewGreetingHandler(service)
	err := handler.GetGreeting(ctx)

	assert.NoError(t, err)
	assert.Equal(t, http.StatusOK, rec.Code)

	var body contracts.GreetingResponse
	err = json.Unmarshal(rec.Body.Bytes(), &body)

	assert.NoError(t, err)
	assert.Equal(t, "Hello, Ada!", body.Message)
	service.AssertExpectations(t)
}
```

Put this exact content in `workspace/cmd/server/main.go`:

```go
package main

import (
	"log"

	httpadapter "github.com/intrepion/fa_tut_saying-hello/workspace/internal/adapter/http"
	"github.com/intrepion/fa_tut_saying-hello/workspace/internal/code"
	"github.com/labstack/echo/v4"
)

func main() {
	e := echo.New()
	service := code.GreetingService{}
	handler := httpadapter.NewGreetingHandler(service)

	e.GET("/api/greeting", handler.GetGreeting)

	log.Fatal(e.Start(":25616"))
}
```

Then run:

```bash
just check-tests
git add -A
git commit -m "Add Echo greeting adapter"
```
