import java.net.URLEncoder;
import http.requests.*;

void sendForm(String field1, String field2, String field3, ArrayList<String> field4) {
  String sendFormURL= "https://docs.google.com/forms/d/15NThyl3vImadD4loZVEUc3soHBk503x6r5VunxZSZS0/formResponse"
    + "?entry.314876968=" + URLEncoder.encode(field1)
    + "&entry.1329149830=" + URLEncoder.encode(field2) 
    + "&entry.1843446166=" + URLEncoder.encode(field3);
  for (int i = 0; i < field4.size(); i++) {
    sendFormURL += "&entry.1253873200=" + URLEncoder.encode(field4.get(i));
  }
  sendFormURL.replace(" ", "%20");
  print("Opening URL in your browser:", sendFormURL);
  link(sendFormURL);
  // PostRequest postRequest = new PostRequest(sendFormURL);
  // postRequest.send();
  // print(postRequest);
}
