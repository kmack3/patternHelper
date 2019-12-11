import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

int numPress = 0;
String[] instructions = {"k", "k", "p", "p", "k", "k", "p", "p", "k", "k", "p", "p"};
int rectX = 60;
int x1 = 45;
int x2 = 65;
int x3 = 85;
Minim minim;
AudioSnippet purl_sound;
AudioSnippet knit_sound;


void setup () {
  size (1250, 600);
  minim = new Minim(this);
  purl_sound = minim.loadSnippet("purl.wav");
  knit_sound = minim.loadSnippet("knit.wav");
  
  //border around edges of canvas and white background
  fill(0, 0, 0);
  rect(0,0,1250,600);
  fill(255, 255, 255);
  rect(2,2,1245,595);
  
  // text legend
  textSize(25);
  fill(0, 0, 0);
  text("k = knit", 50, 70);
  text("p = purl", 200, 70);
  text("Click inside of the canvas to activate the program.", 50, 120);
  text("Use the 'f' key to move forward in the instructions.", 50, 160);

 // prints instructions
  for (int i = 0; i < instructions.length; i++) {
    textSize(45);
    fill(0,0,0);
    text(instructions[i], (100*i) + 50, 350);
   }
   
  drawArrow();
  
  // play tone for first stitch
  playTone();
}

void playTone() {
  if(instructions[numPress] == "k") {
        knit_sound.play();
        knit_sound.rewind();
  }
  else {
        purl_sound.play();
        purl_sound.rewind();
  }
}

void draw() {
  
}

void drawArrow() {
  stroke(#ffffff);
  fill(255, 255, 255);
  rect(40, 360, 1150, 100);
  
  fill(0,0,0);
  rect(rectX+(100*numPress), 420, 10, 40);
  triangle(x1+(100*numPress), 420, x2+(100*numPress), 375, x3+(100*numPress), 420);  
}


void keyPressed() { // added error handling for advancing beyond the end of the row
  if (key == 'f' || key == 'F') {
    if (numPress + 1 < instructions.length){
      numPress = numPress + 1;
      colorRect(numPress);
      drawArrow();
      playTone();
    }
  }
  else if(key == 'b' || key == 'B') {
  if (numPress - 1 >= 0){
      numPress = numPress - 1;
      reprintInstruction(numPress);
      playTone();
    }
  }
}

void colorRect(int numPress) {
  fill(0, 0, 0);
  rect(50+(100*(numPress - 1)), 315, 50, 50 );
  fill(192, 192, 192);
  rect(50+(100*(numPress - 1)), 315, 50, 50 );
}

void reprintInstruction(int numPress) {
  fill(255,255,255);
  rect(50+(100*numPress), 315, 50, 50 );
  
  textSize(45);
  fill(0,0,0);
  text(instructions[numPress], (100*numPress) + 50, 350);
  
  drawArrow();
}
