import type { APIRoute } from 'astro';
import { SHEET_CONFIG } from '../../types';
import { parseGoogleSheetCSV } from '../../utils/csv';

export const GET: APIRoute = async ({ request }) => {
  const url = new URL(request.url);
  const tq = url.searchParams.get('tq') || '';
  
  const googleSheetUrl = `${SHEET_CONFIG.url}?tqx=out:csv&gid=${SHEET_CONFIG.gid}&tq=${encodeURIComponent(tq)}`;

  try {
    const response = await fetch(googleSheetUrl);
    const csvForParsing = await response.text();
    
    // Check for Google Viz API specific errors in response which sometimes come as JSON even if we asked for CSV?
    // Actually with tqx=out:csv, it usually returns CSV. If error, might be HTML.
    
    if (csvForParsing.includes('"status":"error"')) {
         return new Response(JSON.stringify({ error: "Query Error" }), { status: 400 });
    }

    const data = parseGoogleSheetCSV(csvForParsing);
    
    return new Response(JSON.stringify(data), {
      status: 200,
      headers: {
        "Content-Type": "application/json"
      }
    });
  } catch (error) {
    return new Response(JSON.stringify({ error: String(error) }), { status: 500 });
  }
}
