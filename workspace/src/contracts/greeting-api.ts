import type { GreetingResponse } from './greeting-response';

export interface GreetingApi {
    getGreeting(name: string): Promise<GreetingResponse>;
}
