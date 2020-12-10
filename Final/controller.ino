#include <Servo.h>

Servo servo;

void setup(){
  Serial.begin(9600);
  servo.attach(3);
  servo.write(0);

  contact();
}

int i = 0;
char val;
void loop(){
  if(Serial.available() > 0){
    val = Serial.read();
    scratch(val - 100);
  }
}

void contact(){
  while(Serial.available() <= 0){
    Serial.println("A");
    delay(300);
  }
}

void scratch(int s){
  if(s >= 2){
    for(i = 0; i < 180; i += s){
      if(i >= 180) i = 180;
      servo.write(i);
      delay(50);
    }
    for(i = 180; i > 0; i -= s){
      if(i <= 0) i = 0;
      servo.write(i);
      delay(50);
    }
    Serial.println("done");
  }
}
