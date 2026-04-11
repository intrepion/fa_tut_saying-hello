# Setup

Keep the repository root for shared files like `README.md`, `LICENSE`, `.gitignore`, `.github/`, `justfile`, and `tutorial/`.

Put all Astro code inside a single `workspace/` folder.

From the repository root, run each setup command and checkpoint it before moving to the next one:

```bash
mkdir -p workspace
git add --all
git commit --message "mkdir -p workspace"

curl -L -s https://raw.githubusercontent.com/github/gitignore/refs/heads/main/Node.gitignore > workspace/.gitignore
git add --all
git commit --message "curl -L -s https://raw.githubusercontent.com/github/gitignore/refs/heads/main/Node.gitignore > workspace/.gitignore"

printf '\n# Astro\n.astro/\ndist/\n\n# Vitest\ncoverage/\n' >> workspace/.gitignore
git add --all
git commit --message "printf '\\n# Astro\\n.astro/\\ndist/\\n\\n# Vitest\\ncoverage/\\n' >> workspace/.gitignore"

(cd workspace && npm init --yes)
git add --all
git commit --message "(cd workspace && npm init --yes)"

(cd workspace && npm install astro)
git add --all
git commit --message "(cd workspace && npm install astro)"

(cd workspace && npm install --save-dev typescript vitest jsdom prettier @types/node)
git add --all
git commit --message "(cd workspace && npm install --save-dev typescript vitest jsdom prettier @types/node)"

(cd workspace && npm pkg set private=true)
git add --all
git commit --message "(cd workspace && npm pkg set private=true)"

(cd workspace && npm pkg set type=module)
git add --all
git commit --message "(cd workspace && npm pkg set type=module)"

(cd workspace && npm pkg delete main)
git add --all
git commit --message "(cd workspace && npm pkg delete main)"

(cd workspace && npm pkg set scripts.dev="astro dev --host 0.0.0.0 --port 25617")
git add --all
git commit --message "(cd workspace && npm pkg set scripts.dev=\"astro dev --host 0.0.0.0 --port 25617\")"

(cd workspace && npm pkg set scripts.build="astro build")
git add --all
git commit --message "(cd workspace && npm pkg set scripts.build=\"astro build\")"

(cd workspace && npm pkg set scripts.preview="astro preview --host 0.0.0.0 --port 25617")
git add --all
git commit --message "(cd workspace && npm pkg set scripts.preview=\"astro preview --host 0.0.0.0 --port 25617\")"

(cd workspace && npm pkg set scripts.format="prettier --write .")
git add --all
git commit --message "(cd workspace && npm pkg set scripts.format=\"prettier --write .\")"

(cd workspace && npm pkg set scripts.check-formatting="prettier --check .")
git add --all
git commit --message "(cd workspace && npm pkg set scripts.check-formatting=\"prettier --check .\")"

(cd workspace && npm pkg set scripts.test="vitest run")
git add --all
git commit --message "(cd workspace && npm pkg set scripts.test=\"vitest run\")"

mkdir -p workspace/src/contracts
git add --all
git commit --message "mkdir -p workspace/src/contracts"

mkdir -p workspace/src/code
git add --all
git commit --message "mkdir -p workspace/src/code"

mkdir -p workspace/src/adapter
git add --all
git commit --message "mkdir -p workspace/src/adapter"

mkdir -p workspace/src/pages
git add --all
git commit --message "mkdir -p workspace/src/pages"

touch workspace/astro.config.mjs
git add --all
git commit --message "touch workspace/astro.config.mjs"

touch workspace/tsconfig.json
git add --all
git commit --message "touch workspace/tsconfig.json"

touch workspace/vitest.config.ts
git add --all
git commit --message "touch workspace/vitest.config.ts"

touch workspace/src/env.d.ts
git add --all
git commit --message "touch workspace/src/env.d.ts"
```

Put this exact content in `workspace/astro.config.mjs`:

```js
import { defineConfig } from 'astro/config';

export default defineConfig({});
```

Put this exact content in `workspace/tsconfig.json`:

```json
{
  "extends": "astro/tsconfigs/strict"
}
```

Put this exact content in `workspace/vitest.config.ts`:

```ts
/// <reference types="vitest/config" />

import { getViteConfig } from 'astro/config';

export default getViteConfig({
  test: {
    environment: 'node',
  },
});
```

Put this exact content in `workspace/src/env.d.ts`:

```ts
/// <reference types="astro/client" />
```

After those setup files have their final contents, run:

```bash
just format
git add --all
git commit --message "Add Astro workspace configuration files"
```

The browser-binding test later in `tutorial/adapter.md` opts into `jsdom` explicitly. Everything else can stay on the default Node test environment.

When the full workspace is finished, it should contain these files:

```text
workspace/
  .gitignore
  astro.config.mjs
  package.json
  package-lock.json
  tsconfig.json
  vitest.config.ts
  src/
    env.d.ts
    contracts/
      greeting-api.ts
      greeting-response.ts
    code/
      load-greeting.ts
      load-greeting.test.ts
    adapter/
      http-greeting-api.ts
      http-greeting-api.test.ts
      bind-greeting-form.ts
      bind-greeting-form.test.ts
      index-page.test.ts
    pages/
      index.astro
```
