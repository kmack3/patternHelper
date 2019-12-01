import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;


int numPress = 0;
String[] instructions = {"k", "k", "p", "p", "k", "k", "p", "p", "k", "k", "p", "p"};
Minim minim;
AudioSnippet beep;
float rectX = 70;
int x1 = 55;
int x2 = 75;
int x3 = 95;


void setup () {
  size (1250, 600);
  minim = new Minim(this);
  beep = minim.loadSnippet("beep.wav");
  
  //border around edges of canvas and white background
  fill(0, 0, 0);
  rect(0,0,1250,600);
  fill(255, 255, 255);
  rect(0,0,1245,595);
  
 
  // text legend
  fill(0, 0, 255);
  rect(50, 35, 50, 50);
  fill(0, 255, 0);
  rect(250, 35, 50, 50);
  textSize(32);
  fill(0, 0, 0);
  text("knit", 115, 70);
  text("purl", 315, 70);
  text("Click inside of the canvas to activate the program", 50, 130);
  text("Use the 'b' key to move forward in the instructions", 50, 180);

 // draws and colors squares
  for (int i = 0; i < instructions.length; i++) {
    if(instructions[i] == "k") {
      fill(0, 0, 255);
    }
    else {
      fill(0, 255, 0);
    }
      rect((100*i) + 50, 300, 50, 50);
  }
  
  // Arrow to first square
  drawArrow();
  
  
  playTone();
}

void draw() {

}

void drawArrow() {
  stroke(#ffffff);
  fill(255, 255, 255);
  rect(50, 355, 1150, 100);
  
  fill(0,0,0);
  rect(rectX+(100*numPress), 395, 10, 40);
  triangle(x1+(100*numPress), 395, x2+(100*numPress), 355, x3+(100*numPress), 395);  
}

void playTone() {
  switch(numPress) {
    case 0:
      delay(1000);
      if(instructions[numPress] == "k") {
        beep.play();
        beep.rewind();
      }
      else {
    
      }
    default:
      if(instructions[numPress] == "k") {
        beep.play();
        beep.rewind();
      }
      else {
    
      }
  }
}

void keyPressed() {
  if (key == 'b' || key == 'B') {
    numPress = numPress + 1;
    colorRect(numPress);
    drawArrow(); 
  }
}

void colorRect(int numPress) {
  fill(0, 0, 0);
  rect(50+(100*(numPress - 1)), 300, 50, 50 );
  fill(192, 192, 192);
  rect(50+(100*(numPress - 1)), 300, 50, 50 );
}
