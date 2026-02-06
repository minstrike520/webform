export enum UIStat {
  NONE = 0,
  HOME = 1,
  SEND_1 = 2,
  SEND_2 = 3,
  SEND_3 = 4,
  SEND_4 = 5,
  QUERY = 6
}

export enum QSpec {
  NONE = 0,
  USER = 1,
  CUSTOM = 2
}

export interface OrderForm {
  name: string;
  meal: string;
  sup: string;
  other: string[];
}

export const FORM_CONFIG = {
  url: "https://docs.google.com/forms/d/15NThyl3vImadD4loZVEUc3soHBk503x6r5VunxZSZS0/formResponse", // Only for reference, we post to the endpoint
  fields: {
    name: "entry.314876968",
    meal: "entry.1329149830",
    sup: "entry.1843446166",
    other: "entry.1253873200"
  }
};

export const SHEET_CONFIG = {
  url: "https://docs.google.com/spreadsheets/u/0/d/18uMTTGS3_A3rL7Q-5tFvIWhjMr3cJ_J5pa3Hju-rWps/gviz/tq",
  gid: "247974760"
};

export interface TableRow {
  timestamp: string;
  name: string;
  meal: string;
  sup: string;
  other: string;
}

export const MEAL_OPTIONS = ["照燒雞肉飯", "蒜泥白肉飯", "控肉飯", "滷肉飯"];
export const SUP_OPTIONS = ["無", "紅茶", "奶茶", "冰淇淋", "薯條"];
export const OTHER_OPTIONS = ["免洗餐具", "塑膠袋"];
