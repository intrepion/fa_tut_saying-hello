// @vitest-environment jsdom

import { describe, expect, it, vi } from "vitest";

import type { GreetingApi } from "../contracts/greeting-api";
import { bindGreetingForm } from "./bind-greeting-form";

describe("bindGreetingForm", () => {
  it("renders the greeting returned by the API", async () => {
    document.body.innerHTML = `
      <form data-greeting-form>
        <input data-greeting-name />
        <button type="submit">Say hello</button>
      </form>
      <p data-greeting-output></p>
    `;

    const form = document.querySelector(
      "[data-greeting-form]",
    ) as HTMLFormElement;
    const nameInput = document.querySelector(
      "[data-greeting-name]",
    ) as HTMLInputElement;
    const output = document.querySelector(
      "[data-greeting-output]",
    ) as HTMLParagraphElement;
    const getGreeting = vi.fn().mockResolvedValue({ message: "Hello, Ada!" });
    const api: GreetingApi = { getGreeting };

    bindGreetingForm({ form, nameInput, output, api });

    nameInput.value = "Ada";
    form.dispatchEvent(
      new Event("submit", { bubbles: true, cancelable: true }),
    );
    await new Promise((resolve) => setTimeout(resolve, 0));

    expect(getGreeting).toHaveBeenCalledWith("Ada");
    expect(output.textContent).toBe("Hello, Ada!");
  });
});
