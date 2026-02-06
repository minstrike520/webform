export function parseGoogleSheetCSV(csvContent: string): string[][] {
  const result: string[][] = [];
  
  // Basic CSV parser that handles quoted strings with commas
  // This mimics the logic in the original PDE or a standard CSV parser
  let currentRow: string[] = [];
  let currentVal = "";
  let insideQuote = false;
  
  for (let i = 0; i < csvContent.length; i++) {
    const char = csvContent[i];
    
    if (insideQuote) {
      if (char === '"') {
        // checks for double double quotes (escape) - typical CSV
        if (i + 1 < csvContent.length && csvContent[i+1] === '"') {
          currentVal += '"';
          i++; // skip next quote
        } else {
          insideQuote = false;
        }
      } else {
        currentVal += char;
      }
    } else {
      if (char === '"') {
        insideQuote = true;
      } else if (char === ',') {
        currentRow.push(currentVal);
        currentVal = "";
      } else if (char === '\n' || char === '\r') {
        if (currentVal || currentRow.length > 0) {
            currentRow.push(currentVal);
            result.push(currentRow);
            currentRow = [];
            currentVal = "";
        }
        // Handle \r\n
        if (char === '\r' && i + 1 < csvContent.length && csvContent[i+1] === '\n') {
          i++;
        }
      } else {
        currentVal += char;
      }
    }
  }
  
  if (currentVal || currentRow.length > 0) {
    currentRow.push(currentVal);
    result.push(currentRow);
  }

  // The first row might be headers or metadata depending on the query output
  return result;
}
