class Tree {

    int maxbranches = 100;

    Leaf[] leaves = new Leaf[maxbranches];

    Tree(){
    for (var i = 0; i <maxbranches; i++){
        leaves[i] = new Leaf();
    }
    }

    void show() {
        for (var i=0;i < leaves.length;i++){
            println("i: "+i);
            leaves[i].show();
        }
    }

}