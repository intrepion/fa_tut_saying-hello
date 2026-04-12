import { describe, expect, it, vi } from "vitest";

import type { GreetingApi } from "../contracts/greeting-api";
import { loadGreeting } from "./load-greeting";

describe("loadGreeting", () => {
  it("returns the personalized greeting for a non-empty name", async () => {
    const getGreeting = vi.fn().mockResolvedValue({ message: "Hello, Ada!" });
    const api: GreetingApi = { getGreeting };

    const result = await loadGreeting("Ada", api);

    expect(getGreeting).toHaveBeenCalledWith("Ada");
    expect(result).toEqual({
      submittedName: "Ada",
      message: "Hello, Ada!",
    });
  });
});
