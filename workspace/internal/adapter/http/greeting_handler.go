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
