import { afterEach, describe, expect, it, vi } from "vitest";

import { HttpGreetingApi } from "./http-greeting-api";

describe("HttpGreetingApi", () => {
  afterEach(() => {
    vi.unstubAllGlobals();
  });

  it("requests the canonical greeting endpoint", async () => {
    const fetchMock = vi.fn().mockResolvedValue({
      json: vi.fn().mockResolvedValue({ message: "Hello, Ada!" }),
    });
    vi.stubGlobal("fetch", fetchMock);

    const api = new HttpGreetingApi("http://localhost:25616");
    const result = await api.getGreeting("Ada");

    expect(fetchMock).toHaveBeenCalledWith(
      "http://localhost:25616/api/greeting?name=Ada",
    );
    expect(result).toEqual({ message: "Hello, Ada!" });
  });
});
