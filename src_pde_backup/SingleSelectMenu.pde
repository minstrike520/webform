class SingleSelectMenu {
  float x, y, w, h;
  String title;
  ArrayList<String> options;
  int selectedIndex;
  float itemHeight;
  float titleHeight;
  
  // 顏色設定
  color bgColor = color(240);
  color hoverColor = color(220);
  color selectedColor = color(100, 150, 255);
  color textColor = color(0);
  color titleBgColor = color(200);
  
  SingleSelectMenu(float x, float y, float w, float h, String title, ArrayList<String> options) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.title = title;
    this.options = options;
    this.selectedIndex = -1;
    
    // 計算標題和項目高度
    this.titleHeight = 35;
    this.itemHeight = (h - titleHeight) / options.size();
  }
  
  void display() {
    pushStyle();
    
    // 繪製標題
    fill(titleBgColor);
    rect(x, y, w, titleHeight);
    fill(textColor);
    textAlign(LEFT, CENTER);
    textSize(16);
    text(title, x + 10, y + titleHeight / 2);
    
    // 繪製選項
    textSize(14);
    for (int i = 0; i < options.size(); i++) {
      float itemY = y + titleHeight + i * itemHeight;
      
      // 判斷滑鼠懸停或選中狀態
      if (i == selectedIndex) {
        fill(selectedColor);
      } else if (isMouseOver(itemY, i)) {
        fill(hoverColor);
      } else {
        fill(bgColor);
      }
      
      rect(x, itemY, w, itemHeight);
      
      // 繪製選項文字
      fill(i == selectedIndex ? color(255) : textColor);
      text(options.get(i), x + 10, itemY + itemHeight / 2);
      
      // 繪製選中標記
      if (i == selectedIndex) {
        fill(255);
        ellipse(x + w - 20, itemY + itemHeight / 2, 8, 8);
      }
      
      // 繪製分隔線
      stroke(200);
      line(x, itemY + itemHeight, x + w, itemY + itemHeight);
    }
    
    // 繪製邊框
    noFill();
    stroke(150);
    rect(x, y, w, h);
    
    popStyle();
  }

  void reset() {
    this.selectedIndex = -1;
  }
  
  boolean isMouseOver(float itemY, int index) {
    return mouseX > x && mouseX < x + w && 
           mouseY > itemY && mouseY < itemY + itemHeight;
  }
  
  void mousePressed() {
    if (mouseX < x || mouseX > x + w) return;
    if (mouseY < y + titleHeight || mouseY > y + h) return;
    
    // 計算點擊的是哪個選項
    int clickedIndex = int((mouseY - y - titleHeight) / itemHeight);
    if (clickedIndex >= 0 && clickedIndex < options.size()) {
      selectedIndex = clickedIndex;
    }
  }
  
  int getSelectedIndex() {
    return selectedIndex;
  }
  
  String getSelectedValue() {
    if (selectedIndex >= 0 && selectedIndex < options.size()) {
      return options.get(selectedIndex);
    }
    return null;
  }
}

SingleSelectMenu defaultSingleSelectMenu() {
  ArrayList<String> options = new ArrayList<String>();
  options.add("選項 1");
  options.add("選項 2");
  options.add("選項 3");
  options.add("選項 4");
  options.add("選項 5");
  
  // 建立選單
  return new SingleSelectMenu(50, 50, 300, 300, "請選擇一個選項", options);
}

void examplePort(SingleSelectMenu menu) {
  fill(0);
  textAlign(LEFT);
  textSize(14);
  text("目前選擇: " + (menu.getSelectedValue() != null ? menu.getSelectedValue() : "未選擇"), 50, 380);
  text("索引: " + menu.getSelectedIndex(), 50, 400);
}