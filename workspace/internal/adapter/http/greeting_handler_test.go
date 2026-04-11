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
