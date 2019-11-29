

int numPress = 0;
String[] instructions = {"k", "k", "p", "p", "k", "k", "p", "p", "k", "k", "p", "p"};

void setup () {
  size (1250, 600);
  //background (255, 255, 255);
  
  //border around edges of canvas and white background
  fill(0, 0, 0);
  rect(0,0,1250,600);
  fill(255, 255, 255);
  rect(0,0,1245,595);
  
 
  // text legend
  textSize(32);
  fill(0, 0, 0);
  text("k = knit", 50, 70);
  text("p = purl", 50, 110);
  text("Click inside of the canvas to activate the program", 50, 150);
  text("Use the 'b' key to move forward in the instructions", 50, 190);

 // draws and colors squares
  for (int i = 0; i < instructions.length; i++) {
    if(instructions[i] == "k") {
      fill(255, 0, 0);
    }
    else {
      fill(0, 255, 0);
    }
      rect((100*i) + 50, 300, 50, 50);
  }
}

void draw() {
  
}

void keyPressed() {
  if (key == 'b' || key == 'B') {
    numPress = numPress + 1;
    colorRect(numPress);
  }
}

void colorRect(int numPress) {
  fill(0, 0, 0);
  rect(50+(100*(numPress - 1)), 300, 50, 50 );
  fill(192, 192, 192);
  rect(50+(100*(numPress - 1)), 300, 50, 50 );
}
