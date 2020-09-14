// face location + diameter
int faceX = 500;
int faceY = 500;
int faceW = 500;

// eye locations + diameter (relative to center of face)
int eyeX = 100;
int eyeY = 50;
int eyeW = 100;
int pupW = 30; // pupil diameter

// mouth location + width (relative to center of face)
int mouthX = 0;
int mouthY = 100;
int mouthW = 100;

// background star frequency + diameter + orbit range
int starNum = 100;
PVector[] stars = new PVector[starNum]; // list containing all stars
int starW = 5;
int orbitW = 20;

void setup(){
  // canvas size
  size(1000, 1000);

  // generate all stars with random locations on the canvas
  for(int i = 0; i < starNum; i++){
    stars[i] = new PVector(int(random(0, 1000)), int(random(0, 1000)));
  }
}

void draw(){
  background(0);
  fill(255);

  // iterate through each star in the stars array...
  for(PVector star : stars){
    // restricts star to its orbit
    PVector s = cirConstrain(mLoc(), star, orbitW, 0);
    circle(s.x, s.y, starW); // render star
  }

  fill(0);
  stroke(255);
  circle(faceX, faceY, faceW); // render face

  circle(faceX - eyeX, faceY - eyeY, eyeW); // render eye 1 relative to face
  circle(faceX + eyeX, faceY - eyeY, eyeW); // render eye 2 relative to face

  // keeps pupil 1 location inside eye 1
  PVector pup1 = cirConstrain(mLoc(), new PVector(faceX - eyeX, faceY - eyeY), eyeW, pupW);

  // keeps pupil 2 location inside eye 2
  PVector pup2 = cirConstrain(mLoc(), new PVector(faceX + eyeX, faceY - eyeY), eyeW, pupW);

  fill(255);
  circle(pup1.x, pup1.y, pupW); // render pupil 1
  circle(pup2.x, pup2.y, pupW); // render pupil 2

  // render mouth relative to face
  line(faceX + mouthX - mouthW / 2, faceY + mouthY, faceX + mouthX + mouthW / 2, faceY + mouthY);
}

// returns mouse location
// provides an immutable source that cannot be mutated by cirConstrain()
PVector mLoc(){
  return new PVector(mouseX, mouseY);
}

// takes mouse position, position of object (e.g. pupil), radius of boundaries, and compensation value (e.g. radius of object)
// returns vector of the object constrained within the radius but as close to the mouse as possible
// example usage: pupil dimensions and eye radius --> simulate eye following mouse position
PVector cirConstrain(PVector m, PVector loc, int rad, int inner){
  // if the mouse is outside of the eye...
  if(dist(m.x, m.y, loc.x, loc.y) > rad / 2 - inner / 2){
    // vector math to keep object constrained within specified radius
    m.sub(loc);
    m.normalize();
    m.mult(rad / 2 - inner / 2);
    m.add(loc);
  }
  return m;
}
