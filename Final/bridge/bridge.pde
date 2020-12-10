import websockets.*;
import processing.serial.*;

WebsocketClient ws;
JSONObject data;

Serial port;
String val;
char d;
boolean contacted;
boolean busy;

void setup(){
  ws = new WebsocketClient(this, "ws://localhost:3000");
  port = new Serial(this, Serial.list()[0], 9600);
  port.bufferUntil('\n');

  contacted = false;
  busy = false;
  d = (char) 0;
}

void draw(){
  if(!busy && d >= 102){
    busy = true;
    port.write(d);
  }
}

void webSocketEvent(String msg){
  data = parseJSONObject(msg);
  int s = data.getInt("power") / 10;
  d = (char) (s + 100);
}

void serialEvent(Serial port){
  val = port.readStringUntil('\n');
  if(val != null){
    val = trim(val);
    println(val);

    if(!contacted){
      if(val.equals("A")){
        port.clear();
        contacted = true;
        port.write("A");
        println("contact");
      }
    }

    else if(val.equals("done")){
      busy = false;
    }
  }
}
