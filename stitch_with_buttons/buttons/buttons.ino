
#include <SoftwareSerial.h>
SoftwareSerial newSerial(0, 1);

int forward = 2;
int backward = 3;

void setup(void) 
{
  // put your setup code here, to run once:
  newSerial.begin(9600);
  pinMode(forward, INPUT);
  pinMode(backward, INPUT);
}

void loop(void) 
{
  // put your main code here, to run repeatedly:
  if(digitalRead(forward) == HIGH)
  {
    newSerial.println("Forward");
  }
  else if(digitalRead(backward) == HIGH)
  {
    newSerial.println("Backward");
  }
  delay(200);
}
