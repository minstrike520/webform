<script lang="ts">
  import Button from './ui/Button.svelte';

  export let onSend: () => void;
  export let onQuery: () => void;
</script>

<div class="home-container">
  <div class="header">
    <div class="student-info">41347060S 楊銘煌</div>
    <h1 class="title">訂餐系統</h1>
  </div>
  
  <div class="actions">
    <Button label="發送" onClick={onSend} color="#6496FF" />
    <Button label="查詢" onClick={onQuery} color="#64FF96" />
  </div>
</div>

<style>
  .home-container {
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    height: 100%;
    gap: 50px;
  }

  .header {
    text-align: center;
  }

  .student-info {
    font-size: 1.2rem;
    color: #555;
    margin-bottom: 10px;
  }

  .title {
    font-size: 3rem;
    font-weight: bold;
    color: black;
  }

  .actions {
    display: flex;
    gap: 40px;
  }
</style>
