class Popup {
  String message;
  float x, y;
  float percentage;
  boolean isActive;
  
  // 樣式設定
  color bgColor;
  color textColor;
  int textSize;
  float padding;
  float cornerRadius;
  
  // 建構函數
  Popup(float x, float y) {
    this.x = x;
    this.y = y;
    this.percentage = 0;
    this.isActive = false;
    this.message = "";
    
    // 預設樣式
    this.bgColor = color(255, 100, 100);
    this.textColor = color(255);
    this.textSize = 16;
    this.padding = 20;
    this.cornerRadius = 10;
  }
  
  // 觸發動畫函數
  void show(String msg) {
    this.message = msg;
    this.percentage = 100;
    this.isActive = true;
  }
  
  // 更新動畫進度
  void update() {
    if (isActive && percentage > 0) {
      percentage -= 1.2; // 控制淡出速度
      if (percentage <= 0) {
        percentage = 0;
        isActive = false;
      }
    }
  }
  
  // 顯示popup
  void display() {
    if (isActive || percentage > 0) {
      pushMatrix();
      pushStyle();
      
      // 計算透明度（淡入淡出效果）
      float alpha = map(percentage, 0, 100, 0, 255);
      
      // 設定文字樣式來計算寬度
      textSize(this.textSize);
      float boxWidth = textWidth(message) + padding * 2;
      float boxHeight = this.textSize + padding * 2;
      
      // 繪製背景框
      fill(red(bgColor), green(bgColor), blue(bgColor), alpha);
      noStroke();
      rectMode(CENTER);
      rect(x, y, boxWidth, boxHeight, cornerRadius);
      
      // 繪製文字
      fill(red(textColor), green(textColor), blue(textColor), alpha);
      textAlign(CENTER, CENTER);
      text(message, x, y);
      
      popStyle();
      popMatrix();
    }
  }
  
  // 自訂樣式方法
  void setStyle(color bg, color txt, int size) {
    this.bgColor = bg;
    this.textColor = txt;
    this.textSize = size;
  }
  
  void setPadding(float p) {
    this.padding = p;
  }
  
  void setCornerRadius(float r) {
    this.cornerRadius = r;
  }
}