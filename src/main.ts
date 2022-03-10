import "./app.css";
import {
  addMessages,
  getLocaleFromNavigator,
  getLocaleFromQueryString,
  init,
} from "svelte-i18n";
import App from "./App.svelte";

import en from "./locales/en.json";
import zh from "./locales/zh.json";
import ja from "./locales/ja.json";

addMessages("en", en);
addMessages("zh", zh);
addMessages("ja", ja);

init({
  fallbackLocale: "en",
  initialLocale: getLocaleFromQueryString("lang") || getLocaleFromNavigator(),
});

const app = new App({
  target: document.getElementById("app"),
});

export default app;
