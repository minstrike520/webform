class MultiSelectMenu {
  float x, y, w, h;
  String title;
  ArrayList<String> options;
  boolean[] selected;
  float itemHeight;
  float titleHeight;
  
  // 顏色設定
  color bgColor = color(240);
  color hoverColor = color(220);
  color selectedColor = color(100, 150, 255);
  color textColor = color(0);
  color titleBgColor = color(200);
  
  MultiSelectMenu(float x, float y, float w, float h, String title, ArrayList<String> options) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.title = title;
    this.options = options;

    this.selected = new boolean[options.size()];
    for (int i = 0; i < options.size(); i++) {
      this.selected[i] = false;
    }
    
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
      if (selected[i]) {
        fill(selectedColor);
      } else if (isMouseOver(i)) {
        fill(hoverColor);
      } else {
        fill(bgColor);
      }
      
      rect(x, itemY, w, itemHeight);
      
      // 繪製選項文字
      fill(selected[i] ? color(255) : textColor);
      text(options.get(i), x + 10, itemY + itemHeight / 2);

      // 繪製選中標記
      stroke(200);
      fill(selected[i] ? color(100, 255, 150) : color(255));
      rect(x + w - 30 - 15, itemY + itemHeight / 2 - 15, 30, 30, 5);
      
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
  
  boolean isMouseOver(int index) {
    float itemY = y + titleHeight + index * itemHeight;

    return mouseX > x && mouseX < x + w && 
           mouseY > itemY && mouseY < itemY + itemHeight;
  }
  
  void mousePressed() {
    if (mouseX < x || mouseX > x + w) return;
    if (mouseY < y + titleHeight || mouseY > y + h) return;
    
    // 計算點擊的是哪個選項
    int clickedIndex = int((mouseY - y - titleHeight) / itemHeight);
    if (clickedIndex >= 0 && clickedIndex < options.size()) {
      selected[clickedIndex] = !selected[clickedIndex];
    }
  }
  
  ArrayList<String> getSelectedValues() {
    ArrayList<String> selectedValues = new ArrayList<String>();
    for (int i = 0; i < options.size(); i++) {
      if (selected[i]) {
        selectedValues.add(options.get(i));
      }
    }
    return selectedValues;
  }

  void reset() {
    for (int i = 0; i < options.size(); i++) {
        this.selected[i] = false;
    }
  }
}

MultiSelectMenu defaultMultiSelectMenu() {
  ArrayList<String> options = new ArrayList<String>();
  options.add("選項 1");
  options.add("選項 2");
  options.add("選項 3");
  options.add("選項 4");
  options.add("選項 5");
  
  // 建立選單
  return new MultiSelectMenu(50, 50, 300, 300, "請選擇一個選項", options);
}