# Spec

Canonical project contract for the `saying-hello` project.

## Goal

Build the smallest useful project app that introduces:

- a core logic contract
- test-first implementation
- thin surface adapters
- the repo-wide coverage expectations

## Core Logic Contract

The shared contract is:

```text
greet(name: string) -> string
```

Canonical behavior:

- trim leading and trailing whitespace from `name`
- if the trimmed name is non-empty, return `Hello, <name>!`
- if the trimmed name is empty, return `Hello!`

Examples:

- `greet("Ada")` returns `Hello, Ada!`
- `greet("  Ada  ")` returns `Hello, Ada!`
- `greet("")` returns `Hello!`
- `greet("   ")` returns `Hello!`

## Non-Goals

This first project does not include:

- persistence
- localization
- authentication
- network access
- configuration files
- multiple commands or routes

## Surface Expectations

This spec follows the shared surface and setup-path rules in the shared project guidance.

For this project, every tutorial run should adapt the same `greet` behavior instead of redefining it.

## Output Repository Expectations

This project follows the shared output model in the shared project guidance.

For this project, the code layer in this repo owns the `greet` rules and adapter layer must not reimplement them.

## Testing And Coverage Contract

This spec follows the shared coverage policy in the shared project guidance.

This project should be built in a spec-driven and test-driven way.

Minimum test expectations:

- tests for non-empty input
- tests for trimming behavior
- tests for empty and whitespace-only input
- tests for every adapter built in the chosen run that prove it delegates to the core logic correctly
