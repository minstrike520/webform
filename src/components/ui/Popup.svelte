<script lang="ts">
  import { onMount } from 'svelte';
  
  export let message: string;
  export let show: boolean = false;
  export let onFinish: () => void;

  let visible = false;
  
  $: if (show) {
    visible = true;
    setTimeout(() => {
      visible = false;
      onFinish();
    }, 1500); // ~1.4s in PDE
  }
</script>

{#if visible}
  <div class="popup" style="animation: fadeOut 1.5s forwards;">
    {message}
  </div>
{/if}

<style>
  .popup {
    position: fixed;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    background-color: #FF6464; /* Red */
    color: white;
    padding: 20px;
    border-radius: 10px;
    font-size: 16px;
    z-index: 1000;
    pointer-events: none;
    white-space: nowrap;
  }
  
  @keyframes fadeOut {
    0% { opacity: 1; }
    70% { opacity: 1; }
    100% { opacity: 0; }
  }
</style>
