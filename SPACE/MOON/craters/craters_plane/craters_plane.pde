import peasy.*;

float slat;

void setup(){
  size(500,500);
  //noLoop();
  
  slat = 87;
  
  //cam = new PeasyCam(this, 200);
  table = loadTable("large.csv", "header");
  println(table.getRowCount() + " total rows in table");

  for (TableRow row : table.rows()) {

    String id = row.getString("CRATER_ID");
    float lat = row.getFloat("LAT_CIRC_IMG");
    float lon = row.getFloat("LON_CIRC_IMG");
    float diam = row.getFloat("DIAM_CIRC_IMG");
    if (lat > slat && diam>1){
    lats.add((lat+90)*PI/180);
    longs.add(lon*PI/180);
    diams.add(diam);
    }
  }
  print(lats.size());
}

PeasyCam cam;
Table table;
ArrayList<Float> lats = new ArrayList<Float>();
ArrayList<Float> longs = new ArrayList<Float>();
ArrayList<Float> diams = new ArrayList<Float>();


void draw(){
  translate(width/2, height/2);
  background(200);
  strokeWeight(5);
  float base_r = 250;
  fill(255);
  circle(0,0,base_r*2);
  float dangle = (90-slat)*PI/180;
  float r = 250/sin(dangle);
  strokeWeight(1);
  for (int i = 0; i<lats.size();i++){
    float lat = lats.get(i);
    float lon = longs.get(i);
    float x = r*sin(lat)*cos(lon);
    float y = r*sin(lat)*sin(lon);
    //point(x, y);
    circle(x, y, diams.get(i)/1);
  }
  float x = r*sin(dangle)*cos(0);
  float y = r*sin(dangle)*sin(0);
  fill(255, 0,0);
  circle(x, y, 10);
  
  
}
