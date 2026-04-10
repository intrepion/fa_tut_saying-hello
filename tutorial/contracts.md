# Contracts

Create the shared contract file:

```bash
touch workspace/internal/contracts/greeting.go
```

Put this exact content in `workspace/internal/contracts/greeting.go`:

```go
package contracts

type GreetingService interface {
	Greet(name string) string
}

type GreetingResponse struct {
	Message string `json:"message"`
}
```

Do not add tests here. Keep this layer limited to interfaces and small shared types.

Then run:

```bash
git add -A
git commit -m "Define greeting contracts"
```
