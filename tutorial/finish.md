# Finish

Start the API server from the repository root:

```bash
just run
```

This API is configured to accept browser requests from `http://localhost:25616`.

In another terminal, try these requests:

```bash
curl "http://localhost:25664/api/greeting"
curl "http://localhost:25664/api/greeting?name=Ada"
```

You should get:

```json
{"message":"Hello!"}
```

and:

```json
{"message":"Hello, Ada!"}
```
