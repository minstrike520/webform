<script lang="ts">
  import { UIStat } from '../types';
  import Home from './Home.svelte';
  import SendWizard from './SendWizard.svelte';
  import QueryPage from './QueryPage.svelte';
  
  let uiStat = UIStat.HOME;

  function goHome() {
    uiStat = UIStat.HOME;
  }
  
  function goSend() {
    uiStat = UIStat.SEND_1; // Wizard handles the steps, but technically App could pass "1"
    // Since SendWizard manages its own step state internally (simpler for Svelte),
    // we just switch to the Wizard component.
    // If we wanted to strictly follow PDE `UIStat`, we would pass step to Wizard.
    // But Wizard component is cleaner if self-contained.
  }
  
  function goQuery() {
    uiStat = UIStat.QUERY;
  }
</script>

<main class="app-container">
  {#if uiStat === UIStat.HOME}
    <Home onSend={goSend} onQuery={goQuery} />
  {:else if uiStat === UIStat.QUERY}
    <QueryPage onBackHome={goHome} />
  {:else}
    <!-- Send Wizard covers SEND_1 to SEND_4 states -->
    <SendWizard onBackHome={goHome} />
  {/if}
</main>

<style>
  .app-container {
    width: 100%;
    max-width: 800px;
    height: 100vh;
    max-height: 600px; /* Keep the aspect ratio feel but responsive below */
    background-color: #F0F0F0; /* Gray 240 */
    position: relative;
    overflow: hidden;
    box-shadow: 0 0 20px rgba(0,0,0,0.1);
    
    /* Center in viewport if screen is large */
    margin: 0 auto;
  }
  
  @media (min-height: 650px) {
    .app-container {
        margin-top: 25px; /* some spacing */
        height: 600px;
        border-radius: 4px;
    }
  }
</style>
