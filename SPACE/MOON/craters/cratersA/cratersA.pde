import peasy.*;

void setup(){
  size(500,500, P3D);
  //noLoop();
  
  cam = new PeasyCam(this, 200);
  table = loadTable("large.csv", "header");
  println(table.getRowCount() + " total rows in table");

  for (TableRow row : table.rows()) {

    String id = row.getString("CRATER_ID");
    float lat = row.getFloat("LAT_CIRC_IMG");
    float lon = row.getFloat("LON_CIRC_IMG");
    float diam = row.getFloat("DIAM_CIRC_IMG");
    if (lat > 87 && diam>30){
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
  background(200);
  strokeWeight(5);
  float r = 50;
  for (int i = 0; i<lats.size();i++){
    float lat = lats.get(i);
    float lon = longs.get(i);
    float x = r*sin(lat)*cos(lon);
    float y = r*sin(lat)*sin(lon);
    float z = r*cos(lat);
    point(x, y, z);
  }
  
}
