import java.util.Arrays;


int lpal;
Integer[] pal;

int sq_size = 10;
int width_grid;
int height_grid;

ArrayList<ArrayList<Cell>> grid;

HashMap<String, Integer> rules;

void setup(){
  size(1000,1000);
  width_grid = (int)width/sq_size;
  height_grid = (int)height/sq_size;
  
  
  pal = new Integer[]{0,50,140,200};
  lpal = pal.length;
  
  grid = new ArrayList<ArrayList<Cell>>();
 
  for (int i = 0; i<height_grid;i++){
    grid.add(new ArrayList<Cell>());
    for (int j=0; j<width_grid;j++){
      grid.get(i).add(new Cell());
      if (i==0 || j==0){
        Cell c = grid.get(i).get(j);
        c.top_line = (int)random(0,2);
        c.left_line = (int)random(0,2);
        c.des_line = (int)random(0,2);
        c.asc_line = (int)random(0,2);
        color top = (int)random(lpal);
        color left = (int)random(lpal);
        if (i==0 && j==0){
          int combi = unbinary(str(top_line)+str(left_line)+str(des_line)+str(acs_line));
          ArrayList<Integer> cols = get_cols(combi, t_col, l_col);
          
        }
      }
    }
  }
  
  rules = new HashMap<String, Integer>();
  rules.put("t", 0);
  rules.put("l", 0);
  rules.put("d", 0);
  rules.put("a", 0);
  
  for (int i = 1; i<height_grid;i++){
    for (int j=1; j<width_grid;j++){
      Cell t = grid.get(i-1).get(j);
      Cell tl = grid.get(i-1).get(j-1);
      Cell l = grid.get(i).get(j-1);
      Cell c = grid.get(i).get(j);
      int top_line = newLine("top", l.asc_line, l.top_line, tl.des_line);
      int left_line = newLine("left", t.left_line, t.asc_line, tl.des_line);
      int des_line = newLine("des", t.left_line, l.top_line, tl.des_line);
      int acs_line = newLine("asc", t.left_line, l.top_line, tl.asc_line);
      
      int combi = unbinary(str(top_line)+str(left_line)+str(des_line)+str(acs_line));
      int t_col = t.s_color;
      int l_col = l.e_color;
      ArrayList<Integer> cols = get_cols(combi, t_col, l_col);
      c = new Cell(top_line, left_line, des_line, acs_line, cols);
      grid.get(i).set(j, c);
    }
  }
}

color get_color(int i){
  Integer[] pal = new Integer[]{0,50,140,200};
  int j = i%pal.length;
  return pal[j];
}

ArrayList<Integer> get_cols(int combi, int top, int left){
  color n = 0;
  color w = 0;
  color s = 0;
  color e = 0;
  
  color tn = (top+1)%lpal;
  color tn2 = (top*2+2)%lpal;
  color ln = (left+1)%lpal;
  color ln2 = (left*2+2)%lpal;
  
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


int newLine(String pos, int a, int b, int c){
  return 1;
}



void draw(){
  
}
