import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class SpaceColonisation extends PApplet {

Tree tree;

public void setup() {
    
    tree = new Tree();
};

public void draw() {
    background(51);
    tree.show();
}
class Leaf{
    
    Leaf(){

    PVector pos = new PVector(random(width), random(height));

    }

    public void show(){
        fill(255);
        noStroke();
        ellipse(pos.x, pos.y, 4, 4);
    }
}
class Tree {

    int maxbranches = 100;

    Leaf[] leaves = new Leaf[maxbranches];

    Tree(){
    for (var i = 0; i <maxbranches; i++){
        leaves[i] = new Leaf();
    }
    }

    public void show() {
        for (var i=0;i < leaves.length;i++){
            println("i: "+i);
            leaves[i].show();
        }
    }

}
  public void settings() {  size(400,400); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "SpaceColonisation" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
