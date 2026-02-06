// 繪製主頁面
void drawHomePage() {
  // 標題
  fill(50);
  textSize(48);
  text("訂餐系統", width/2, height/3);
  
  // 發送按鈕
  drawButton(width/2 - 120, height/2, 200, 60, "發送", color(100, 150, 255));
  
  // 查詢按鈕
  drawButton(width/2 + 120, height/2, 200, 60, "查詢", color(100, 255, 150));

  fill(50);
  textSize(24);
  text("HW4 WebAccess, 41347060S 楊銘煌", width / 2, 50);
}

// 繪製發送頁面
void drawSendPage(int pageNum) {
  if (pageNum > 1) {
    drawButton(80, 40, 120, 50, "上一步", color(200, 200, 200));
  } else {
    drawButton(80, 40, 120, 50, "返回", color(200, 200, 200));
  }
  
  if (pageNum < 4) {
    drawButton(width - 80, 40, 120, 50, "下一步", color(100, 150, 255));
  } else {
    drawButton(width - 80, 40, 120, 50, "發送", color(100, 255, 150));
  }

  
  fill(50);
  textSize(24);
  text("發送頁面 " + pageNum + " / 4", width/2, 40);

  switch (pageNum) {
    case 1:
      name.display();
      break;
    case 2:
      meal.display();
      break;
    case 3:
      sup.display();
      break;
    case 4:
      other.display();
      break;
  }
  warningPopup.display();
  // 頁面指示器
  drawPageIndicator(pageNum);
}

// 繪製查詢頁面
void drawQueryPage() {
  table.display();

  queryPageTextBox.display();
  if (enterHint) {
    fill(color(200, 150, 100));
    textAlign(LEFT, CENTER);
    text("<- ENTER HERE", 560, 480);
  }

  if (qSpecCustomError) {
    fill(#ff0000);
  }
  else {
    fill(0);
  }
  textAlign(CENTER, CENTER);
  textSize(24);
  text(queryPageHint, 340, 540);

  // 3. 側邊欄區 (4 個) - 使用紅色
  // 設定填色為淺紅色 (RGB: 200, 100, 100)
  drawButton(width - 80, 40, 120, 50, "返回", color(200, 200, 200));
  drawButton(width - 80, 150, 120, 50, "全部", color(100, 150, 200));
  drawButton(width - 80, 215, 120, 50, "最後一筆", color(100, 150, 200));
  drawButton(width - 80, 280, 120, 50, "來自：", color(200, 150, 100));
  drawButton(width - 80, 345, 120, 50, "自訂：", color(200, 150, 100));
  // loadingSpinner.display();
  
  // 頁面內容
  // fill(50);
  // textSize(32);
  //text("查詢頁面", width/2, height/2);
  warningPopup.display();
}

// 繪製按鈕
void drawButton(float x, float y, float w, float h, String label, color col) {
  // 檢查滑鼠懸停
  boolean hover = mouseX > x - w/2 && mouseX < x + w/2 && 
                  mouseY > y - h/2 && mouseY < y + h/2;
  
  // 繪製按鈕
  if (hover) {
    fill(red(col) * 0.8, green(col) * 0.8, blue(col) * 0.8);
  } else {
    fill(col);
  }
  
  stroke(50);
  strokeWeight(2);
  rect(x - w/2, y - h/2, w, h, 10);
  
  // 繪製文字
  fill(255);
  textSize(20);
  textAlign(CENTER, CENTER);
  text(label, x, y);
  
  noStroke();
}

// 繪製頁面指示器
void drawPageIndicator(int currentPage) {
  float spacing = 30;
  float startX = width/2 - (4 * spacing) / 2;
  float y = height - 50;
  
  for (int i = 1; i <= 4; i++) {
    if (i == currentPage) {
      fill(100, 150, 255);
      ellipse(startX + (i-1) * spacing, y, 15, 15);
    } else {
      fill(200);
      ellipse(startX + (i-1) * spacing, y, 12, 12);
    }
  }
}

