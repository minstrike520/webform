<script lang="ts">
  import { onMount } from 'svelte';
  import ScrollableTable from './ui/ScrollableTable.svelte';
  import Button from './ui/Button.svelte';
  import TextBox from './ui/TextBox.svelte';
  import Popup from './ui/Popup.svelte';
  
  export let onBackHome: () => void;

  let data: string[][] = [];
  let inputValue = "";
  let loading = false;
  
  // Ratios: 3, 2, 2, 1, 2
  const headers = ["時間戳記", "姓名", "餐點", "附餐", "其他選項"];
  const colWidths = [3, 2, 2, 1, 2];

  let popupMessage = "";
  let showPopup = false;

  async function runQuery(tq: string) {
    loading = true;
    try {
      const res = await fetch(`/api/query?tq=${encodeURIComponent(tq)}`);
      // tq-problem resolved -> was due to SSR context
      const json = await res.json();
      
      if (res.ok) {
        // The first row of Google Sheets CSV output is usually the header names (internal names)
        // or just data if we manipulate it.
        // Google Viz API usually returns headers in the first row.
        // We want to skip headers if they match our expectation or just display what we get.
        // The PDE code `querySheet` parses everything. ScrollableTable sets headers manually.
        // So we should assume `data` contains rows starting from data.
        // But Google Viz output includes headers row. Let's slice it if needed or just show it.
        // Actually, let's strictly follow PDE: it calls `table.clearData()` then `table.importCSV`.
        // `importCSV` matches headers. But `table.setHeaders` is called in `setup`.
        // So we probably want to display the data rows.
        
        // Let's exclude the first row if it looks like headers?
        // Or better, let's keep it simple: just show what we get for now, users can see.
        data = json; 
      } else {
        popupMessage = "查詢錯誤: " + (json.error || "Unknown");
        showPopup = true;
      }
    } catch (e) {
      popupMessage = "網路錯誤";
      showPopup = true;
    } finally {
      loading = false;
    }
  }

  function handleAll() {
    runQuery("");
  }

  function handleLast() {
    runQuery("select * order by A desc limit 1");
  }

  function handleFrom() {
    if (!inputValue) {
      popupMessage = "請輸入姓名";
      showPopup = true;
      return;
    }
    // Column E is usually the Name column in such sheets?
    // Wait, let's check PDE. `select * where E = ...`. 
    // In our `OrderForm`, Name is field 1. 
    // Timestamp is A.
    // If we assume typical Google Form sheet:
    // A: Timestamp
    // B: Name (entry.314876968) ?
    // C: Meal ?
    // D: Sup ? 
    // E: Other ?
    // The PDE code says `select * where E = ...`. 
    // Maybe "Other" is column E? Or maybe Name is E?
    // Let's assume the PDE logic is correct for the specific sheet structure. 
    // If the user wants to search by Name, and Name is in some column.
    // Quote from PDE: `String q = "select * where E = \'" + queryPageTextBox.text + "\' order by A desc";`
    // So it queries column E using the textbox value.
    runQuery(`select * where E = '${inputValue}' order by A desc`);
  }

  function handleCustom() {
    if (!inputValue) {
      popupMessage = "請輸入查詢語句";
      showPopup = true;
      return;
    }
    runQuery(inputValue);
  }

  onMount(() => {
    // Maybe load all on start? PDE doesn't seem to autoload, it waits for button click.
    // Actually `table` is empty initially.
  });
</script>

<div class="query-container">
  <div class="main-area">
    <div class="table-wrapper">
      <ScrollableTable {headers} {data} columnWidths={colWidths} />
      {#if loading}
        <div class="loading-overlay">
           Loading...
        </div>
      {/if}
    </div>
    
    <div class="input-area">
      <TextBox 
        placeholder="Enter query / name" 
        value={inputValue} 
        onInput={(v) => inputValue = v}
      />
    </div>
  </div>

  <div class="sidebar">
    <Button label="返回" onClick={onBackHome} color="#C8C8C8" /> <!-- Gray -->
    <Button label="全部" onClick={handleAll} color="#6496C8" /> <!-- Light Blue -->
    <Button label="最後一筆" onClick={handleLast} color="#6496C8" />
    <Button label="來自" onClick={handleFrom} color="#C89664" /> <!-- Brown-ish -->
    <Button label="自訂" onClick={handleCustom} color="#C89664" />
  </div>

  <Popup 
    message={popupMessage} 
    show={showPopup} 
    onFinish={() => { showPopup = false; }} 
  />
</div>

<style>
  .query-container {
    display: flex;
    height: 100%;
    gap: 20px;
    padding: 20px;
    box-sizing: border-box;
  }

  .main-area {
    flex: 1;
    display: flex;
    flex-direction: column;
    gap: 20px;
    min-width: 0; /* Fix flex overflow */
  }

  .table-wrapper {
    flex: 1;
    position: relative;
    min-height: 200px;
  }
  
  .loading-overlay {
    position: absolute;
    top: 0; left: 0; right: 0; bottom: 0;
    background: rgba(255,255,255,0.7);
    display: flex;
    justify-content: center;
    align-items: center;
    color: black;
    font-weight: bold;
  }

  .input-area {
    height: 50px;
    display: flex;
    align-items: center;
  }

  .sidebar {
    width: 150px;
    display: flex;
    flex-direction: column;
    gap: 15px;
    justify-content: flex-start;
  }
</style>
