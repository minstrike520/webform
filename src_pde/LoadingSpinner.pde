// Loading Spinner Component Class
class LoadingSpinner {
  float x, y;           // 位置
  float size;           // 大小
  float angle;          // 旋轉角度
  float speed;          // 旋轉速度
  color spinnerColor;   // 顏色
  float strokeW;        // 線條粗細
  
  // 建構子
  LoadingSpinner(float x, float y, float size) {
    this.x = x;
    this.y = y;
    this.size = size;
    this.angle = 0;
    this.speed = 0.1;
    this.spinnerColor = color(100, 150, 255);
    this.strokeW = size / 10;
  }
  
  // 可自訂所有參數的建構子
  LoadingSpinner(float x, float y, float size, float speed, color c) {
    this.x = x;
    this.y = y;
    this.size = size;
    this.angle = 0;
    this.speed = speed;
    this.spinnerColor = c;
    this.strokeW = size / 10;
  }
  
  // 更新動畫
  void update() {
    angle += speed;
  }
  
  // 顯示spinner
  void display() {
    pushMatrix();
    translate(x, y);
    rotate(angle);
    
    noFill();
    stroke(spinnerColor);
    strokeWeight(strokeW);
    strokeCap(ROUND);
    
    // 畫一個不完整的圓圈（270度）
    arc(0, 0, size, size, 0, radians(270));
    
    popMatrix();
  }
  
  // 設定顏色
  void setColor(color c) {
    this.spinnerColor = c;
  }
  
  // 設定速度
  void setSpeed(float speed) {
    this.speed = speed;
  }
  
  // 設定位置
  void setPosition(float x, float y) {
    this.x = x;
    this.y = y;
  }
}