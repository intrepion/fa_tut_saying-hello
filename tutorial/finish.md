# Finish

Start the API server from the repository root:

```bash
just run
```

In another terminal, try these requests:

```bash
curl "http://localhost:25616/api/greeting"
curl "http://localhost:25616/api/greeting?name=Ada"
```

You should get:

```json
{"message":"Hello!"}
```

and:

```json
{"message":"Hello, Ada!"}
```
