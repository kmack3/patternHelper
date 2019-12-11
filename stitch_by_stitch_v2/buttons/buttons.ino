
#include <SoftwareSerial.h>
SoftwareSerial newSerial(0, 1);

int up = 2;
int down = 3;
int left = 4;
int right = 5;

void setup(void) 
{
  // put your setup code here, to run once:
  newSerial.begin(9600);
  pinMode(up, INPUT);
  pinMode(down, INPUT);
  pinMode(left, INPUT);
  pinMode(right, INPUT);
}

void loop(void) 
{
  // put your main code here, to run repeatedly:
  if(digitalRead(up) == HIGH)
  {
    newSerial.println("Up");
  }
  else if(digitalRead(down) == HIGH)
  {
    newSerial.println("Down");
  }
  else if(digitalRead(left) == HIGH)
  {
    newSerial.println("Left");
  }
  else if(digitalRead(right) == HIGH)
  {
    newSerial.println("Right");
  }
  
  delay(500);
}
