# Adapter

### 1. Red: Add The First Failing Adapter Test

Create the first adapter test file:

```bash
touch workspace/internal/adapter/http/greeting_handler_test.go
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

Run:

```bash
just format
just check-all
git add --all
git commit --message "1. Red: Add The First Failing Adapter Test"
```

### 2. Green: Return The Canonical JSON Response

Create the first adapter production file:

```bash
touch workspace/internal/adapter/http/greeting_handler.go
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

Run:

```bash
just format
just check-all
git add --all
git commit --message "2. Green: Return The Canonical JSON Response"
```

### 3. Red: Add The Empty-Name Adapter Test

Replace `workspace/internal/adapter/http/greeting_handler_test.go` with:

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

func TestGreetingHandler_GetGreetingDelegatesEmptyNameForGenericGreeting(t *testing.T) {
	e := echo.New()
	req := httptest.NewRequest(http.MethodGet, "/api/greeting", nil)
	rec := httptest.NewRecorder()
	ctx := e.NewContext(req, rec)

	service := new(MockGreetingService)
	service.On("Greet", "").Return("Hello!")

	handler := NewGreetingHandler(service)
	err := handler.GetGreeting(ctx)

	assert.NoError(t, err)
	assert.Equal(t, http.StatusOK, rec.Code)

	var body contracts.GreetingResponse
	err = json.Unmarshal(rec.Body.Bytes(), &body)

	assert.NoError(t, err)
	assert.Equal(t, "Hello!", body.Message)
	service.AssertExpectations(t)
}
```

Run:

```bash
just format
just check-all
git add --all
git commit --message "3. Red: Add The Empty-Name Adapter Test"
```

### 4. Green: Wire The Server Entry Point

Create the server entry point:

```bash
touch workspace/cmd/server/main.go
```

Put this exact content in `workspace/cmd/server/main.go`:

```go
package main

import (
	"log"

	httpadapter "github.com/intrepion/fa_tut_saying-hello/workspace/internal/adapter/http"
	"github.com/intrepion/fa_tut_saying-hello/workspace/internal/code"
	"github.com/labstack/echo/v4"
	"github.com/labstack/echo/v4/middleware"
)

func main() {
	e := echo.New()
	e.Use(middleware.CORSWithConfig(middleware.CORSConfig{
		AllowOrigins: []string{"http://localhost:25617"},
	}))
	service := code.GreetingService{}
	handler := httpadapter.NewGreetingHandler(service)

	e.GET("/api/greeting", handler.GetGreeting)

	log.Fatal(e.Start(":25616"))
}
```

Run:

```bash
just format
just check-all
git add --all
git commit --message "4. Green: Wire The Server Entry Point"
```
