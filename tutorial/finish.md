# Finish

Make sure the matching Saying Hello API is running at `http://localhost:25616`.

Then start the Flutter web app from the repository root:

```bash
just run
```

Open `http://localhost:25617` in your browser.

Try these inputs:

- submit the form with `Ada` and expect `Hello, Ada!`
- submit the form with an empty input and expect `Hello!`

If the API is unavailable, the page should show `Sorry, the greeting API is unavailable right now.`
