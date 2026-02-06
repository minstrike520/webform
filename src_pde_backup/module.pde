PFont TCFont;

// UI 狀態定義
final int UI_NONE = 0;
final int UI_HOME = 1;
final int UI_SEND_1 = 2;
final int UI_SEND_2 = 3;
final int UI_SEND_3 = 4;
final int UI_SEND_4 = 5;
final int UI_QUERY = 6;

int uiStat = UI_HOME;

final int QSPEC_NONE = 0;
final int QSPEC_USER = 1;
final int QSPEC_CUSTOM = 2;

int qSpec = QSPEC_NONE;

SingleSelectMenu meal, sup;
MultiSelectMenu other;
TextBox name;

Popup warningPopup;

LoadingSpinner loadingSpinner;

ScrollableTable table;

String queryPageHint;
TextBox queryPageTextBox;
boolean enterHint;
boolean qSpecCustomError = false;

import java.net.URLEncoder;

void setup() {
  size(800, 600);
  TCFont = createFont("NotoSansTC-Black.otf", 28);
  textAlign(CENTER, CENTER);
  textFont(TCFont);

  name = new TextBox(150, 280, 500, 60, "Enter your English name");

  ArrayList<String> mealOptions = new ArrayList<String>();
  mealOptions.add("照燒雞肉飯");
  mealOptions.add("蒜泥白肉飯");
  mealOptions.add("控肉飯");
  mealOptions.add("滷肉飯");
  meal = new SingleSelectMenu(250, 100, 300, 400, "請選擇一個餐點", mealOptions);
  
  ArrayList<String> supOptions = new ArrayList<String>();
  supOptions.add("無");
  supOptions.add("紅茶");
  supOptions.add("奶茶");
  supOptions.add("冰淇淋");
  supOptions.add("薯條");
  sup = new SingleSelectMenu(250, 100, 300, 400, "請選擇附餐", supOptions);

  ArrayList<String> otherOptions = new ArrayList<String>();
  otherOptions.add("免洗餐具");
  otherOptions.add("塑膠袋");
  other = new MultiSelectMenu(250, 100, 300, 400, "其他選項", otherOptions);
  
  warningPopup = new Popup(width / 2, height / 2);

  loadingSpinner = new LoadingSpinner(width / 2, height / 2, 80);

  table = new ScrollableTable(40, 40, 600, 400, new float[]{0.3, 0.2, 0.2, 0.1, 0.2});
  table.setHeaders("時間戳記", "姓名", "餐點", "附餐", "其他選項");
  queryPageHint = "";
  queryPageTextBox = new TextBox(140, 460, 400, 40, "");
}


void draw() {
  background(240);

  warningPopup.update();

  loadingSpinner.update();
  
  switch(uiStat) {
    case UI_HOME:
      drawHomePage();
      break;
    case UI_SEND_1:
      drawSendPage(1);
      break;
    case UI_SEND_2:
      drawSendPage(2);
      break;
    case UI_SEND_3:
      drawSendPage(3);
      break;
    case UI_SEND_4:
      drawSendPage(4);
      break;
    case UI_QUERY:
      drawQueryPage();
      break;
  }
}

