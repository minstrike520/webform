<script lang="ts">
  export let currentPage: number; // 1 to 4
  export let totalPages: number = 4;
</script>

<div class="indicator">
  {#each Array(totalPages) as _, i}
    <div 
      class="dot" 
      class:active={i + 1 === currentPage}
    ></div>
  {/each}
</div>

<style>
  .indicator {
    display: flex;
    gap: 10px;
    justify-content: center;
    margin-top: 20px;
  }
  
  .dot {
    width: 10px;
    height: 10px;
    border-radius: 50%;
    background-color: #DCDCDC; /* Gray 220 */
    transition: background-color 0.3s;
  }
  
  .dot.active {
    background-color: #888; /* Darker gray for active */
  }
</style>
