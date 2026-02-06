class TextBox {
  float x, y, w, h;
  String text = "";
  String placeholder = "";
  boolean focused = false;
  int cursorPos = 0;
  int cursorBlinkTimer = 0;
  
  TextBox(float x, float y, float w, float h, String placeholder) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.placeholder = placeholder;
  }
  
  void display() {
    // 繪製外框和背景
    if (focused) {
      stroke(100, 150, 255);  // 聚焦時藍色外框
      strokeWeight(2);
      fill(255);
    } else {
      stroke(180);  // 失焦時灰色外框
      strokeWeight(1);
      fill(245);  // 失焦時稍微灰的背景
    }
    rect(x, y, w, h, 5);
    
    // 繪製文字或提示文字
    textAlign(LEFT, CENTER);
    textSize(24);
    
    if (text.length() == 0 && !focused) {
      // 顯示提示文字
      fill(150);
      text(placeholder, x + 10, y + h/2);
    } else {
      // 顯示實際文字
      fill(0);
      text(text, x + 10, y + h/2);
      
      // 繪製游標（閃爍效果）
      if (focused && (cursorBlinkTimer / 30) % 2 == 0) {
        float cursorX = x + 10 + textWidth(text.substring(0, cursorPos));
        stroke(0);
        strokeWeight(1);
        line(cursorX, y + 8, cursorX, y + h - 8);
      }
    }
    
    cursorBlinkTimer++;
  }
  
  void reset() {
    text = "";
  }
  void mousePressed() {
    if (mouseX >= x && mouseX <= x + w && mouseY >= y && mouseY <= y + h) {
      focused = true;
      // 計算點擊位置對應的游標位置
      cursorPos = text.length();
      for (int i = 0; i < text.length(); i++) {
        float charX = x + 10 + textWidth(text.substring(0, i));
        float nextCharX = x + 10 + textWidth(text.substring(0, i + 1));
        if (mouseX < (charX + nextCharX) / 2) {
          cursorPos = i;
          break;
        }
      }
    } else {
      focused = false;
    }
    cursorBlinkTimer = 0;
  }
  
  void keyPressed() {
    if (!focused) return;
    
    if (keyCode == BACKSPACE) {
      if (cursorPos > 0) {
        text = text.substring(0, cursorPos - 1) + text.substring(cursorPos);
        cursorPos--;
      }
    } else if (keyCode == DELETE) {
      if (cursorPos < text.length()) {
        text = text.substring(0, cursorPos) + text.substring(cursorPos + 1);
      }
    } else if (keyCode == LEFT) {
      if (cursorPos > 0) cursorPos--;
    } else if (keyCode == RIGHT) {
      if (cursorPos < text.length()) cursorPos++;
    } else if (keyCode == 32 || (key >= 32 && key <= 126)) {
      // 可見字符（包括空格）
      text = text.substring(0, cursorPos) + key + text.substring(cursorPos);
      cursorPos++;
    }
    
    cursorBlinkTimer = 0;
  }
  
  String getText() {
    return text;
  }
  
  void setText(String newText) {
    text = newText;
    cursorPos = text.length();
  }
}