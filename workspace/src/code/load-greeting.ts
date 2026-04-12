import type { GreetingApi } from "../contracts/greeting-api";

export async function loadGreeting(name: string, api: GreetingApi) {
  const response = await api.getGreeting(name);

  return {
    submittedName: name,
    message: response.message,
  };
}
