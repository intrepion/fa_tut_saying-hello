import { experimental_AstroContainer as AstroContainer } from "astro/container";
import { describe, expect, it } from "vitest";

import IndexPage from "../pages/index.astro";

describe("index page", () => {
  it("renders the greeting form and API endpoint", async () => {
    const container = await AstroContainer.create();
    const result = await container.renderToString(IndexPage);

    expect(result).toContain("data-greeting-form");
    expect(result).toContain("data-greeting-name");
    expect(result).toContain("data-greeting-output");
    expect(result).toContain('data-api-base-url="http://localhost:25616"');
  });
});
