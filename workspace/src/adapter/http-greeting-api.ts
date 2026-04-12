import type { GreetingApi } from "../contracts/greeting-api";
import type { GreetingResponse } from "../contracts/greeting-response";

export class HttpGreetingApi implements GreetingApi {
  constructor(private readonly baseUrl: string) {}

  async getGreeting(name: string): Promise<GreetingResponse> {
    const url =
      name === ""
        ? `${this.baseUrl}/api/greeting`
        : `${this.baseUrl}/api/greeting?name=${encodeURIComponent(name)}`;

    const response = await fetch(url);

    return (await response.json()) as GreetingResponse;
  }
}
