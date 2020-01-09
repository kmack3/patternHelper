import processing.serial.*;

import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;



Minim minim;
AudioSnippet purl_sound;
AudioSnippet knit_sound;
AudioSnippet  skip_sound;
AudioSnippet increase_sound;
AudioSnippet decrease_sound;

// for sound keeping track of last stitch spoken
String lastStitch = "";

int numPress = 0;
int rows = 4;
int cols = 10;

float xCoor = 75;
float yCoor = 50;

float rectX = 95;
float rectY = 125;

float x1 = 80;
float x2 = 100;
float x3 = 120;

  int rowOffset = 0;
  int xOffset = 0;

String[] rowInstructions = {};
String[] colorInstructions = {};

int rowCount = 0;
int activeRow = 0;
int rowNum = activeRow + 1;

int numRowStitches = 0;

String myString = null;
Serial myPort;

int r,g,b = 0;

void setup() {
 size(1250,700);
 background(255);
 
   minim = new Minim(this);
  purl_sound = minim.loadSnippet("purl.wav");
  knit_sound = minim.loadSnippet("knit.wav");
  skip_sound = minim.loadSnippet("skip.wav");
  increase_sound = minim.loadSnippet("increase.wav");
  decrease_sound = minim.loadSnippet("decrease.wav");
  
  myPort = new Serial(this, Serial.list()[1], 115200);
  myPort.clear();
  myString = myPort.readString();
  myString = null;
 
 readFile();
 drawRow(0);
 displayRowNum();
 drawArrow();
}

//void draw() {
//  while (myPort.available() > 0) {
//    myString = myPort.readString();
//    if (myString != null) 
//    {
//      myString = myString.trim();
//      if (myString.length() > 0) 
//      {
//        println(myString);
//        if (myString.equals("Up") || myString.equals("Down")) 
//        {
//          if (myString.equals("Up"))
//          {
//            if (activeRow == rowCount - 1); 
//            else 
//            {
//              activeRow++;
//            }
//          } else if (myString.equals("Down"))
//          {
//            if (activeRow == 0);
//            else 
//            {
//              activeRow--;
//            }
//          }
//          //println("Active row: " + activeRow);
//          background(255);
//          drawRow(activeRow);
//          numPress = 0;
//        } else if (myString.equals("Left") || myString.equals("Right")) 
//        {
//          if (myString.equals("Left")) 
//          {
//            if (numPress == 0);
//            else 
//            {
//              redrawInstruction(numPress);
//              numPress--;
//              drawArrow();
//              stitchDone(numPress-1);
//            }
//          } else if (myString.equals("Right")) 
//          {
//            if (numPress < numRowStitches - 1) 
//            {
//              numPress++;
//              drawArrow();
//              stitchDone(numPress-1);
//            } else if (numPress == numRowStitches - 1) 
//            {
//              println("numPress: " + numPress);
//              numPress = 0;
//              activeRow++;
//              background(255);
//              stitchDone(numPress);
//              drawRow(activeRow);
//            }
//          }
//        }
//      }
//    }
//  }
//}

void draw() {
  
}

void readFile() {
  fill(0,0,0);
  rowInstructions = loadStrings("pattern.txt"); 
  colorInstructions = loadStrings("colors.txt");
  rowCount = rowInstructions.length;
  textSize(40);
  drawRow(activeRow);
}

String[] getRowInstructions(int rowNum) {
  String tmpRow = rowInstructions[rowNum];
  String[] stitches = splitTokens(tmpRow, ",");
  return stitches;
}

String[] getColorInstructions(int rowNum) {
  String tmpRow = colorInstructions[rowNum];
  String[] stitchColors = splitTokens(tmpRow, ",");
  return stitchColors;
}

void drawRow(int row) {
  background(255);
  textSize(40);
  String[] stitches = getRowInstructions(row);
  numRowStitches = stitches.length;
  int rowOffset = 0;
  int xOffset = 0;
  String[] stitchColors = getColorInstructions(row);
  //println(stitchColors);
  for(int i = 0; i < stitches.length; i++) {
    rowOffset = i / 10;
    if(i % 10 == 0) {
      xOffset = 0;  
    }
    if(stitches[i].equals("k")) {
       drawKnit(xCoor+(100*xOffset),yCoor+(150*rowOffset),stitchColors[i]);
    }
    else if(stitches[i].equals("p")) {
       drawPurl(xCoor+(100*xOffset),yCoor+(150*rowOffset),stitchColors[i]);
    }
    else if(stitches[i].equals("s")) {
       drawSkip(xCoor+(100*xOffset),yCoor+(150*rowOffset),stitchColors[i]);
    }
    else if(stitches[i].equals("i")) {
      drawIncrease(xCoor+(100*xOffset),yCoor+(150*rowOffset),stitchColors[i]);
    }
    else if(stitches[i].equals("d")) {
      drawDecrease(xCoor+(100*xOffset),yCoor+(150*rowOffset),stitchColors[i]);
    }
    else if(stitches[i].equals("y")) {
      drawYarnOver(xCoor+(100*xOffset),yCoor+(150*rowOffset),stitchColors[i]);
    }
    xOffset++;
  } 
  displayRowNum();
  drawArrow();
}

void displayRowNum() {
  rowNum = activeRow + 1;
  textSize(35);
  fill(0,0,0);
  text("Row: " + rowNum, 800, 600);
}

void keyPressed() {  
  // UP and DOWN to navigate through rows
  if(keyCode == UP || keyCode == DOWN) {
    if(keyCode == UP) {
      if(activeRow == rowCount - 1); 
      else {
        activeRow++;
        numPress = 0;
      }
    }
    else if(keyCode == DOWN) {
      if(activeRow == 0);
      else {
        activeRow--;
      }
    }
    background(255);
    drawRow(activeRow);
    numPress = 0;
    drawArrow();
  }
  
  // LEFT and RIGHT to navigate through stitches
  else if(keyCode == LEFT || keyCode == RIGHT) {
    if(keyCode == LEFT) {
      if(numPress == 0);
      else if(numPress % 10 == 0) {
        //println("rowoffset: "+rowOffset);
        if(numPress ==  0); 
        else {
         //int goBack = numPress / 10;
         numPress--;
         redrawInstruction(numPress);
         drawArrow();
         stitchDone(numPress-1);
        }
      }
      else {
        redrawInstruction(numPress);
        numPress--;
        drawArrow();
        stitchDone(numPress-1);
        print("numPress: " + numPress);
      }
     }
     else if(keyCode == RIGHT) {
       if(numPress < numRowStitches - 1) {
         numPress++;
         drawArrow();
         stitchDone(numPress-1);
       }
       else if(numPress == numRowStitches - 1) {
         println("numPress: " + numPress);
         numPress = 0;
         activeRow++;
         background(255);
         stitchDone(numPress);
         drawRow(activeRow);
       }
    }
  }
}

/*********** different stitch types ***********/
void drawKnit(float knitX, float knitY, String stitchColor) { //knit 
  if(stitchColor.equals("1")) {
    r = 255;
    g = b = 0;
    
  }
  else {
    b = 255;
    r = g = 0;
  }
  fill(r,g,b);
  text("k",knitX+10,knitY+50);   
}

void drawPurl(float purlX, float purlY, String stitchColor) {// purl
  //stroke(0);
  strokeWeight(1);
  
  if(stitchColor.equals("1")) {
    r = 255;
    g = b = 0;
    
  }
  else {
    b = 255;
    r = g = 0;
  }
  fill(r,g,b);
  text("p",purlX+10,purlY+45);
}

// increase
void drawIncrease(float decreaseX, float decreaseY,String stitchColor) {
  if(stitchColor.equals("1")) {
    r = 255;
    g = b = 0;
    
  }
  else {
    b = 255;
    r = g = 0;
  }
  fill(r,g,b);
  text("i",decreaseX+10,decreaseY+50);
}

// decrease
void drawDecrease(float increaseX, float increaseY,String stitchColor) {
  if(stitchColor.equals("1")) {
    r = 255;
    g = b = 0;
    
  }
  else {
    b = 255;
    r = g = 0;
  }
  fill(r,g,b);
  text("d",increaseX+10,increaseY+50);
}

// yarn over
void drawYarnOver(float yarnX, float yarnY,String stitchColor) {
  if(stitchColor.equals("1")) {
    r = 255;
    g = b = 0;
    
  }
  else {
    b = 255;
    r = g = 0;
  }
  fill(r,g,b);
  text("y",yarnX+10,yCoor+50);
  
}

void drawSkip(float skipX, float skipY, String stitchColor) { // skip
  if(stitchColor.equals("1")) {
    r = 255;
    g = b = 0;
    
  }
  else {
    b = 255;
    r = g = 0;
  }
  fill(r,g,b);
  text("s",skipX+10,skipY+50);
}

/*********** draw the stitch pointing arrow ***********/
void drawArrow() {
  float clearRectX = 50;
  float clearRectY = 103;
  int div = numPress / 10;
  noStroke();
  fill(255);
  rect(clearRectX, clearRectY, 1150, 90);
  rect(clearRectX, clearRectY+150, 1150, 90);
  rect(clearRectX, clearRectY+300, 1150, 90);
  rect(clearRectX, clearRectY+450, 700, 90);
  fill(0);
  rect(rectX+(100*(numPress%10)), rectY+(150*div), 10, 40);
  triangle(x1+(100*(numPress%10)), rectY+5+(150*div), x2+(100*(numPress%10)), rectY-15+(150*div), 
  x3+(100*(numPress%10)), rectY+5+(150*div));
  
  playTone(activeRow);
}


void playTone(int row) {
  //int rowOffset = numPress / 10;
  //int xOffset = (numPress % 10) - 1;
  String[] stitches = getRowInstructions(row);
  //println(stitches);
  for(int i = 0; i < stitches.length; i++) {
    rowOffset = numPress / 10;
    //println("i: " + i + " stitch: " + stitches[i]);
    if(numPress % 10 == 0) {
      xOffset = 0;  
    }

    // see if we should play a tone or not
    // only pay tone if stitch type has changed
    if (!stitches[numPress].equals(lastStitch)) {
      if(stitches[numPress].equals("k")) {
          //println("knit");
            knit_sound.play();
            knit_sound.rewind();
            lastStitch = "k";
      }
      else if (stitches[numPress].equals("s")) {
            skip_sound.play();
            skip_sound.rewind();
            lastStitch = "s";
      }
      else if (stitches[numPress].equals("p")){
            purl_sound.play();
            purl_sound.rewind();
            lastStitch = "p";
            //println("purl");
      }
      else if(stitches[numPress].equals("i")) {
        increase_sound.play();
        increase_sound.rewind();
        lastStitch = "i";
      }
      else {
        decrease_sound.play();
        decrease_sound.rewind();
        lastStitch = "d";
      }
    }
  }
}

/*********** grey out completed stitches ***********/
void stitchDone(int numPress) {
  fill(255,255,255);
  noStroke();
  
  int rowOffset = 0;
  float xOffset = 0;
  
  xOffset = numPress % 10;
  rowOffset = numPress / 10;
  if(rowOffset == 0);
  if(numPress % 10 == 0 & xOffset != 0) {
      rowOffset++;
  }
  if(numPress - 1 >= -1) {
  rect(xCoor+(100*(xOffset)-2), yCoor+(150*rowOffset)-2, 54,54 );
  fill(192);
  rect(xCoor+(100*(xOffset)-2), yCoor+(150*rowOffset)-2, 54,54 );
  }
}

/*********** redraw previously completed stitches ***********/
void redrawInstruction(int numPress) {

  int rowOffset = numPress / 10;
  int xOffset = (numPress % 10) - 1;
  String[] stitches = getRowInstructions(activeRow);
  String[] stitchColors = getColorInstructions(activeRow);

  if(numPress == 0);
  else {
    if(rowOffset == 0);
    else if(numPress % 10 == 0) {
        rowOffset++;
    }
    
    String instruction = stitches[(rowOffset*10)+xOffset];
    fill(255);
    noStroke();
    rect(xCoor+(100*xOffset)-2,yCoor+(150*rowOffset)-2, 54, 54 );
    if(instruction.equals("k")) {
      drawKnit(xCoor+(100*xOffset),yCoor+(150*rowOffset),stitchColors[numPress-1]);
    }
    else if(instruction.equals("p")) {
      drawPurl(xCoor+(100*xOffset),yCoor+(150*rowOffset),stitchColors[numPress-1]);
    }
    else if(instruction.equals("s")) {
      drawSkip(xCoor+(100*xOffset),yCoor+(150*rowOffset),stitchColors[numPress-1]);
    }
    else if(instruction.equals("i")) {
      drawIncrease(xCoor+(100*xOffset),yCoor+(150*rowOffset),stitchColors[numPress-1]);
    }
    else if(instruction.equals("d")) {
      drawDecrease(xCoor+(100*xOffset),yCoor+(150*rowOffset),stitchColors[numPress-1]);
    }
    else {
      drawYarnOver(xCoor+(100*xOffset),yCoor+(150*rowOffset),stitchColors[numPress-1]);
    }
  }
}
