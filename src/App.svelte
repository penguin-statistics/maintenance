<script lang="ts">
  import { _ } from "svelte-i18n";
  import "./App.css";
</script>

<svelte:head>
  <title>{$_("title")} | {$_("brand")}</title>
</svelte:head>

<main>
  <img
    src="https://penguin.upyun.galvincdn.com/logos/penguin_stats_logo.png"
    alt="Penguin Statistics Logo"
  />
  <section class="content">
    <h5>
      {$_("brand")}
    </h5>

    <h2>
      <span>{$_("title")}</span>
    </h2>

    <h3>
      {$_("subtitle")}
    </h3>

    <p>
      {$_("description", {
        values: {
          startTime: new Date("2022-03-04T23:00:00+0800").toLocaleString(),
          endTime: new Date("2022-03-05T01:00:00+0800").toLocaleString(),
        },
      })}
    </p>
  </section>
</main>
