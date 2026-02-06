import type { APIRoute } from 'astro';
import { SHEET_CONFIG } from '../../types';
import { parseGoogleSheetCSV } from '../../utils/csv';

export const GET: APIRoute = async ({ url }) => {
  const tqParams = url.searchParams.get('tq');
  const tq = tqParams === null ? '' : tqParams;
  
  // Replace %20 with + for Google API compatibility as some versions prefer + for spaces in query params
  // Also encodeURIComponent handles most things correctly but sometimes Google's parser is picky
  // Note: We encodeURIComponent first, then replace %20 with +.
  const encodedTq = encodeURIComponent(tq).replace(/%20/g, '+');
  
  const googleSheetUrl = `${SHEET_CONFIG.url}?tqx=out:csv&gid=${SHEET_CONFIG.gid}&tq=${encodedTq}`;
  
  try {
    const response = await fetch(googleSheetUrl);
    const csvForParsing = await response.text();
    
    // Check for Google Viz API specific errors
    if (csvForParsing.includes('"status":"error"')) {
         return new Response(JSON.stringify({ error: "Query Error" }), { status: 400 });
    }

    const data = parseGoogleSheetCSV(csvForParsing);
    
    // Expose debug headers to help diagnose query issues
    return new Response(JSON.stringify(data), {
      status: 200,
      headers: {
        "Content-Type": "application/json",
        "X-Debug-TQ-Received": encodeURIComponent(tq), // Encode to prevent header issues with non-ascii
        "X-Debug-Google-Url": encodeURI(googleSheetUrl)
      }
    });
  } catch (error) {
    return new Response(JSON.stringify({ error: String(error) }), { status: 500 });
  }
}
