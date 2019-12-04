import processing.serial.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

String myString = null;
Serial myPort;
int numPress = 0;
String[] instructions = {"k", "k", "p", "p", "k", "k", "p", "p", "k", "k", "p", "p"};

Minim minim;
AudioSnippet beep;
int rectX = 70;
int x1 = 55;
int x2 = 75;
int x3 = 95;

void setup () {
  printArray(Serial.list());
  myPort = new Serial(this, Serial.list()[1], 115200);
  myPort.clear();
  myString = myPort.readString();
  myString = null;
  
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
  text("Use the 'f' key to move forward in the instructions", 50, 180);

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
  
  // play tone for first stitch
  playTone();
}

void draw() {
  while (myPort.available() > 0) {
    myString = myPort.readString();
    if (myString != null) {
      myString = myString.trim();
      if (myString.length() > 0) {
        println(myString);
        if (myString.equals("Forward")) {
          myString = null;
          greyRect(numPress);
          numPress = numPress + 1;
          drawArrow();
      }
      else if (myString.equals("Backward")) {
        myString = null;
        if(numPress == 0) {
          numPress = 0;
          }
    else {
      numPress = numPress - 1;
  }
    redrawRect(numPress);
    drawArrow();
      }
      }
    }
  }
      

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

void greyRect(int numPress) {
  fill(255,255,255);
  rect(50+(100*(numPress)), 300, 50, 50 );
  fill(192, 192, 192);
  rect(50+(100*(numPress)), 300, 50, 50 );
}

void redrawRect(int numPress) {
  fill(255,255,255);
  rect(50+(100*(numPress)), 300, 50, 50 );
  
  if(instructions[numPress] == "k") {
    fill(0, 0, 255);
  }
  else if(instructions[numPress] == "p") {
    fill(0, 255, 0);
  }
  rect(50+(100*(numPress)), 300, 50, 50 );
}
