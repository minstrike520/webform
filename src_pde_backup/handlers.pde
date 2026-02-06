// 滑鼠點擊事件
void mousePressed() {
  switch(uiStat) {
    case UI_HOME:
      handleHomeClick();
      break;
    case UI_SEND_1:
      name.mousePressed();
      break;
    case UI_SEND_2:
      meal.mousePressed();
      break;
    case UI_SEND_3:
      sup.mousePressed();
      break;
    case UI_SEND_4:
      other.mousePressed();
      break;
    case UI_QUERY:
      handleQueryClick();
      queryPageTextBox.mousePressed();
      break;
  }
  switch (uiStat) {
    case UI_SEND_1:
    case UI_SEND_2:
    case UI_SEND_3:
    case UI_SEND_4:
      handleSendClick();
      break;
  }
}

void keyPressed() {
  switch (uiStat) {
    case UI_SEND_1:
      name.keyPressed();
      break;
    case UI_QUERY:
      queryPageTextBox.keyPressed();
      if (qSpec != QSPEC_NONE) {
        handleQSpecKeyPressed();
      }
      break;
  }
}

void handleQSpecKeyPressed() {
  qSpecCustomError = false;
  if (keyCode != ENTER) return;
  queryPageTextBox.focused = false;
  String tq = "";
  switch (qSpec) {
    case QSPEC_USER:
      tq = "select * where E = '" + queryPageTextBox.text + "' order by A desc";
      break;
    case QSPEC_CUSTOM:
      tq = queryPageTextBox.text;
      break;
  }
  table.clearData();
  ArrayList<ArrayList<String>> result = querySheet(tq);
  if (result.get(0).get(0).equals("error")) {
    qSpecCustomError = true;
  }
  else {
    table.importCSV(result);
  }
  queryPageHint = "TQ = \"" + tq + "\"";
  queryPageTextBox.text = "";
}

// 處理主頁面點擊
void handleHomeClick() {
  // 發送按鈕
  if (isButtonClicked(width/2 - 120, height/2, 200, 60)) {
    uiStat = UI_SEND_1;
  }
  // 查詢按鈕
  else if (isButtonClicked(width/2 + 120, height/2, 200, 60)) {
    uiStat = UI_QUERY;
  }
}

// 處理發送頁面點擊
void handleSendClick() {
  // 左上按鈕（上一步/返回）
  if (isButtonClicked(80, 40, 120, 50)) {
    if (uiStat == UI_SEND_1) {
      uiStat = UI_HOME;
      name.reset();
      meal.reset();
      sup.reset();
      other.reset();
    } else {
      uiStat--;
    }
  }
  // 右上按鈕（下一步/完成）
  else if (isButtonClicked(width - 80, 40, 120, 50)) {
    if (uiStat == UI_SEND_4) {
      if (name.text == "" || meal.selectedIndex == -1 || sup.selectedIndex == -1) {
        warningPopup.show("警告：欄位尚未填寫完畢");
        return;
      }
      sendForm(
        name.text, 
        meal.options.get(meal.selectedIndex),
        sup.options.get(sup.selectedIndex),
        other.getSelectedValues()
      );
      uiStat = UI_HOME;
      name.reset();
      meal.reset();
      sup.reset();
      other.reset();
    } else {
      uiStat++;
    }
  }
}

// 處理查詢頁面點擊
void handleQueryClick() {
  qSpecCustomError = false;
  // 返回按鈕
  if (isButtonClicked(width - 80, 40, 120, 50)) {
    queryPageTextBox.reset();
    uiStat = UI_HOME;
  }
  else if (isButtonClicked(width - 80, 150, 120, 50)) {
    enterHint = false;
    queryPageTextBox.placeholder = "";
    qSpec = QSPEC_NONE;
    queryPageHint = "TQ = \"\"";
    ArrayList<ArrayList<String>> csv = querySheet("");
    table.clearData();
    table.importCSV(csv);
  }
  else if (isButtonClicked(width - 80, 215, 120, 50)) {
    enterHint = false;
    queryPageTextBox.placeholder = "";
    qSpec = QSPEC_NONE;
    queryPageHint = "TQ = \"select * order by A desc limit 1\"";
    ArrayList<ArrayList<String>> csv = querySheet("select * order by A desc limit 1");
    table.clearData();
    table.importCSV(csv);
  }
  else if (isButtonClicked(width - 80, 280, 120, 50)) {
    enterHint = true;
    queryPageTextBox.placeholder = "訂餐人名稱";
    qSpec = QSPEC_USER;
    queryPageHint = "";
  }
  else if (isButtonClicked(width - 80, 345, 120, 50)) {
    enterHint = true;
    qSpec = QSPEC_CUSTOM;
    queryPageTextBox.placeholder = "自訂TQ指令";
    queryPageHint = "";
  }
}

void mouseWheel(MouseEvent event) {
  float delta = event.getCount();
  if (uiStat == UI_QUERY) {
    table.mouseWheel(delta);
  }
}

// 檢查按鈕是否被點擊
boolean isButtonClicked(float x, float y, float w, float h) {
  return mouseX > x - w/2 && mouseX < x + w/2 && 
         mouseY > y - h/2 && mouseY < y + h/2;
}
