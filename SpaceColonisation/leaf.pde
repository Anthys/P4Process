class Leaf{
    
    Leaf(){

    PVector pos = new PVector(random(width), random(height));

    }

    void show(){
        fill(255);
        noStroke();
        ellipse(pos.x, pos.y, 4, 4);
    }
}