import java.lang.Math;
import processing.serial.*;
import java.nio.ByteBuffer;

Serial port;

void setup(){
  println(Serial.list());
  port = new Serial(this, Serial.list()[0], 9600);
}

void draw(){}

String norms = "qazwsxedcrfvtgbyhnujmik,ol.p;/";

void keyPressed(){
  if(norms.contains(key + "")){
    int i = norms.indexOf(key + "");
    int hz = (int) toHz(i);
    port.write(hz + "e");
    println(hz);
  }
}

void keyReleased(){
  port.write("x");
}

double toHz(float n){
  return Math.pow(2, n / 12) * 440;
}
