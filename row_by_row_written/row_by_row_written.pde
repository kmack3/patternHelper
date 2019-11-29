
String[] rowInstruction = {"Row 1: *K1 P1* around", "Row 2: *P1, K3* around.", 
"Row 3: Row Knit around.", "Row 4: K2. *P1, K3*, repeat around until two stitches remain. P1, K1.", 
"Row 5: Row Knit around."};
int rowCount = 0;
int xPos = 600;
int yPos = 300;

void setup(){
  size (1280, 600);
  background(255, 255, 255);
  firstInstruction();
}

void draw() {
  
}

void firstInstruction() {
     String s = rowInstruction[0];
     textAlign(CENTER, CENTER);
     fill(0);
     textSize(35);
     text(s, xPos, yPos);
}

void clearCurrentInstruction() {
  background(255, 255, 255);
}


void keyPressed() {
   if (key == 'f' || key == 'F') {
     rowCount = rowCount + 1;
     if(rowCount >= rowInstruction.length) {
       rowCount = 0;
     }

   }
   else if (key == 'b' || key == 'B') {
     if(rowCount == 0) {
        rowCount = 4; 
     }
     else {
       rowCount = rowCount - 1; 
     }
     
   }
        clearCurrentInstruction();
     String s = rowInstruction[rowCount];
     fill(0);
     textSize(35);
     text(s, xPos, yPos);
     textAlign(CENTER, CENTER);
}
