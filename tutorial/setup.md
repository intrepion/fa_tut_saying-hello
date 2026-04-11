# Setup

Keep the repository root for shared files like `README.md`, `LICENSE`, `.gitignore`, `.github/`, and `tutorial/`.

Put all .NET code inside a single `workspace/` folder.

From the repository root, run each setup command and checkpoint it before moving to the next one:

```bash
mkdir -p workspace
git add --all
git commit --message "mkdir -p workspace"

dotnet new sln --format sln --name SayingHello --output workspace
just format
git add --all
git commit --message "dotnet new sln --format sln --name SayingHello --output workspace"

dotnet new gitignore --output workspace
just format
git add --all
git commit --message "dotnet new gitignore --output workspace"
```

This gives you:

- a root-level `.gitignore` for operating-system noise and editor leftovers
- a `workspace/.gitignore` for standard `.NET` build output and local tooling files

When the full workspace is finished, it should contain these projects:

- `workspace/src/SayingHello.Contracts`
- `workspace/src/SayingHello`
- `workspace/tests/SayingHello.Tests`
- `workspace/src/SayingHello.CommandLine`
- `workspace/tests/SayingHello.CommandLine.Tests`

The next files assume this layout:

```text
workspace/
  .gitignore
  SayingHello.sln
  src/
    SayingHello.Contracts/
    SayingHello/
    SayingHello.CommandLine/
  tests/
    SayingHello.Tests/
    SayingHello.CommandLine.Tests/
```
