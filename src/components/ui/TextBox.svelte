<script lang="ts">
  export let value: string;
  export let placeholder: string = "";
  export let onInput: (val: string) => void;

  function handleInput(e: Event) {
    const target = e.target as HTMLInputElement;
    value = target.value;
    onInput(value);
  }
</script>

<input 
  type="text" 
  {value} 
  {placeholder} 
  on:input={handleInput}
/>

<style>
  input {
    width: 300px;
    height: 40px;
    padding: 5px 10px;
    border: 1px solid #B4B4B4; /* Gray 180 */
    border-radius: 5px;
    background-color: #F5F5F5; /* Gray 245 */
    font-size: 1rem;
    outline: none;
    color: #000;
  }
  
  input:focus {
    border: 2px solid #6496FF;
    background-color: #FFFFFF;
  }
  
  input::placeholder {
    color: #969696; /* Gray 150 */
  }
</style>
