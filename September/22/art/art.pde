// basic params for flies
int flyNum = 1000; // number of flies
PVector[] flies = new PVector[flyNum]; // array of flies' locations
int flyD = 5;
float flySpeed = 5;

void setup(){
  fullScreen();

  // initialize array with random vectors/locations
  for(int i = 0; i < flyNum; i++){
    flies[i] = new PVector(random(width), random(height));
  }
}

void draw(){
  background(0);
  fill(255);

  // iterate over all fly locations
  for(int i = 0; i < flyNum; i++){
    // for each fly...

    // the core decision-maker of each fly
    // fly will choose either to move towards mouse cursor or one of the other flies
    PVector target = binr() ? mpos() : flies[int(random(flyNum))].copy();

    // calculate new position of fly using vector math
    // new position will be between fly and decided target
    flies[i].add(target.sub(flies[i]).normalize().mult(random(flySpeed / 2, flySpeed * 2)));

    // if fly is too close to mouse, then reset the fly's position to somewhere around the border of the screen
    // gives the illusion of endless flies
    if(PVector.dist(mpos(), flies[i]) < flyD * 2){
      flies[i] = binr() ? new PVector(binr() ? width : 0, random(height)) : new PVector(random(width), binr() ? height : 0);
    }

    // render fly
    circle(flies[i].x, flies[i].y, flyD);
  }
}

// HELPER FUNCTIONS

boolean binr(){
  return random(1) < .5;
}

PVector mpos(){
  return new PVector(mouseX, mouseY);
}
