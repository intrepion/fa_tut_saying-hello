import type { GreetingApi } from '../contracts/greeting-api';

export async function loadGreeting(name: string, api: GreetingApi) {
    const submittedName = name.trim();
    const response = await api.getGreeting(submittedName);

    return {
        submittedName,
        message: response.message,
    };
}
