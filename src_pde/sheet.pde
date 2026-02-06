import java.net.URLEncoder;

ArrayList<ArrayList<String>> querySheet(String TQStr) {
  String querySheetURL = "https://docs.google.com/spreadsheets/u/0/d/18uMTTGS3_A3rL7Q-5tFvIWhjMr3cJ_J5pa3Hju-rWps/gviz/tq?tqx=out:csv&gid=247974760&tq=";
  querySheetURL += URLEncoder.encode(TQStr);
  String[] sheetCSV = loadStrings(querySheetURL);
  if (sheetCSV.length != 0) {
    if (split(sheetCSV[0], ",").length > 2) {
      if (split(sheetCSV[0], ",")[2].equals("\"status\":\"error\"")) {
        warningPopup.show("無效的TQ指令");
ArrayList<ArrayList<String>> a = new ArrayList<ArrayList<String>>();
        a.add(new ArrayList<String>());
        a.get(0).add("error");
        return a;
      }
    }
  }
  ArrayList<ArrayList<String>> product = new ArrayList<ArrayList<String>>();
  for (int i = 0; i < sheetCSV.length; i++) {
    product.add(new ArrayList<String>());
    // String[] line = splitTokens(sheetCSV[i], ",\"");
    String[] line = split(sheetCSV[i], ',');
    for (int j = 0; j < line.length; j++) {
      String element = line[j];
      if (!element.endsWith("\"")) {
        if (
          element.startsWith("\"") 
          && !line[j + 1].startsWith("\"") 
          && line[j + 1].endsWith("\"")) {
          element = element.concat(line[j + 1]);
          j++;
        }
      }
      
      product.get(i).add(element.substring(1, element.length() - 1));
    }
  }
  return product;
}

void testQuerySheet() {
  querySheet("select * where E = 'asdf' order by A desc limit 1");

ArrayList<ArrayList<String>> a = querySheet("");
  println(a.get(3), "\n");
}

/*
"
- last data
- all data
- from specific person
- input custom query


"

"
rollable table display
"
*/