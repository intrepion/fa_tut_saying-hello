# Code

### 1. Red: Add The First Failing Code Test

Create the first code test file:

```bash
touch workspace/src/code/load-greeting.test.ts
```

Put this exact content in `workspace/src/code/load-greeting.test.ts`:

```ts
import { describe, expect, it, vi } from 'vitest';

import type { GreetingApi } from '../contracts/greeting-api';
import { loadGreeting } from './load-greeting';

describe('loadGreeting', () => {
  it('returns the personalized greeting for a non-empty name', async () => {
    const getGreeting = vi.fn().mockResolvedValue({ message: 'Hello, Ada!' });
    const api: GreetingApi = { getGreeting };

    const result = await loadGreeting('Ada', api);

    expect(getGreeting).toHaveBeenCalledWith('Ada');
    expect(result).toEqual({
      submittedName: 'Ada',
      message: 'Hello, Ada!',
    });
  });
});
```

Run:

```bash
just check-tests
git add --all
git commit --message "1. Red: Add The First Failing Code Test"
```

### 2. Green: Return The Personalized Greeting

Create the first production file:

```bash
touch workspace/src/code/load-greeting.ts
```

Put this exact content in `workspace/src/code/load-greeting.ts`:

```ts
import type { GreetingApi } from '../contracts/greeting-api';

export async function loadGreeting(name: string, api: GreetingApi) {
  const response = await api.getGreeting(name);

  return {
    submittedName: name,
    message: response.message,
  };
}
```

Run:

```bash
just check-tests
git add --all
git commit --message "2. Green: Return The Personalized Greeting"
```

### 3. Red: Trim The Name Before Calling The API

Replace `workspace/src/code/load-greeting.test.ts` with:

```ts
import { describe, expect, it, vi } from 'vitest';

import type { GreetingApi } from '../contracts/greeting-api';
import { loadGreeting } from './load-greeting';

describe('loadGreeting', () => {
  it('returns the personalized greeting for a non-empty name', async () => {
    const getGreeting = vi.fn().mockResolvedValue({ message: 'Hello, Ada!' });
    const api: GreetingApi = { getGreeting };

    const result = await loadGreeting('Ada', api);

    expect(getGreeting).toHaveBeenCalledWith('Ada');
    expect(result).toEqual({
      submittedName: 'Ada',
      message: 'Hello, Ada!',
    });
  });

  it('trims the name before calling the API', async () => {
    const getGreeting = vi.fn().mockResolvedValue({ message: 'Hello, Ada!' });
    const api: GreetingApi = { getGreeting };

    const result = await loadGreeting('  Ada  ', api);

    expect(getGreeting).toHaveBeenCalledWith('Ada');
    expect(result).toEqual({
      submittedName: 'Ada',
      message: 'Hello, Ada!',
    });
  });
});
```

Run:

```bash
just check-tests
git add --all
git commit --message "3. Red: Trim The Name Before Calling The API"
```

### 4. Green: Trim The Name Before Calling The API

Replace `workspace/src/code/load-greeting.ts` with:

```ts
import type { GreetingApi } from '../contracts/greeting-api';

export async function loadGreeting(name: string, api: GreetingApi) {
  const submittedName = name.trim();
  const response = await api.getGreeting(submittedName);

  return {
    submittedName,
    message: response.message,
  };
}
```

Run:

```bash
just check-tests
git add --all
git commit --message "4. Green: Trim The Name Before Calling The API"
```

### 5. Red: Return A Friendly Message When The API Is Unavailable

Replace `workspace/src/code/load-greeting.test.ts` with:

```ts
import { describe, expect, it, vi } from 'vitest';

import type { GreetingApi } from '../contracts/greeting-api';
import { loadGreeting } from './load-greeting';

describe('loadGreeting', () => {
  it('returns the personalized greeting for a non-empty name', async () => {
    const getGreeting = vi.fn().mockResolvedValue({ message: 'Hello, Ada!' });
    const api: GreetingApi = { getGreeting };

    const result = await loadGreeting('Ada', api);

    expect(getGreeting).toHaveBeenCalledWith('Ada');
    expect(result).toEqual({
      submittedName: 'Ada',
      message: 'Hello, Ada!',
    });
  });

  it('trims the name before calling the API', async () => {
    const getGreeting = vi.fn().mockResolvedValue({ message: 'Hello, Ada!' });
    const api: GreetingApi = { getGreeting };

    const result = await loadGreeting('  Ada  ', api);

    expect(getGreeting).toHaveBeenCalledWith('Ada');
    expect(result).toEqual({
      submittedName: 'Ada',
      message: 'Hello, Ada!',
    });
  });

  it('returns a friendly message when the API is unavailable', async () => {
    const getGreeting = vi.fn().mockRejectedValue(new Error('network error'));
    const api: GreetingApi = { getGreeting };

    const result = await loadGreeting('Ada', api);

    expect(getGreeting).toHaveBeenCalledWith('Ada');
    expect(result).toEqual({
      submittedName: 'Ada',
      message: 'Sorry, the greeting API is unavailable right now.',
    });
  });
});
```

Run:

```bash
just check-tests
git add --all
git commit --message "5. Red: Return A Friendly Message When The API Is Unavailable"
```

### 6. Green: Return A Friendly Message When The API Is Unavailable

Replace `workspace/src/code/load-greeting.ts` with:

```ts
import type { GreetingApi } from '../contracts/greeting-api';

export async function loadGreeting(name: string, api: GreetingApi) {
  const submittedName = name.trim();

  try {
    const response = await api.getGreeting(submittedName);

    return {
      submittedName,
      message: response.message,
    };
  } catch {
    return {
      submittedName,
      message: 'Sorry, the greeting API is unavailable right now.',
    };
  }
}
```

Run:

```bash
just check-tests
git add --all
git commit --message "6. Green: Return A Friendly Message When The API Is Unavailable"
```
