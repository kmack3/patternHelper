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
int rowCount = 0;
int activeRow = 0;
int rowNum = activeRow + 1;

int numRowStitches = 0;

void setup() {
 size(1250,700);
 background(255);
 readFile();
 drawRow(0);
 displayRowNum();
 drawArrow();
}

void draw() {
  
}

void readFile() {
  fill(0,0,0);
  rowInstructions = loadStrings("pattern.txt"); 
  rowCount = rowInstructions.length;
  textSize(40);
  drawRow(activeRow);
}

String[] getRowInstructions(int rowNum) {
  String tmpRow = rowInstructions[rowNum];
  String[] stitches = splitTokens(tmpRow, ",");
  return stitches;
}

void drawRow(int row) {
  background(255);
  textSize(40);
  String[] stitches = getRowInstructions(row);
  numRowStitches = stitches.length;
  int rowOffset = 0;
  int xOffset = 0;
  for(int i = 0; i < stitches.length; i++) {
    rowOffset = i / 10;
    if(i % 10 == 0) {
      xOffset = 0;  
    }
    if(stitches[i].equals("k")) {
       drawKnit(xCoor+(100*xOffset),yCoor+(150*rowOffset));
    }
    else if(stitches[i].equals("p")) {
       drawPurl(xCoor+(100*xOffset),yCoor+(150*rowOffset));
    }
    else if(stitches[i].equals("s")) {
       drawSkip(xCoor+(100*xOffset),yCoor+(150*rowOffset));
    }
    else if(stitches[i].equals("i")) {
      drawIncrease(xCoor+(100*xOffset),yCoor+(150*rowOffset));
    }
    else if(stitches[i].equals("d")) {
      drawDecrease(xCoor+(100*xOffset),yCoor+(150*rowOffset));
    }
    else if(stitches[i].equals("y")) {
      drawYarnOver(xCoor+(100*xOffset),yCoor+(150*rowOffset));
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
void drawKnit(float knitX, float knitY) { //knit 
  noStroke();
  fill(0);
  rect(knitX,knitY,50,50);   
}

void drawPurl(float purlX, float purlY) {// purl
  stroke(0);
  strokeWeight(1);
  fill(255);
  rect(purlX,purlY,50,50);
  line(purlX,purlY+25,purlX+50,purlY+25);
}


// increase
void drawIncrease(float decreaseX, float decreaseY) {
  rect(decreaseX,decreaseY,50,50);
  line(decreaseX+25,decreaseY+10,decreaseX+25,decreaseY+40);
  line(decreaseX+10,decreaseY+30,decreaseX+25,decreaseY+40);
  line(decreaseX+25,decreaseY+40,decreaseX+40,decreaseY+30);
}

// decrease
void drawDecrease(float increaseX, float increaseY) {
  rect(increaseX,increaseY,50,50);
  line(increaseX+40,increaseY+10,increaseX+10,increaseY+40);
  textSize(20);
  fill(0);
  text("4",increaseX+30,increaseY+40);
}

// yarn over
void drawYarnOver(float yarnX, float yarnY) {
  fill(255);
  stroke(0);
  rect(yarnX,yCoor,50,50);
  circle(yarnX+25,yarnY+25, 20);
}

void drawSkip(float skipX, float skipY) { // skip
  stroke(0);
  fill(255);
  strokeWeight(1);
  rect(skipX,skipY,49,49);
  line(skipX,skipY,skipX+50,skipY+50);
  line(skipX+50,skipY,skipX,skipY+50);
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
  fill(255,0,0);
  rect(rectX+(100*(numPress%10)), rectY+(150*div), 10, 40);
  triangle(x1+(100*(numPress%10)), rectY+5+(150*div), x2+(100*(numPress%10)), rectY-15+(150*div), 
  x3+(100*(numPress%10)), rectY+5+(150*div)); 
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
  //fill(255);
  //rect(50+(100*(numPress)), 300, 50, 50 );
  
  int rowOffset = numPress / 10;
  int xOffset = (numPress % 10) - 1;
  String[] stitches = getRowInstructions(1);
 
  if(numPress == 0);
  else {
    if(rowOffset == 0);
    else if(numPress % 10 == 0) {
        rowOffset++;
    }
    
    String instruction = stitches[(rowOffset*10)+xOffset];
    fill(255);
    rect(xCoor+(100*xOffset),yCoor+(150*rowOffset), 50, 50 );
    if(instruction.equals("k")) {
      drawKnit(xCoor+(100*xOffset),yCoor+(150*rowOffset));
    }
    else if(instruction.equals("p")) {
      drawPurl(xCoor+(100*xOffset),yCoor+(150*rowOffset));
    }
    else if(instruction.equals("s")) {
      drawSkip(xCoor+(100*xOffset),yCoor+(150*rowOffset));
    }
  }
}
