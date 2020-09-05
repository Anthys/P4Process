class Cell{
  
   int top_line;
   int left_line;
   int des_line;
   int asc_line;
   
   color n_color;
   color w_color;
   color s_color;
   color e_color;
   
   Cell(int top, int left, int des, int asc, int nc, int wc, int sc, int ec){
     top_line = top;
     left_line = left;
     des_line = des;
     asc_line = asc;
     n_color = nc;
     w_color = wc;
     s_color = sc;
     e_color = ec;
   }
   
   Cell(){
     this(0,0,0,0,0,0,0,0);
   }
   Cell(int top, int left, int des, int asc){
     this(top, left, des, asc,0,0,0,0);
   }
   
   Cell(int top, int left, int des, int asc, ArrayList<Integer> cols){
    this(top, left, des, asc);
    int nc = cols.get(0);
    int wc = cols.get(1);
    int sc = cols.get(2);
    int ec = cols.get(3);
     n_color = nc;
     w_color = wc;
     s_color = sc;
     e_color = ec;
   }

}
