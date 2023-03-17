<script lang="ts">
  import { _ } from "svelte-i18n";
  import "./App.css";

  const startTime = new Date("2023-03-17T15:00:00-0700");
  const endTime = new Date("2023-03-17T20:00:00-0700");
  const extendedEndTime = new Date("2023-03-17T20:00:00-0700");

  // schedule an automatic refresh after the event ends
  const absoluteDelay = (() => {
    const delay = extendedEndTime.getTime() - Date.now();
    if (delay < 1000 * 60) {
      return 1000 * 60; // ensure at least 1 minute delay
    }
    return delay;
  })();
  const randomizedDelay = absoluteDelay + Math.random() * 1000 * 60;
  console.log(
    "Scheduled refresh in " +
      Math.ceil(randomizedDelay / 1000) +
      " seconds (at " +
      new Date(Date.now() + randomizedDelay).toLocaleString() +
      ")."
  );
  setTimeout(() => {
    location.reload();
  }, randomizedDelay);

  const dateFormatOptions: Intl.DateTimeFormatOptions = {
    dateStyle: "short",
    timeStyle: "short",
  };

  const descriptionValues = {
    startTime: startTime.toLocaleString(undefined, dateFormatOptions),
    elapsingHours: Math.ceil(
      (endTime.getTime() - startTime.getTime()) / 1000 / 60 / 60
    ),
    endTime: endTime.toLocaleString(undefined, dateFormatOptions),
    extendedEndTime: extendedEndTime.toLocaleString(
      undefined,
      dateFormatOptions
    ),
  };
</script>

<svelte:head>
  <title>{$_("title")} | {$_("brand")}</title>
</svelte:head>

<main>
  <img
    src="https://penguin.upyun.galvincdn.com/logos/penguin_stats_logo.png"
    alt="Penguin Statistics Logo"
    class="logo"
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

    {#each $_("description", { values: descriptionValues }).split("\n") as line}
      <p>
        <!-- print the raw html value -->
        {@html line}
      </p>
    {/each}

    <div class="contact">
      <a
        href="https://twitter.com/penguin_stats"
        target="_blank"
        rel="noopener noreferrer"
      >
        <svg role="img" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"
          ><title>Twitter</title><path
            d="M23.953 4.57a10 10 0 01-2.825.775 4.958 4.958 0 002.163-2.723c-.951.555-2.005.959-3.127 1.184a4.92 4.92 0 00-8.384 4.482C7.69 8.095 4.067 6.13 1.64 3.162a4.822 4.822 0 00-.666 2.475c0 1.71.87 3.213 2.188 4.096a4.904 4.904 0 01-2.228-.616v.06a4.923 4.923 0 003.946 4.827 4.996 4.996 0 01-2.212.085 4.936 4.936 0 004.604 3.417 9.867 9.867 0 01-6.102 2.105c-.39 0-.779-.023-1.17-.067a13.995 13.995 0 007.557 2.209c9.053 0 13.998-7.496 13.998-13.985 0-.21 0-.42-.015-.63A9.935 9.935 0 0024 4.59z"
            fill="currentColor"
          /></svg
        >
      </a>

      <a
        href="https://discord.gg/uEXJcue"
        target="_blank"
        rel="noopener noreferrer"
      >
        <svg role="img" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"
          ><title>Discord</title><path
            d="M20.317 4.3698a19.7913 19.7913 0 00-4.8851-1.5152.0741.0741 0 00-.0785.0371c-.211.3753-.4447.8648-.6083 1.2495-1.8447-.2762-3.68-.2762-5.4868 0-.1636-.3933-.4058-.8742-.6177-1.2495a.077.077 0 00-.0785-.037 19.7363 19.7363 0 00-4.8852 1.515.0699.0699 0 00-.0321.0277C.5334 9.0458-.319 13.5799.0992 18.0578a.0824.0824 0 00.0312.0561c2.0528 1.5076 4.0413 2.4228 5.9929 3.0294a.0777.0777 0 00.0842-.0276c.4616-.6304.8731-1.2952 1.226-1.9942a.076.076 0 00-.0416-.1057c-.6528-.2476-1.2743-.5495-1.8722-.8923a.077.077 0 01-.0076-.1277c.1258-.0943.2517-.1923.3718-.2914a.0743.0743 0 01.0776-.0105c3.9278 1.7933 8.18 1.7933 12.0614 0a.0739.0739 0 01.0785.0095c.1202.099.246.1981.3728.2924a.077.077 0 01-.0066.1276 12.2986 12.2986 0 01-1.873.8914.0766.0766 0 00-.0407.1067c.3604.698.7719 1.3628 1.225 1.9932a.076.076 0 00.0842.0286c1.961-.6067 3.9495-1.5219 6.0023-3.0294a.077.077 0 00.0313-.0552c.5004-5.177-.8382-9.6739-3.5485-13.6604a.061.061 0 00-.0312-.0286zM8.02 15.3312c-1.1825 0-2.1569-1.0857-2.1569-2.419 0-1.3332.9555-2.4189 2.157-2.4189 1.2108 0 2.1757 1.0952 2.1568 2.419 0 1.3332-.9555 2.4189-2.1569 2.4189zm7.9748 0c-1.1825 0-2.1569-1.0857-2.1569-2.419 0-1.3332.9554-2.4189 2.1569-2.4189 1.2108 0 2.1757 1.0952 2.1568 2.419 0 1.3332-.946 2.4189-2.1568 2.4189Z"
            fill="currentColor"
          /></svg
        >
      </a>

      <a
        href="https://space.bilibili.com/679016511/dynamic"
        target="_blank"
        rel="noopener noreferrer"
      >
        <svg role="img" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"
          ><title>Bilibili</title><path
            d="M17.813 4.653h.854c1.51.054 2.769.578 3.773 1.574 1.004.995 1.524 2.249 1.56 3.76v7.36c-.036 1.51-.556 2.769-1.56 3.773s-2.262 1.524-3.773 1.56H5.333c-1.51-.036-2.769-.556-3.773-1.56S.036 18.858 0 17.347v-7.36c.036-1.511.556-2.765 1.56-3.76 1.004-.996 2.262-1.52 3.773-1.574h.774l-1.174-1.12a1.234 1.234 0 0 1-.373-.906c0-.356.124-.658.373-.907l.027-.027c.267-.249.573-.373.92-.373.347 0 .653.124.92.373L9.653 4.44c.071.071.134.142.187.213h4.267a.836.836 0 0 1 .16-.213l2.853-2.747c.267-.249.573-.373.92-.373.347 0 .662.151.929.4.267.249.391.551.391.907 0 .355-.124.657-.373.906zM5.333 7.24c-.746.018-1.373.276-1.88.773-.506.498-.769 1.13-.786 1.894v7.52c.017.764.28 1.395.786 1.893.507.498 1.134.756 1.88.773h13.334c.746-.017 1.373-.275 1.88-.773.506-.498.769-1.129.786-1.893v-7.52c-.017-.765-.28-1.396-.786-1.894-.507-.497-1.134-.755-1.88-.773zM8 11.107c.373 0 .684.124.933.373.25.249.383.569.4.96v1.173c-.017.391-.15.711-.4.96-.249.25-.56.374-.933.374s-.684-.125-.933-.374c-.25-.249-.383-.569-.4-.96V12.44c0-.373.129-.689.386-.947.258-.257.574-.386.947-.386zm8 0c.373 0 .684.124.933.373.25.249.383.569.4.96v1.173c-.017.391-.15.711-.4.96-.249.25-.56.374-.933.374s-.684-.125-.933-.374c-.25-.249-.383-.569-.4-.96V12.44c.017-.391.15-.711.4-.96.249-.249.56-.373.933-.373Z"
            fill="currentColor"
          /></svg
        >
      </a>
    </div>
  </section>
</main>
