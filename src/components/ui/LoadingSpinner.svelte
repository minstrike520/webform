<script lang="ts">
  export let size: number = 80;
  export let color: string = "#6496FF";
</script>

<div 
  class="spinner" 
  style="
    width: {size}px; 
    height: {size}px; 
    border-color: {color};
    border-width: {size/10}px;
  "
></div>

<style>
  .spinner {
    border-style: solid;
    border-radius: 50%;
    border-bottom-color: transparent; /* Create the arc effect */
    animation: spin 1s linear infinite;
  }
  
  @keyframes spin {
    0% { transform: rotate(0deg); }
    100% { transform: rotate(360deg); }
  }
</style>
