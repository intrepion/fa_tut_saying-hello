# Adapter

### 1. Red: Add The First Failing HTTP Adapter Test

Create the first adapter test file:

```bash
touch workspace/src/adapter/http-greeting-api.test.ts
just format
just check-all
git add --all
git commit --message 'touch workspace/src/adapter/http-greeting-api.test.ts'
```

Put this exact content in `workspace/src/adapter/http-greeting-api.test.ts`:

```ts
import { afterEach, describe, expect, it, vi } from 'vitest';

import { HttpGreetingApi } from './http-greeting-api';

describe('HttpGreetingApi', () => {
  afterEach(() => {
    vi.unstubAllGlobals();
  });

  it('requests the canonical greeting endpoint', async () => {
    const fetchMock = vi.fn().mockResolvedValue({
      json: vi.fn().mockResolvedValue({ message: 'Hello, Ada!' }),
    });
    vi.stubGlobal('fetch', fetchMock);

    const api = new HttpGreetingApi('http://localhost:25616');
    const result = await api.getGreeting('Ada');

    expect(fetchMock).toHaveBeenCalledWith('http://localhost:25616/api/greeting?name=Ada');
    expect(result).toEqual({ message: 'Hello, Ada!' });
  });
});
```

Run:

```bash
just format
just check-all
git add --all
git commit --message "1. Red: Add The First Failing HTTP Adapter Test"
```

### 2. Green: Request The Canonical Greeting Endpoint

Create the first adapter production file:

```bash
touch workspace/src/adapter/http-greeting-api.ts
just format
just check-all
git add --all
git commit --message 'touch workspace/src/adapter/http-greeting-api.ts'
```

Put this exact content in `workspace/src/adapter/http-greeting-api.ts`:

```ts
import type { GreetingApi } from '../contracts/greeting-api';
import type { GreetingResponse } from '../contracts/greeting-response';

export class HttpGreetingApi implements GreetingApi {
  constructor(private readonly baseUrl: string) {}

  async getGreeting(name: string): Promise<GreetingResponse> {
    const response = await fetch(
      `${this.baseUrl}/api/greeting?name=${encodeURIComponent(name)}`,
    );

    return (await response.json()) as GreetingResponse;
  }
}
```

Run:

```bash
just format
just check-all
git add --all
git commit --message "2. Green: Request The Canonical Greeting Endpoint"
```

### 3. Red: Omit The Query String For Empty Input

Replace `workspace/src/adapter/http-greeting-api.test.ts` with:

```ts
import { afterEach, describe, expect, it, vi } from 'vitest';

import { HttpGreetingApi } from './http-greeting-api';

describe('HttpGreetingApi', () => {
  afterEach(() => {
    vi.unstubAllGlobals();
  });

  it('requests the canonical greeting endpoint', async () => {
    const fetchMock = vi.fn().mockResolvedValue({
      json: vi.fn().mockResolvedValue({ message: 'Hello, Ada!' }),
    });
    vi.stubGlobal('fetch', fetchMock);

    const api = new HttpGreetingApi('http://localhost:25616');
    const result = await api.getGreeting('Ada');

    expect(fetchMock).toHaveBeenCalledWith('http://localhost:25616/api/greeting?name=Ada');
    expect(result).toEqual({ message: 'Hello, Ada!' });
  });

  it('omits the query string for empty input', async () => {
    const fetchMock = vi.fn().mockResolvedValue({
      json: vi.fn().mockResolvedValue({ message: 'Hello!' }),
    });
    vi.stubGlobal('fetch', fetchMock);

    const api = new HttpGreetingApi('http://localhost:25616');
    const result = await api.getGreeting('');

    expect(fetchMock).toHaveBeenCalledWith('http://localhost:25616/api/greeting');
    expect(result).toEqual({ message: 'Hello!' });
  });
});
```

Run:

```bash
just format
just check-all
git add --all
git commit --message "3. Red: Omit The Query String For Empty Input"
```

### 4. Green: Omit The Query String For Empty Input

Replace `workspace/src/adapter/http-greeting-api.ts` with:

```ts
import type { GreetingApi } from '../contracts/greeting-api';
import type { GreetingResponse } from '../contracts/greeting-response';

export class HttpGreetingApi implements GreetingApi {
  constructor(private readonly baseUrl: string) {}

  async getGreeting(name: string): Promise<GreetingResponse> {
    const url =
      name === ''
        ? `${this.baseUrl}/api/greeting`
        : `${this.baseUrl}/api/greeting?name=${encodeURIComponent(name)}`;

    const response = await fetch(url);

    return (await response.json()) as GreetingResponse;
  }
}
```

Run:

```bash
just format
just check-all
git add --all
git commit --message "4. Green: Omit The Query String For Empty Input"
```

### 5. Red: Add The Browser Binding Test

Create the browser binding test file:

```bash
touch workspace/src/adapter/bind-greeting-form.test.ts
just format
just check-all
git add --all
git commit --message 'touch workspace/src/adapter/bind-greeting-form.test.ts'
```

Put this exact content in `workspace/src/adapter/bind-greeting-form.test.ts`:

```ts
// @vitest-environment jsdom

import { describe, expect, it, vi } from 'vitest';

import type { GreetingApi } from '../contracts/greeting-api';
import { bindGreetingForm } from './bind-greeting-form';

describe('bindGreetingForm', () => {
  it('renders the greeting returned by the API', async () => {
    document.body.innerHTML = `
      <form data-greeting-form>
        <input data-greeting-name />
        <button type="submit">Say hello</button>
      </form>
      <p data-greeting-output></p>
    `;

    const form = document.querySelector('[data-greeting-form]') as HTMLFormElement;
    const nameInput = document.querySelector('[data-greeting-name]') as HTMLInputElement;
    const output = document.querySelector('[data-greeting-output]') as HTMLParagraphElement;
    const getGreeting = vi.fn().mockResolvedValue({ message: 'Hello, Ada!' });
    const api: GreetingApi = { getGreeting };

    bindGreetingForm({ form, nameInput, output, api });

    nameInput.value = 'Ada';
    form.dispatchEvent(new Event('submit', { bubbles: true, cancelable: true }));
    await new Promise((resolve) => setTimeout(resolve, 0));

    expect(getGreeting).toHaveBeenCalledWith('Ada');
    expect(output.textContent).toBe('Hello, Ada!');
  });
});
```

Run:

```bash
just format
just check-all
git add --all
git commit --message "5. Red: Add The Browser Binding Test"
```

### 6. Green: Bind The Browser Form

Create the browser binding file:

```bash
touch workspace/src/adapter/bind-greeting-form.ts
just format
just check-all
git add --all
git commit --message 'touch workspace/src/adapter/bind-greeting-form.ts'
```

Put this exact content in `workspace/src/adapter/bind-greeting-form.ts`:

```ts
import type { GreetingApi } from '../contracts/greeting-api';
import { loadGreeting } from '../code/load-greeting';

type BindGreetingFormOptions = {
  form: HTMLFormElement;
  nameInput: HTMLInputElement;
  output: HTMLElement;
  api: GreetingApi;
};

export function bindGreetingForm({
  form,
  nameInput,
  output,
  api,
}: BindGreetingFormOptions) {
  form.addEventListener('submit', async (event) => {
    event.preventDefault();

    const result = await loadGreeting(nameInput.value, api);
    output.textContent = result.message;
  });
}
```

Run:

```bash
just format
just check-all
git add --all
git commit --message "6. Green: Bind The Browser Form"
```

### 7. Red: Add The Astro Page Test

Create the Astro page test file:

```bash
touch workspace/src/adapter/index-page.test.ts
just format
just check-all
git add --all
git commit --message 'touch workspace/src/adapter/index-page.test.ts'
```

Put this exact content in `workspace/src/adapter/index-page.test.ts`:

```ts
import { experimental_AstroContainer as AstroContainer } from 'astro/container';
import { describe, expect, it } from 'vitest';

import IndexPage from '../pages/index.astro';

describe('index page', () => {
  it('renders the greeting form and API endpoint', async () => {
    const container = await AstroContainer.create();
    const result = await container.renderToString(IndexPage);

    expect(result).toContain('data-greeting-form');
    expect(result).toContain('data-greeting-name');
    expect(result).toContain('data-greeting-output');
    expect(result).toContain('http://localhost:25616');
  });
});
```

Run:

```bash
just format
just check-all
git add --all
git commit --message "7. Red: Add The Astro Page Test"
```

### 8. Green: Wire The Astro Page

Create the Astro page:

```bash
touch workspace/src/pages/index.astro
just format
just check-all
git add --all
git commit --message 'touch workspace/src/pages/index.astro'
```

Put this exact content in `workspace/src/pages/index.astro`:

```astro
---
const apiBaseUrl = 'http://localhost:25616';
---

<html lang="en">
  <head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width" />
    <title>Saying Hello</title>
  </head>
  <body>
    <main>
      <h1>Saying Hello</h1>
      <form data-greeting-form>
        <label for="name-input">Name</label>
        <input data-greeting-name id="name-input" name="name" type="text" />
        <button type="submit">Say hello</button>
      </form>
      <p data-greeting-output aria-live="polite"></p>
    </main>

    <script>
      import { HttpGreetingApi } from '../adapter/http-greeting-api';
      import { bindGreetingForm } from '../adapter/bind-greeting-form';

      const form = document.querySelector('[data-greeting-form]');
      const nameInput = document.querySelector('[data-greeting-name]');
      const output = document.querySelector('[data-greeting-output]');

      if (
        form instanceof HTMLFormElement &&
        nameInput instanceof HTMLInputElement &&
        output instanceof HTMLElement
      ) {
        bindGreetingForm({
          form,
          nameInput,
          output,
          api: new HttpGreetingApi(apiBaseUrl),
        });
      }
    </script>
  </body>
</html>
```

Run:

```bash
just format
just check-all
git add --all
git commit --message "8. Green: Wire The Astro Page"
```
