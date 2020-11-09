bool started = false;
bool done = false;
int k = 0;
int t = 0;
int pass = 0;

void setup(){
  pinMode(12, OUTPUT);
  pinMode(11, OUTPUT);
  pinMode(10, OUTPUT);
  randomSeed(analogRead(0));
  
  Serial.begin(9600);
}

void loop(){
  
  if(t < 3 && !done){
    
    if(!started && digitalRead(5)){
      
      started = true;
      for(int i = 0; i < 4; i++){
        
        pass *= 10;
        int c = random(3, 6);
        pass += c;
        
        digitalWrite(c + 7, HIGH);
        delay(500);
        digitalWrite(c + 7, LOW);
        delay(100);
      }
    }

    else if(started){
      
      if(t < 3 && !done){
        
        int p = 0;
        for(int i = 0; i < 4; i++){
          
          int b = btn();
          while(!b) b = btn();

          p *= 10;
          p += b;

          digitalWrite(b + 7, HIGH);
          delay(500);
          digitalWrite(b + 7, LOW);
          delay(100);
        }
        
        delay(500);
        
        if(p == pass){
          for(int i = 12; i > 9; i--){
            digitalWrite(i, HIGH);
            delay(500);
          }
          done = true;
        }
        
        else {
          for(int x = 0; x < 3; x++){
            for(int i = 12; i > 9; i--)
              digitalWrite(i, HIGH);
            delay(200);
            
            for(int i = 12; i > 9; i--)
              digitalWrite(i, LOW);
            delay(100);
          }
          t++;
        }
      }
    }
  }
}

int btn(){
  for(int b = 5; b > 2; b--){
    if(digitalRead(b)) return b;
  }
  return 0;
}
