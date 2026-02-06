<script lang="ts">
  export let title: string;
  export let options: string[];
  export let selectedValues: string[] = [];
  export let onSelect: (vals: string[]) => void;

  function toggle(option: string) {
    let newValues;
    if (selectedValues.includes(option)) {
      newValues = selectedValues.filter(v => v !== option);
    } else {
      newValues = [...selectedValues, option];
    }
    onSelect(newValues);
  }
</script>

<div class="menu">
  <div class="title">{title}</div>
  <div class="options">
    {#each options as option}
      <button 
        class="option" 
        class:selected={selectedValues.includes(option)}
        on:click={() => toggle(option)}
      >
        <span>{option}</span>
        {#if selectedValues.includes(option)}
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
  
  /* MultiSelect doesn't change background on select, only the indicator, according to PDE logic (implied green square) */
  /* Wait, PDE code says: if selected, draw green rect. The row background acts normal? */
  /* Re-reading PDE: MultiSelectMenu.display: if (selected[i]) fill(100, 255, 150) -> This is the indicator box */
  /* The row itself doesn't turn blue like SingleSelect. */
  
  .indicator {
    width: 15px;
    height: 15px;
    background-color: #64FF96; /* Green */
    /* border-radius: 0; Square */
  }
</style>
