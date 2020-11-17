void setup() {
  Serial.begin(9600); 
}

int v = 0;
void loop() {
    int t = (analogRead(A0) - 512) / 56;
    Serial.println(t);
  while(Serial.available()){
    int c = Serial.read();
    if(c >= '0' && c <= '9'){
      v = 10 * v + c - '0';
    }
    else if(c == 'e'){
      Serial.println(v);
      tone(8, v + t);
      v = 0;
    }
    else if(c == 'x'){
      noTone(8);
    }
  }
}
