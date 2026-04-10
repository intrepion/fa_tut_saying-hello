# Setup

Keep the repository root for shared files like `README.md`, `LICENSE`, `.gitignore`, `.github/`, and `tutorial/`.

Put all .NET code inside a single `workspace/` folder.

From the repository root, run:

```bash
mkdir -p workspace
dotnet new sln --format sln --name SayingHello --output workspace
dotnet new gitignore --output workspace
```

After those commands finish, stay in the repository root for the rest of this tutorial sequence unless a step explicitly says otherwise.

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
