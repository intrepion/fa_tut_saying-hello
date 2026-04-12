import type { GreetingApi } from "../contracts/greeting-api";
import { loadGreeting } from "../code/load-greeting";

type BindGreetingFormOptions = {
  form: HTMLFormElement;
  nameInput: HTMLInputElement;
  output: HTMLElement;
  api: GreetingApi;
};

export function bindGreetingForm({
  form,
  nameInput,
  output,
  api,
}: BindGreetingFormOptions) {
  form.addEventListener("submit", async (event) => {
    event.preventDefault();

    const result = await loadGreeting(nameInput.value, api);
    output.textContent = result.message;
  });
}
