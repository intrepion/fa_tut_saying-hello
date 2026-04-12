# Setup

Keep the repository root for shared files like `README.md`, `LICENSE`, `.gitignore`, `.github/`, `justfile`, and `tutorial/`.

Put all Go code inside a single `workspace/` folder.

From the repository root, run each setup command and checkpoint it before moving to the next one:

```bash
mkdir -p workspace
git add --all
git commit --message "mkdir -p workspace"

(cd workspace && go mod init github.com/intrepion/fa_tut_saying-hello/workspace)
just format
git add --all
git commit --message "(cd workspace && go mod init github.com/intrepion/fa_tut_saying-hello/workspace)"

(cd workspace && go get github.com/labstack/echo/v4)
just format
git add --all
git commit --message "(cd workspace && go get github.com/labstack/echo/v4)"

(cd workspace && go get github.com/stretchr/testify/assert github.com/stretchr/testify/mock)
just format
git add --all
git commit --message "(cd workspace && go get github.com/stretchr/testify/assert github.com/stretchr/testify/mock)"

mkdir -p workspace/cmd/server
just format
git add --all
git commit --message "mkdir -p workspace/cmd/server"

mkdir -p workspace/internal/contracts
just format
git add --all
git commit --message "mkdir -p workspace/internal/contracts"

mkdir -p workspace/internal/code
just format
git add --all
git commit --message "mkdir -p workspace/internal/code"

mkdir -p workspace/internal/adapter/http
just format
git add --all
git commit --message "mkdir -p workspace/internal/adapter/http"
```

When the full workspace is finished, it should contain these files:

```text
workspace/
  go.mod
  go.sum
  cmd/
    server/
      main.go
  internal/
    contracts/
      greeting.go
    code/
      greeting_service.go
      greeting_service_test.go
    adapter/
      http/
        greeting_handler.go
        greeting_handler_test.go
```
