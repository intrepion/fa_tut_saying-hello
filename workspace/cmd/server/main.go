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
