import { addMessages, getLocaleFromNavigator, init } from "svelte-i18n";
import App from "./App.svelte";

import en from "./locales/en.json";
import zh from "./locales/zh.json";

addMessages("en", en);
addMessages("zh", zh);

init({
  fallbackLocale: "en",
  initialLocale: getLocaleFromNavigator(),
});

const app = new App({
  target: document.getElementById("app"),
});

export default app;
