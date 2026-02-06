<script lang="ts">
  export let headers: string[];
  export let data: string[][];
  export let columnWidths: number[]; // Ratios
</script>

<div class="table-container">
  <div class="table-header">
    {#each headers as header, i}
      <div class="header-cell" style="flex: {columnWidths[i]}">
        {header}
      </div>
    {/each}
  </div>
  
  <div class="table-body">
    {#if data.length === 0}
      <div class="no-data">No Data</div>
    {:else}
      {#each data as row}
        <div class="table-row">
          {#each row as cell, i}
            <div class="cell" style="flex: {columnWidths[i]}">
              {cell}
            </div>
          {/each}
        </div>
      {/each}
    {/if}
  </div>
</div>

<style>
  .table-container {
    display: flex;
    flex-direction: column;
    border: 1px solid #ccc;
    height: 100%;
    background-color: white;
    overflow: hidden;
  }
  
  .table-header {
    display: flex;
    background-color: #DCDCDC; /* Gray 220 */
    border-bottom: 1px solid #999;
    /* To account for scrollbar width in header alignment if body scrolls? 
       In simple RWD Flexbox, scrolling happens in body. */
    padding-right: 5px; /* rough scrollbar compensation */
  }
  
  .header-cell {
    padding: 10px 5px;
    font-weight: bold;
    text-align: center;
    border-right: 1px solid #bbb;
    overflow: hidden;
    text-overflow: ellipsis;
    white-space: nowrap;
  }
  
  .table-body {
    overflow-y: auto;
    flex: 1;
  }
  
  .table-row {
    display: flex;
    border-bottom: 1px solid #eee;
  }
  
  .cell {
    padding: 5px;
    text-align: center;
    border-right: 1px solid #eee;
    overflow: hidden;
    text-overflow: ellipsis;
    white-space: nowrap;
    font-size: 0.9rem;
  }
  
  .no-data {
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100%;
    color: #999;
    font-size: 2rem;
  }
  
  /* Custom Scrollbar to match PDE roughly (simple gray) */
  .table-body::-webkit-scrollbar {
    width: 10px;
  }
  
  .table-body::-webkit-scrollbar-track {
    background: #f1f1f1; 
  }
   
  .table-body::-webkit-scrollbar-thumb {
    background: #888; 
    border-radius: 5px;
  }
  
  .table-body::-webkit-scrollbar-thumb:hover {
    background: #555; 
  }
</style>
