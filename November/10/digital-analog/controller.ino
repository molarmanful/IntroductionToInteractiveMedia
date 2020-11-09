void setup() {
  Serial.begin(9600);
  pinMode(2, OUTPUT);
  pinMode(8, INPUT);
  randomSeed(analogRead(A0));
}

int d = 0;

void loop() {
  Serial.println(digitalRead(8));
  if(digitalRead(8)){
    int pot = analogRead(A3);
    d ^= 1;
    digitalWrite(2, d);
    analogWrite(3, pot);
    delay(pot);
  }
  else {
    digitalWrite(2, int(random(2)));
    analogWrite(3, int(random(1024)));
  }
}
