int b_size = 6;
int n_tries = 10;

class Branch{
  PVector pos;
  int parent;
  boolean exhausted;
  
  Branch(PVector pos_, int parent_, boolean ex_){
    pos = pos_;
    parent = parent_;
    exhausted = ex_;
  }
}

ArrayList<Branch> tree;

void setup(){
  size(1000,1000);
  tree = new ArrayList<Branch>();
  init();
}

void init(){
  noStroke();
  fill(255, 100, 90);
  ellipse(width/2, height/2, 500, 500);
  stroke(0);
  strokeWeight(1);
  tree.clear();
  tree.add(new Branch(new PVector(width/2, height/2), 0, false));
}

void draw(){
  if (grow()){
    noLoop();
  };
  display();
}

boolean grow(){
  for (int idx = tree.size()-1;idx>=0;idx--){
    Branch cur = tree.get(idx);
    if (!cur.exhausted){
      PVector nei = new_neighbour(cur.pos);
      
      for (int t=0;t<n_tries; t++){
        if (cool_pos(nei)){
          if (random(1)<.3) cur.exhausted = true;
          
          tree.add(new Branch(nei, idx, random(1)<.15));
          return false;
        }
        nei = new_neighbour(cur.pos);
      }
      cur.exhausted = true;
      
    }
  }
  return true;
}

void display(){
  int last_idx = tree.size()-1;
  Branch b = tree.get(last_idx);
  Branch nei = tree.get(b.parent);
  line(b.pos.x, b.pos.y, nei.pos.x, nei.pos.y);
}



boolean cool_pos(PVector n){
  float area_radius = 300;
  
  // Check if close to tree
  for (Branch br:tree){
    if (dist(br.pos.x, br.pos.y, n.x, n.y)<b_size){
      return false;
    }
  }
  
  
  // Check if inside area
  if (dist(n.x, n.y, width/2, height/2)>area_radius){
    return false;
  }
  return true;
  
  
}

void keyPressed(){
  if (keyCode == 32){
    loop();
    background(200);
    init();
  }
}

PVector new_neighbour(PVector source){
  float r = random(TAU);
  float x = source.x + cos(r)*(b_size+1);
  float y = source.y + sin(r)*(b_size+1);
  return new PVector(x, y);
  
}
