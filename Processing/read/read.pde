/**
 * Simple Read
 * 
 * Read data from the serial port and change the color of a rectangle
 * when a switch connected to a Wiring or Arduino board is pressed and released.
 * This example works with the Wiring / Arduino program that follows below.
 */


import processing.serial.*;

Serial myPort;  // Create object from Serial class
String val;      // Data received from the serial port
float h = 100;
float targetH;
float easing = 0.05;
PImage img, bg, tail;
float [] arrayH;
int initVal = 0;
int bgPos = 0;

void setup() 
{
  size(400, 400);
  smooth();
  noStroke();
  bg = loadImage("nyan-cat-bg.png");
  img = loadImage("nyan-cat.png");
  tail = loadImage("nyan-cat-tail.png");
  arrayH = new float[163];
  
  // I know that the first port in the serial list on my mac
  // is always my  FTDI adaptor, so I open Serial.list()[0].
  // On Windows machines, this generally opens COM1.
  // Open whatever port is the one you're using.
  String portName = Serial.list()[0];
  myPort = new Serial(this, portName, 9600);
}

void draw()
{
  if ( myPort.available() > 0) {
    val = myPort.readString();
  }
  if ( bgPos > 400 ) bgPos = 0;
  image(bg, -bgPos, 0);
  image(bg, 400 - bgPos, 0);
  
  if ( val != null ){
    float tmp = float(val);
    if (!Float.isNaN(tmp) && tmp > 90 && tmp < 550 ) {
      targetH = tmp;
    }
  }
  
  float dh = targetH - h;
  if(abs(dh) > 1) {
    h += dh * easing;
  }
  
  for ( int i = 0; i < 165; i += 5 ) {
    image(tail, i, arrayH[i] - 100, 5, 62);
  }
  
  if ( initVal > 163 ) {
    shiftAndAdd(arrayH,h);
  }
  append(arrayH, h);

  image(img, 140, h - 100); 
  initVal++;
  bgPos++;
}

void shiftAndAdd(float a[], float val){
  int a_length = a.length;
  System.arraycopy(a, 1, a, 0, a_length-1);
  a[a_length-1] = val;
}


