/*
Meghana Khandekar & Willa Tracosas - Physical Computing, Final
 17 December 2012
 Physical Drawing
 */

import processing.serial.*;
PImage img;  //needs to be here to load the image

Serial myPort;
float vals[] = new float[10];

// *************** INITIALIZE ********************************************* 

float xPos = 0;
float yPos = 0;
float StartZ; // Z button
float clearC;  // c
float DrawX;  // x axis
float DrawY;  // y axis
int angle = 80;
float easing = 0.01;
float x;
float y;
int l = 50;

boolean btnStateStart = false;  //start
boolean btnStateClear = false;  //clear
boolean btnStateSave = false;   //save

final int STATE_DRAW1 = 0;  // bw
final int STATE_DRAW2 = 1;  // earth tones
final int STATE_DRAW3 = 2;  // color

int state = STATE_DRAW1; // start state


// *************** SET UP *************************************************

void setup() {
  size (1440, 850);
  size(1440, 850); //this size ALWAYS has to match the size of the board for the image to load
  img = loadImage("introscreen.png"); // this title ALWAYS has to be the same as the image and the image needs to be in the folder for the sketch
  image(img, 0, 0);

  for (int i=0; i<vals.length; i++) {   
    vals[i] = 0;
  }

  int portId = 5;
  String portName = Serial.list()[portId];
  myPort = new Serial(this, portName, 115200);

  PFont font;
  font = loadFont("HelveticaNeue-Bold-32.vlw");
  textFont(font, 24);
}



// *************** DRAW *****************************************************

void draw() {
  DrawX = vals[0];   //x joystick
  DrawY = vals[1];   //y joystick
  xPos = vals[2];    //x acc
  yPos = vals[3];    //y acc
  clearC = vals[5];  //top button
  StartZ = vals[6];  //bottom button

  xPos = map((vals[2]), 400, 700, 0, 1440);    // map drawing to canvas
  yPos = map((vals[3]), 300, 750, 0, 850);

  // CLEAR CANVAS

  if (clearC > 0) {
    background(255);
  }

  // SWITCH STATE

  switch(state) {
  case STATE_DRAW1: 
    drawState_Draw1();
    break;
  case STATE_DRAW2: 
    drawState_Draw2();
    break;
  case STATE_DRAW3:
    drawState_Draw3(); 
    break;
  }


  // *************** BUTTONS *************** 

  // START SCREEN

  if (btnStateStart ==  false && vals[7] == 1) {  // green
    image(img, 0, 0);
    btnStateStart = true;
  }
  else if (vals[7] == 0) {
    btnStateStart = false;
  }

  // CLEAR

  if (btnStateClear ==  false && vals[8] == 1) {    // gray
    fill(255, 255, 255, 255);
    noStroke();
    rect(0, 0, 1440, 850);
    btnStateClear = true;
  }
  else if (vals[8] == 0) {
    btnStateClear = false;
  }

  // SAVE

  if (btnStateSave ==  false && vals[9] == 1) {  // yellow
    saveFrame("WiiDrawing-######.png");
    fill(255, 255, 255, 255);
    noStroke();
    rect(400, 320, 650, 200);
    fill(0, 0, 0, 240);
    textSize(32);
    text("Your drawing has been saved!", 500, 400);
    textSize(18);
    text("Press the Green button to start a new drawing.", 530, 450);  
    btnStateSave = true;
  }
  else if (vals[8] == 0) {
    btnStateSave = false;
  }
}    // end draw loop



// *************** SWTITCH STATES  ********************************************


// *************** 1 — Black + White *************** 


void drawState_Draw1() {

  // UP

  if (StartZ > 0 && DrawY >= 129) {
    noStroke();
    angle += 5;
    float val = cos(radians(angle)) * 3;
    for (int a = 0; a < 360; a += 7) {
      float xoff = cos(radians(a)) * val;
      float yoff = sin(radians(a)) * val;
      fill(0, 0, 0, 40);

      float targetX1 = xPos;
      float targetY1 = yPos;
      x += (targetX1 - x) * easing;
      y += (targetY1 - y) * easing;
      ellipse(x + xoff, y + yoff, val, val);
    }
    fill(0, 0, 0, 3);
    ellipse(xPos, yPos, 10, 10);
  }  


  // RIGHT

  if (StartZ > 0 && DrawX >= 129) {
    noStroke();
    angle += 100;
    float val = cos(radians(angle)) * 3;
    for (int a = 0; a < 360; a += 7) {
      float xoff = cos(radians(a)) * val;
      float yoff = sin(radians(a)) * val;
      fill(0, 0, 0, 100);

      float targetX1 = xPos;
      float targetY1 = yPos;
      x += (targetX1 - x) * easing;
      y += (targetY1 - y) * easing;
      ellipse(x + xoff, y + yoff, val, val);
    }
    fill(0, 0, 0, 5);
    ellipse(xPos, yPos, 10, 10);
  }

  // DOWN

  if (StartZ > 0 && DrawY < 128) {
    noStroke();
    angle += 5;
    float val = cos(radians(angle)) * 3;
    for (int a = 0; a < 360; a += 7) {
      float xoff = cos(radians(a)) * val;
      float yoff = sin(radians(a)) * val;
      fill(0, 0, 0, 10);

      float targetX1 = xPos;
      float targetY1 = yPos;
      x += (targetX1 - x) * easing;
      y += (targetY1 - y) * easing;
      ellipse(x + xoff, y + yoff, val, val);
    }
    fill(0, 0, 0, 5);
    ellipse(xPos, yPos, 50, 50);
  }

  // LEFT

  if (StartZ > 0 && DrawX < 128) {
    noStroke();
    angle += 5;
    float val = cos(radians(angle)) * 10;
    for (int a = 0; a < 360; a += 7) {
      float xoff = cos(radians(a)) * val;
      float yoff = sin(radians(a)) * val;
      fill(0, 0, 0, 50);

      float targetX1 = xPos;
      float targetY1 = yPos;
      x += (targetX1 - x) * easing;
      y += (targetY1 - y) * easing;
      ellipse(x + xoff, y + yoff, val, val);
    }
    fill(0, 0, 0, 10);
    ellipse(xPos, yPos, 30, 30);
  }

  // OTHERWISE, THESE KEYS

  if (keyPressed) {
    if (key == '2') {
      state = STATE_DRAW2;
    }
    else if (key == '3') {
      state = STATE_DRAW3;
    }
  }
}


// *************** 2 — Earth Tones *************** 


void drawState_Draw2() {

  // UP

  if (StartZ > 0 && DrawY >= 129) {
    noStroke();
    angle += 5;
    float val = cos(radians(angle)) * 3;
    for (int a = 0; a < 360; a += 7) {
      float xoff = cos(radians(a)) * val;
      float yoff = sin(radians(a)) * val;
      fill(199, 178, 153, 100);

      float targetX1 = xPos;
      float targetY1 = yPos;
      x += (targetX1 - x) * easing;
      y += (targetY1 - y) * easing;
      ellipse(x + xoff, y + yoff, val, val);
    }
    fill(199, 178, 153, 10);
    ellipse(xPos, yPos, 10, 10);
  }  


  // RIGHT

  if (StartZ > 0 && DrawX >= 129) {
    noStroke();
    angle += 100;
    float val = cos(radians(angle)) * 3;
    for (int a = 0; a < 360; a += 7) {
      float xoff = cos(radians(a)) * val;
      float yoff = sin(radians(a)) * val;
      fill(153, 134, 117, 100);

      float targetX1 = xPos;
      float targetY1 = yPos;
      x += (targetX1 - x) * easing;
      y += (targetY1 - y) * easing;
      ellipse(x + xoff, y + yoff, val, val);
    }
    fill(153, 134, 117, 10);
    ellipse(xPos, yPos, 10, 10);
  }

  // DOWN

  if (StartZ > 0 && DrawY < 128) {
    noStroke();
    angle += 5;
    float val = cos(radians(angle)) * 3;
    for (int a = 0; a < 360; a += 7) {
      float xoff = cos(radians(a)) * val;
      float yoff = sin(radians(a)) * val;
      fill(193, 39, 45, 100);

      float targetX1 = xPos;
      float targetY1 = yPos;
      x += (targetX1 - x) * easing;
      y += (targetY1 - y) * easing;
      ellipse(x + xoff, y + yoff, val, val);
    }
    fill(193, 39, 45, 5);
    ellipse(xPos, yPos, 50, 50);
  }

  // LEFT

  if (StartZ > 0 && DrawX < 128) {
    noStroke();
    angle += 5;
    float val = cos(radians(angle)) * 5;
    for (int a = 0; a < 360; a += 7) {
      float xoff = cos(radians(a)) * val;
      float yoff = sin(radians(a)) * val;
      fill(96, 56, 19, 100);

      float targetX1 = xPos;
      float targetY1 = yPos;
      x += (targetX1 - x) * easing;
      y += (targetY1 - y) * easing;
      ellipse(x + xoff, y + yoff, val, val);
    }
    fill(193, 39, 45, 10);
    ellipse(xPos, yPos, 30, 30);
  }

  // OTHERWISE, THESE KEYS

  if (keyPressed) {
    if (key == '1') {
      state = STATE_DRAW1;
    }
    else if (key == '3') {
      state = STATE_DRAW3;
    }
  }
}


// *************** 3 — Color *************** 


void drawState_Draw3() {
  if (StartZ > 0) {
    stroke(20, 20, 20, 20);
    line(xPos, yPos, 750, 425);
  }

  if (StartZ > 0 && DrawX > 129 && DrawX < 129) {
    for (int i = 0; i < 10; i++) {
      stroke(20, 20, 20, 10);
      ellipse(xPos, yPos, 20*i, 20*i);
    }
  }

  if (StartZ > 0 && DrawY < 124) {
    fill(99, 4, 96, 100);
    stroke(10);
    ellipse(xPos, yPos, 20, 20);
  }

  if (StartZ > 0 && DrawY > 124) {
    fill(247, 148, 29, 100);
    noStroke();
    ellipse(xPos, yPos, 40, 40);
  }

  if (keyPressed) {
    if (key == '1') {
      state = STATE_DRAW1;
    }
    else if (key == '2') {
      state = STATE_DRAW2;
    }
  }
}





// *************** KEYSTROKES ********************************************

void keyReleased() {

  // "I" for INFO

  if (key == 'I' || key == 'i') {
    image(img, 0, 0);
  }

  // "C" for CLEAR
 
  if (key == 'C' || key == 'c') {
    background(255);
  }

  // "S" for SAVE

  if (key == 'S' || key == 's') {
    saveFrame("WiiDrawing-######.png");
    fill(255, 255, 255, 255);
    noStroke();
    rect(400, 320, 650, 200);
    fill(0, 0, 0, 240);
    textSize(32);
    text("Your drawing has been saved!", 500, 400);
    textSize(18);
    text("Press the Green button to start a new drawing.", 530, 450);  
  }
}



// *************** SERIAL PRINT ********************************************

void serialEvent( Serial serial) {
  String s = serial.readStringUntil('\n' );

  if ( s != null ) {
    s=trim(s); // prints only values, nothing empty
    String temp[] = split(s, ',');  // converts string to numbers
    if (temp.length == 10) {
      vals = float(temp);
    }
    println(s);
    println(vals);
    //parseSerialData(s);
  }
}

