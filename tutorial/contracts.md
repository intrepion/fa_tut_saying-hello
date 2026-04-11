# Contracts

Create the shared contract files:

```bash
touch workspace/src/contracts/greeting-response.ts
touch workspace/src/contracts/greeting-api.ts
```

Put this exact content in `workspace/src/contracts/greeting-response.ts`:

```ts
export interface GreetingResponse {
  message: string;
}
```

Put this exact content in `workspace/src/contracts/greeting-api.ts`:

```ts
import type { GreetingResponse } from './greeting-response';

export interface GreetingApi {
  getGreeting(name: string): Promise<GreetingResponse>;
}
```

Do not add tests here. Keep this layer limited to interfaces and small shared types.

Then run:

```bash
git add --all
git commit --message "Define greeting contracts"
```
