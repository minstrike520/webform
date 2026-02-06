class ScrollableTable {
  float x, y, w, h;
  float rowHeight = 25;
  float scrollOffset = 0;
  float maxScroll = 0;
  
  int columnCount;
  float[] columnWidths; // 比例
  ArrayList<ArrayList<String>> data;
  
  // 建構函數
  ScrollableTable(float x, float y, float w, float h, float[] columnWidths) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.columnWidths = columnWidths;
    this.columnCount = columnWidths.length;
    this.data = new ArrayList<ArrayList<String>>();
  }
  
  // 設定表頭
  void setHeaders(String... headers) {
    if (headers.length != columnCount) {
      println("警告：表頭數量與欄位數不符");
      return;
    }
    ArrayList<String> headerRow = new ArrayList<String>();
    for (String h : headers) {
      headerRow.add(h);
    }
    if (data.size() == 0) {
      data.add(headerRow);
    } else {
      data.set(0, headerRow);
    }
  }
  
  // 新增資料列
  void addRow(String... values) {
    if (values.length != columnCount) {
      println("警告：資料數量與欄位數不符");
      return;
    }
    ArrayList<String> row = new ArrayList<String>();
    for (String v : values) {
      row.add(v);
    }
    data.add(row);
    updateMaxScroll();
  }
  
  // 清除所有資料（保留表頭）
  void clearData() {
    if (data.size() > 0) {
      ArrayList<String> header = data.get(0);
      data.clear();
      data.add(header);
    }
    scrollOffset = 0;
    updateMaxScroll();
  }
  
  // 更新最大捲動範圍
  void updateMaxScroll() {
    float contentHeight = (data.size() - 1) * rowHeight; // 扣除表頭
    float visibleHeight = h - rowHeight; // 扣除表頭高度
    maxScroll = max(0, contentHeight - visibleHeight);
  }
  
  // 處理滑鼠滾輪
  void mouseWheel(float delta) {
    if (isMouseOver()) {
      scrollOffset += delta * 20; // 調整捲動速度
      scrollOffset = constrain(scrollOffset, 0, maxScroll);
    }
  }
  
  // 檢查滑鼠是否在表格範圍內
  boolean isMouseOver() {
    return mouseX >= x && mouseX <= x + w && 
           mouseY >= y && mouseY <= y + h;
  }
  
  // 繪製表格
  void display() {
    pushStyle();
    
    // 繪製背景
    fill(255);
    stroke(150);
    strokeWeight(1);
    rect(x, y, w, h);

    textSize(12);
    
    // 設定裁切區域
    clip(x, y, w, h);
    
    // 繪製表頭（固定不動）
    if (data.size() > 0) {
      drawRow(data.get(0), y, true);
    }
    noFill();
    stroke(150);
    strokeWeight(1);
    rect(x, y, w, h);

    if (data.size() == 1) {
      fill(100);
      textAlign(CENTER, CENTER);
      textSize(48);
      text("No Data", x + w / 2, y + h / 2);
    }
    
    // 繪製資料列
    float currentY = y + rowHeight - scrollOffset;
    for (int i = 1; i < data.size(); i++) {
      float rowY = currentY + (i - 1) * rowHeight;
      
      // 檢查該列是否在可見範圍內（考慮遮擋規則）
      if (rowY + rowHeight > y + rowHeight && rowY < y + h) {
        // 如果行被上下框遮擋過多，則不顯示
        float visibleTop = max(rowY, y + rowHeight);
        float visibleBottom = min(rowY + rowHeight, y + h);
        float visibleHeight = visibleBottom - visibleTop;
        
        if (visibleHeight >= rowHeight * 0.5) { // 至少顯示50%才繪製
          drawRow(data.get(i), rowY, false);
        }
      }
    }
    
    noClip();
    
    // 繪製捲軸
    if (maxScroll > 0) {
      drawScrollbar();
    }
    
    popStyle();
  }
  
  // 繪製單一列
  void drawRow(ArrayList<String> row, float rowY, boolean isHeader) {
    // 背景
    if (isHeader) {
      fill(220);
    } else {
      fill(255);
    }
    noStroke();
    rect(x, rowY, w, rowHeight);
    
    // 格線
    stroke(200);
    strokeWeight(1);
    line(x, rowY + rowHeight, x + w, rowY + rowHeight);
    
    // 繪製每個儲存格
    float currentX = x;
    for (int i = 0; i < columnCount; i++) {
      float colWidth = w * columnWidths[i];
      
      // 垂直線
      line(currentX, rowY, currentX, rowY + rowHeight);
      
      // 文字
      fill(0);
      textAlign(LEFT, CENTER);
      String text = i < row.size() ? row.get(i) : "";
      text(text, currentX + 5, rowY + rowHeight / 2);
      
      currentX += colWidth;
    }
    
    // 最右邊的線
    line(currentX, rowY, currentX, rowY + rowHeight);
  }
  void importCSV(ArrayList<ArrayList<String>> csv) {
    int[] mappings = new int[columnCount];
    for (int i = 0; i < columnCount; i++) {
      mappings[i] = -1;
    }
    ArrayList<String> headers = csv.get(0);
    if (headers.size() != columnCount) {
      println("警告：資料數量與欄位數不符");
      return;
    }
    for (int i = 0; i < columnCount; i++) {
      for (int j = 0; j < columnCount; j++) {
        if (headers.get(i).equals(data.get(0).get(j))  ) {
          mappings[j] = i;
          break;
        }
      }
    }

    for (int i = 0; i < columnCount; i++) {
      if (mappings[i] == -1) {
        println("Warn: Mappings isn't fit!");
        println(mappings);
        println("data header:", data.get(0));
        println("csv header:", headers);
        return;
      }
    }
    for (int i = 1; i < csv.size(); i++) {
      String[] row = new String[columnCount];
      for (int j = 0; j < columnCount; j++) {
        row[j] = csv.get(i).get(mappings[j]);
      }
      addRow(row);
    }
  }
  
  // 繪製捲軸
  void drawScrollbar() {
    float scrollbarWidth = 10;
    float scrollbarX = x + w - scrollbarWidth - 2;
    float scrollbarAreaHeight = h - rowHeight - 4;
    float scrollbarY = y + rowHeight + 2;
    
    // 捲軸背景
    fill(240);
    noStroke();
    rect(scrollbarX, scrollbarY, scrollbarWidth, scrollbarAreaHeight);
    
    // 捲軸滑塊
    float scrollbarHeight = scrollbarAreaHeight * (h - rowHeight) / ((data.size() - 1) * rowHeight);
    scrollbarHeight = max(20, scrollbarHeight);
    float scrollbarPos = scrollbarY + (scrollOffset / maxScroll) * (scrollbarAreaHeight - scrollbarHeight);
    
    fill(150);
    rect(scrollbarX, scrollbarPos, scrollbarWidth, scrollbarHeight, 5);
  }
}