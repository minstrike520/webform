<script lang="ts">
  export let title: string;
  export let options: string[];
  export let selectedValue: string = "";
  export let onSelect: (val: string) => void;
</script>

<div class="menu">
  <div class="title">{title}</div>
  <div class="options">
    {#each options as option}
      <button 
        class="option" 
        class:selected={selectedValue === option}
        on:click={() => onSelect(option)}
      >
        <span>{option}</span>
        {#if selectedValue === option}
          <div class="indicator"></div>
        {/if}
      </button>
    {/each}
  </div>
</div>

<style>
  .menu {
    width: 300px;
    background-color: #F0F0F0;
    border: 1px solid #ccc;
    border-radius: 5px;
    overflow: hidden;
  }
  
  .title {
    background-color: #C8C8C8; /* Gray 200 */
    color: black;
    padding: 10px;
    text-align: center;
    font-weight: bold;
  }
  
  .options {
    display: flex;
    flex-direction: column;
  }
  
  .option {
    border: none;
    background: none;
    padding: 10px 15px;
    text-align: left;
    cursor: pointer;
    display: flex;
    justify-content: space-between;
    align-items: center;
    font-size: 1rem;
    transition: background-color 0.2s;
  }
  
  .option:hover {
    background-color: #DCDCDC; /* Gray 220 */
  }
  
  .option.selected {
    background-color: #6496FF;
    color: white;
  }
  
  .indicator {
    width: 10px;
    height: 10px;
    background-color: white;
    border-radius: 50%;
  }
</style>
