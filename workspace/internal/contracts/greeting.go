package contracts

type GreetingService interface {
	Greet(name string) string
}

type GreetingResponse struct {
	Message string `json:"message"`
}
