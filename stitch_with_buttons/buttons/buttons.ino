int forward = 15;
int backward = 16;

void setup(void) 
{
  // put your setup code here, to run once:
  Serial.begin(115200);
  while ( !Serial ) delay(10);
  pinMode(forward, INPUT);
  pinMode(backward, INPUT);
}

void loop(void) 
{
  // put your main code here, to run repeatedly:
  if(digitalRead(forward) == HIGH)
  {
    Serial.println("Forward");
  }
  else if(digitalRead(backward) == HIGH)
  {
    Serial.println("Backward");
  }
  delay(200);
}
