import processing.serial.*;
String myString = null;
Serial myPort;
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

String[] rowInstructions = {};
int rowCount = 0;
int activeRow = 0;
int rowNum = activeRow + 1;

int numRowStitches = 0;

void setup() {
  printArray(Serial.list());
  myPort = new Serial(this, Serial.list()[1], 115200);
  myPort.clear();
  myString = myPort.readString();
  myString = null;
  size(1250, 700);
  background(255);
  readFile();
  drawRow(0);
  displayRowNum();
  drawArrow();
}

void draw() {
  while (myPort.available() > 0) {
    myString = myPort.readString();
    if (myString != null) 
    {
      myString = myString.trim();
      if (myString.length() > 0) 
      {
        println(myString);
        if (myString.equals("Up") || myString.equals("Down")) 
        {
          if (myString.equals("Up"))
          {
            if (activeRow == rowCount - 1); 
            else 
            {
              activeRow++;
            }
          } else if (myString.equals("Down"))
          {
            if (activeRow == 0);
            else 
            {
              activeRow--;
            }
          }
          //println("Active row: " + activeRow);
          background(255);
          drawRow(activeRow);
          numPress = 0;
        } else if (myString.equals("Left") || myString.equals("Right")) 
        {
          if (myString.equals("Left")) 
          {
            if (numPress == 0);
            else 
            {
              redrawInstruction(numPress);
              numPress--;
              drawArrow();
              stitchDone(numPress-1);
            }
          } else if (myString.equals("Right")) 
          {
            if (numPress < numRowStitches - 1) 
            {
              numPress++;
              drawArrow();
              stitchDone(numPress-1);
            } else if (numPress == numRowStitches - 1) 
            {
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
    }
  }
}

void readFile() {
  fill(0, 0, 0);
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
  for (int i = 0; i < stitches.length; i++) {
    rowOffset = i / 10;
    if (i % 10 == 0) {
      xOffset = 0;
    }
    if (stitches[i].equals("k")) {
      drawKnit(xCoor+(100*xOffset), yCoor+(150*rowOffset));
    } else if (stitches[i].equals("p")) {
      drawPurl(xCoor+(100*xOffset), yCoor+(150*rowOffset));
    } else if (stitches[i].equals("sk")) {
      drawSkip(xCoor+(100*xOffset), yCoor+(150*rowOffset));
    }
    xOffset++;
  } 
  displayRowNum();
  drawArrow();
}

void displayRowNum() {
  rowNum = activeRow + 1;
  textSize(35);
  fill(0, 0, 0);
  text("Row: " + rowNum, 800, 600);
}

/*********** different stitch types ***********/
void drawKnit(float knitX, float knitY) { //knit 
  noStroke();
  fill(0);
  rect(knitX, knitY, 50, 50);
}

void drawPurl(float purlX, float purlY) {// purl
  stroke(0);
  strokeWeight(3);
  fill(255);
  rect(purlX, purlY, 50, 50);
  line(purlX, purlY+25, purlX+50, purlY+25);
}

void drawSkip(float skipX, float skipY) { // skip
  stroke(0);
  fill(255);
  strokeWeight(3);
  rect(skipX, skipY, 49, 49);
  line(skipX, skipY, skipX+50, skipY+50);
  line(skipX+50, skipY, skipX, skipY+50);
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
  fill(255, 0, 0);
  rect(rectX+(100*(numPress%10)), rectY+(150*div), 10, 40);
  triangle(x1+(100*(numPress%10)), rectY+5+(150*div), x2+(100*(numPress%10)), rectY-15+(150*div), 
    x3+(100*(numPress%10)), rectY+5+(150*div));
}

/*********** grey out completed stitches ***********/
void stitchDone(int numPress) {
  fill(255, 255, 255);
  noStroke();

  int rowOffset = 0;
  float xOffset = 0;

  xOffset = numPress % 10;
  rowOffset = numPress / 10;
  if (rowOffset == 0);
  if (numPress % 10 == 0 & xOffset != 0) {
    rowOffset++;
  }
  if (numPress - 1 >= -1) {
    rect(xCoor+(100*(xOffset)-2), yCoor+(150*rowOffset)-2, 54, 54 );
    fill(192);
    rect(xCoor+(100*(xOffset)-2), yCoor+(150*rowOffset)-2, 54, 54 );
  }
}

/*********** redraw previously completed stitches ***********/
void redrawInstruction(int numPress) {
  //fill(255);
  //rect(50+(100*(numPress)), 300, 50, 50 );

  int rowOffset = numPress / 10;
  int xOffset = (numPress % 10) - 1;
  String[] stitches = getRowInstructions(1);

  if (numPress == 0);
  else {
    if (rowOffset == 0);
    else if (numPress % 10 == 0) {
      rowOffset++;
    }


    println("numPress: ", numPress);
    println("xOffset: ", xOffset);

    String instruction = stitches[(rowOffset*10)+xOffset];
    println("instruction: " + instruction);
    fill(255);
    rect(xCoor+(100*xOffset), yCoor+(150*rowOffset), 50, 50 );
    if (instruction.equals("k")) {
      drawKnit(xCoor+(100*xOffset), yCoor+(150*rowOffset));
    } else if (instruction.equals("p")) {
      drawPurl(xCoor+(100*xOffset), yCoor+(150*rowOffset));
    } else if (instruction.equals("s")) {
      drawSkip(xCoor+(100*xOffset), yCoor+(150*rowOffset));
    }
  }
}
