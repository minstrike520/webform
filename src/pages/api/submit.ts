import type { APIRoute } from 'astro';
import { FORM_CONFIG } from '../../types';

export const POST: APIRoute = async ({ request }) => {
  try {
    const data = await request.json();
    
    // Construct URLSearchParams for form submission
    const formData = new URLSearchParams();
    
    if (data.name) formData.append(FORM_CONFIG.fields.name, data.name);
    if (data.meal) formData.append(FORM_CONFIG.fields.meal, data.meal);
    if (data.sup) formData.append(FORM_CONFIG.fields.sup, data.sup);
    
    if (data.other && Array.isArray(data.other)) {
      data.other.forEach((item: string) => {
        formData.append(FORM_CONFIG.fields.other, item);
      });
    }

    const response = await fetch(FORM_CONFIG.url, {
      method: 'POST',
      body: formData,
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
      },
    });

    // Google Forms returns HTML, but status 200 usually means success if it didn't redirect to an error page.
    if (response.ok) {
      return new Response(JSON.stringify({ success: true }), { status: 200 });
    } else {
      return new Response(JSON.stringify({ success: false, error: "Form submission failed" }), { status: 500 });
    }
  } catch (error) {
    return new Response(JSON.stringify({ success: false, error: String(error) }), { status: 500 });
  }
}
