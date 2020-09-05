import java.util.Arrays;


int lpal;
Integer[] pal;

int n_sq = 20;
int panel_l;
float sq_size;

boolean refl = true;

PGraphics cvs;
PGraphics dbg;

ArrayList<ArrayList<Cell>> grid;

HashMap<String, Integer> rules;

Integer[] newPalette(int n){
  Integer[] pal = new Integer[n];
  for (int i = 0;i<n;i++){
    float a = random(255);
    float b = random(255);
    float c = random(255);
    pal[i] = (color(a, b, c));
  }
  return pal;
}

void setup(){
  size(1000,1000);
  
  init();
}

ArrayList<Integer> get_cols(int combi, int top, int left){
  color n = 0;
  color w = 0;
  color s = 0;
  color e = 0;
  
  color tn = (top+1)%lpal;
  color tn2 = (top+2)%lpal;
  color ln = (left+1)%lpal;
  color ln2 = (left+2)%lpal;
  
  switch(combi){
    case 0:
      n = top;
      e = top;
      w = left;
      s = left;
      break;
    case 1:
      n = top;
      w = left;
      s = tn;
      e = tn;
      break;
    case 2:
      n = top;
      w = left;
      s = left;
      e = top;
      break;
    case 3:
      n = top;
      w = left;
      s = tn;
      e = ln;
      break;
    case 4:
      n = top;
      w = top;
      s = top;
      e = top;
      break;
    case 5:
      n = top;
      w = top;
      s = tn;
      e = tn;
      break;
    case 6:
      n = top;
      w = tn;
      s = tn;
      e = top;
      break;
    case 7:
      n = top;
      w = tn;
      s = ln;
      e = tn2;
      break;
    case 8:
      n = left;
      w = left;
      s = left;
      e = left;
      break;
    case 9:
      n = left;
      w = left;
      s = tn;
      e = tn;
      break;
    case 10:
      n = tn;
      w = left;
      s = left;
      e = tn;
      break;
    case 11:
      n = tn;
      w = left;
      s = ln;
      e = tn2;
      break;
    case 12:
      n = tn;
      w = tn;
      s = tn;
      e = tn;
      break;
    case 13:
      n = tn;
      w = tn;
      s = ln;
      e = ln;
      break;
    case 14:
      n = tn;
      w = ln;
      s = ln;
      e = tn;
      break;
    case 15:
      n = tn;
      w = ln;
      s = tn2;
      e = ln2;
      break;
  }
  
  return new ArrayList<Integer>(Arrays.asList(n, w, s, e));
    

}


int newLine(int rule, int a, int b, int c){
  String s = str(a)+str(b)+str(c)+str(a*c)+str(a*b)+str(b*c)+str(a*b*c);
  return (s.charAt(rule%7)=='0')?0:1;
}

void draw_cell(Cell c){
  for (int i = 0;i<2;i++){
    float x0 = .5*i;
    float y0 = .5*i;
    cvs.push();
    cvs.translate(x0,y0);
    cvs.fill(pal[c.n_color]);
    cvs.beginShape();
    cvs.vertex(0,0);
    cvs.vertex(sq_size,0);
    cvs.vertex(sq_size/2,sq_size/2);
    cvs.endShape(CLOSE);
    
    cvs.fill(pal[c.w_color]);
    cvs.beginShape();
    cvs.vertex(0,0);
    cvs.vertex(sq_size/2,sq_size/2);
    cvs.vertex(0,sq_size);
    cvs.endShape(CLOSE);
    
    cvs.fill(pal[c.s_color]);
    cvs.beginShape();
    cvs.vertex(0,sq_size);
    cvs.vertex(sq_size/2,sq_size/2);
    cvs.vertex(sq_size,sq_size);
    cvs.endShape(CLOSE);
    
    cvs.fill(pal[c.e_color]);
    cvs.beginShape();
    cvs.vertex(sq_size,0);
    cvs.vertex(sq_size/2,sq_size/2);
    cvs.vertex(sq_size,sq_size);
    cvs.endShape(CLOSE);
    cvs.pop();
  }
}

void draw(){
  noLoop();
  cvs.beginDraw();
  dbg.beginDraw();
  for (int i = 0; i<n_sq;i++){
    for (int j=0; j<n_sq;j++){
      cvs.push();
      cvs.translate(j*sq_size,i*sq_size);
      Cell c = grid.get(i).get(j);
      cvs.noStroke();
      cvs.strokeWeight(1);
      draw_cell(c);
      cvs.stroke(255);
      cvs.strokeWeight(2);
      if (c.top_line == 1 && false){
        cvs.line(0,0,sq_size, 0);
      }
      cvs.pop();
      if (refl){
        cvs.push();
        cvs.translate(width, height);
        cvs.scale(-1,-1);
        cvs.translate(j*sq_size,i*sq_size);
        c = grid.get(i).get(j);
        cvs.noStroke();
        cvs.strokeWeight(1);
        draw_cell(c);    
        cvs.pop();
        
        cvs.push();
        cvs.translate(width, 0);
        cvs.scale(-1,1);
        cvs.translate(j*sq_size,i*sq_size);
        c = grid.get(i).get(j);
        cvs.noStroke();
        cvs.strokeWeight(1);
        draw_cell(c);    
        cvs.pop();
        
        cvs.push();
        cvs.translate(0, height);
        cvs.scale(1,-1);
        cvs.translate(j*sq_size,i*sq_size);
        c = grid.get(i).get(j);
        cvs.noStroke();
        cvs.strokeWeight(1);
        draw_cell(c);    
        cvs.pop();
      }
    }
  }
  cvs.endDraw();
  dbg.endDraw();
  image(cvs, 0,0);
  image(dbg, 0,0);
  print("Done");
}

void init(){
  sq_size = (int)min(width, height)/n_sq;
  panel_l = (int)sq_size*n_sq;
  if (refl){sq_size /=2;};
  cvs = createGraphics(width, height);
  dbg = createGraphics(width, height);
  
  
  pal = newPalette(6);
  lpal = pal.length;
  
  grid = new ArrayList<ArrayList<Cell>>();
 
  for (int i = 0; i<n_sq;i++){
    grid.add(new ArrayList<Cell>());
    for (int j=0; j<n_sq;j++){
      grid.get(i).add(new Cell());
      if (i==0 || j==0){
        Cell c = grid.get(i).get(j);
        c.top_line = (int)random(0,2);
        c.left_line = (int)random(0,2);
        c.des_line = (int)random(0,2);
        c.asc_line = (int)random(0,2);
        color top = (int)random(lpal);
        color left = (int)random(lpal);
        int combi = unbinary(str(c.top_line)+str(c.left_line)+str(c.des_line)+str(c.asc_line));
        combi = 0;
        ArrayList<Integer> cols = new ArrayList<Integer>();
        if (i==0 && j==0){
          cols = get_cols(combi, top, left);
        }else if (i!=0){
          color tt = grid.get(i-1).get(j).s_color;
          cols = get_cols(combi, tt, left);
        }else if (j!=0){
          color ll = grid.get(i).get(j-1).e_color;
          cols = get_cols(combi, top, ll);
        }
        c.apply_cols(cols);
      }
    }
  }
  
  rules = new HashMap<String, Integer>();
  rules.put("t", (int)random(0,100));
  rules.put("l", (int)random(0,100));
  rules.put("d", (int)random(0,100));
  rules.put("a", (int)random(0,100));
  
  compute_grid();
}

void compute_grid(){
  for (int i = 1; i<n_sq;i++){
    for (int j=1; j<n_sq;j++){
      Cell t = grid.get(i-1).get(j);
      Cell tl = grid.get(i-1).get(j-1);
      Cell l = grid.get(i).get(j-1);
      Cell c = grid.get(i).get(j);
      int top_line = newLine(rules.get("t"), l.asc_line, l.top_line, tl.des_line);
      if (j==1 && false){
        String s = str(l.asc_line)+str(l.top_line)+str(tl.des_line);
        println(s);
      }
      int left_line = newLine(rules.get("l"), t.left_line, t.asc_line, tl.des_line);
      int des_line = newLine(rules.get("d"), t.left_line, l.top_line, tl.des_line);
      int acs_line = newLine(rules.get("a"), t.left_line, l.top_line, tl.asc_line);
      
      int combi = unbinary(str(top_line)+str(left_line)+str(des_line)+str(acs_line));
      int t_col = t.s_color;
      int l_col = l.e_color;
      ArrayList<Integer> cols = get_cols(combi, t_col, l_col);
      c = new Cell(top_line, left_line, des_line, acs_line, cols);
      grid.get(i).set(j, c);
    }
  }

}

void keyPressed(){
  if (keyCode == 32){
    init();
    redraw();
  }
  if (key == 's'){
    saveFrame("out-####.png");
  }
}
