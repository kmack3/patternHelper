int numPress = 0;

void setup () {
  size (6000, 600);
  background (255, 255, 255);
  smooth ();
  //drawArrow();
}


void draw() {
  for(int i = 0; i < 12; i++) {
    noFill();
    rect(50+(100*i), 300, 50, 50 );
  }
}

void keyPressed() {
   if (key == 'b' || key == 'B') {
     numPress = numPress + 1;
     colorRect(numPress);
   }
}

void colorRect(int numPress) {
   fill(204, 102, 0);
   rect(50+(100*(numPress - 1)), 300, 50, 50 );   
}
