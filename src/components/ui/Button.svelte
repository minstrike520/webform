<script lang="ts">
  export let label: string;
  export let color: string = "#6496FF"; // Default Blue
  export let onClick: () => void;
  export let disabled: boolean = false;
  
  // Calculate a slightly darker color for hover using CSS filters or just opacity
</script>

<button 
  on:click={onClick} 
  class="btn" 
  style="--btn-color: {color};"
  {disabled}
>
  {label}
</button>

<style>
  .btn {
    background-color: var(--btn-color);
    color: white;
    border: none;
    border-radius: 10px;
    padding: 10px 20px;
    font-size: 1.25rem; /* 20px */
    font-weight: bold;
    cursor: pointer;
    transition: filter 0.2s;
    display: flex;
    justify-content: center;
    align-items: center;
    min-width: 120px;
    height: 50px;
  }

  .btn:hover:not(:disabled) {
    filter: brightness(0.8);
  }

  .btn:disabled {
    opacity: 0.5;
    cursor: not-allowed;
  }
</style>
