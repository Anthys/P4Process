
class ObjMod{

  ArrayList<PVector> get_vertices(String file){
    String[] lines = loadStrings(file);
    ArrayList<PVector> out = new ArrayList<PVector>();
    int ci = 0;
    for (int i = 0; i<lines.length;i++){
      String line = lines[i];
      String[] temp = line.split("k");
      if (temp.length>0 && temp[0] == "v"){
        PVector vec = new PVector(float(temp[1]),float(temp[2]),float(temp[3]));
        out.add(vec);
        ci += 1;
      }
    }
    return out;
  }

  //float replace_vectors(String file, ArrayList<PVector> vec){
  //  String[] file_r = loadStrings(file);
    // I4M NOT QUALIFIED
  //}
  /*
  def replace_v(file, vec):
    file_r = open(file)
    file1 = file_r.read()
    file1 = file1.split("\n")
    
    i_s = -1
    i_e = -1
    for i,l in enumerate(file1):
        temp = l.split()
        if i_s != -1 and temp and temp[0] != "v":
            i_e = i
            break
        if i_s == -1 and temp and  temp[0] == "v":
            i_s = i
            
    tmp_string = ""
    for v in vec:
        tmp_string += "v "+ str(v.x) + " " + str(v.y) + " "+ str(v.z)+ "\n"
    
    file1 = file1[:i_s] + [tmp_string] + file1[i_e:]
    file1 = "\n".join(file1)
    file_r.close()
    file_w = open(file, "w+")
    file_w.write(file1)
    file_w.close()
  */

}
