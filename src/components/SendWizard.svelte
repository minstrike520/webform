<script lang="ts">
  import { MEAL_OPTIONS, SUP_OPTIONS, OTHER_OPTIONS, type OrderForm } from '../types';
  import Button from './ui/Button.svelte';
  import PageIndicator from './ui/PageIndicator.svelte';
  import TextBox from './ui/TextBox.svelte';
  import SingleSelectMenu from './ui/SingleSelectMenu.svelte';
  import MultiSelectMenu from './ui/MultiSelectMenu.svelte';
  import Popup from './ui/Popup.svelte';
  
  export let onBackHome: () => void;

  let step = 1;
  let form: OrderForm = {
    name: "",
    meal: "",
    sup: "",
    other: []
  };

  let popupMessage = "";
  let showPopup = false;

  function nextStep() {
    if (step < 4) {
      step++;
    } else {
      submitForm();
    }
  }

  function prevStep() {
    if (step > 1) {
      step--;
    } else {
      onBackHome();
    }
  }

  async function submitForm() {
    // Validation
    if (!form.name || !form.meal || !form.sup) {
      popupMessage = "警告：欄位尚未填寫完畢";
      showPopup = true;
      return;
    }

    try {
      const res = await fetch('/api/submit', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(form)
      });
      
      if (res.ok) {
        popupMessage = "發送成功";
        showPopup = true;
        // Wait for popup animation then go home
        setTimeout(() => {
          onBackHome();
        }, 1500);
      } else {
        popupMessage = "發送失敗";
        showPopup = true;
      }
    } catch (e) {
      popupMessage = "發送錯誤";
      showPopup = true;
    }
  }
</script>

<div class="wizard-container">
  <div class="content">
    {#if step === 1}
      <div class="step-content">
        <h2>Enter Name</h2>
        <TextBox 
          placeholder="Enter your English name" 
          value={form.name} 
          onInput={(val) => form.name = val} 
        />
      </div>
    {:else if step === 2}
      <div class="step-content">
        <SingleSelectMenu 
          title="選擇餐點" 
          options={MEAL_OPTIONS} 
          selectedValue={form.meal}
          onSelect={(val) => form.meal = val}
        />
      </div>
    {:else if step === 3}
      <div class="step-content">
        <SingleSelectMenu 
          title="選擇附餐" 
          options={SUP_OPTIONS} 
          selectedValue={form.sup}
          onSelect={(val) => form.sup = val}
        />
      </div>
    {:else if step === 4}
      <div class="step-content">
        <MultiSelectMenu 
          title="其他選項 (可選)" 
          options={OTHER_OPTIONS} 
          selectedValues={form.other}
          onSelect={(vals) => form.other = vals}
        />
      </div>
    {/if}
  </div>

  <PageIndicator currentPage={step} totalPages={4} />

  <div class="controls">
    <Button 
      label={step === 1 ? "返回" : "上一步"} 
      onClick={prevStep} 
      color="#C8C8C8" 
    />
    <Button 
      label={step === 4 ? "發送" : "下一步"} 
      onClick={nextStep} 
      color={step === 4 ? "#64FF96" : "#6496FF"} 
    />
  </div>
  
  <Popup 
    message={popupMessage} 
    show={showPopup} 
    onFinish={() => { showPopup = false; }} 
  />
</div>

<style>
  .wizard-container {
    display: flex;
    flex-direction: column;
    height: 100%;
    padding: 20px;
    box-sizing: border-box;
    justify-content: space-between;
  }

  .content {
    flex: 1;
    display: flex;
    justify-content: center;
    align-items: center; /* Center content vertically and horizontally */
  }
  
  .step-content {
    display: flex;
    flex-direction: column;
    align-items: center;
    gap: 20px;
  }
  
  h2 {
    font-size: 1.5rem;
    color: #555;
  }

  .controls {
    display: flex;
    justify-content: space-between;
    margin-top: 20px;
    /* Simulate the corners layout of PDE */
    width: 100%; 
  }
</style>
