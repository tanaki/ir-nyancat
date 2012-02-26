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
  // create canvas
  size(400, 400);
  smooth();
  noStroke();
  
  // load images
  bg = loadImage("nyan-cat-bg.png");
  img = loadImage("nyan-cat.png");
  tail = loadImage("nyan-cat-tail.png");
  arrayH = new float[163];
  
  // open port
  String portName = Serial.list()[0];
  myPort = new Serial(this, portName, 9600);
}

void draw()
{
  // read data
  if ( myPort.available() > 0) {
    val = myPort.readString();
  }
  
  // background
  if ( bgPos > 400 ) bgPos = 0;
  image(bg, -bgPos, 0);
  image(bg, 400 - bgPos, 0);
  
  // smooth the data received
  if ( val != null ){
    float tmp = float(val);
    if (!Float.isNaN(tmp) && tmp > 90 && tmp < 550 ) {
      targetH = tmp;
    }
  }
  
  // add easing to the movment
  float dh = targetH - h;
  if(abs(dh) > 1) {
    h += dh * easing;
  }
  
  // draw the tail
  for ( int i = 0; i < 165; i += 5 ) {
    image(tail, i, arrayH[i] - 100, 5, 62);
  }
  if ( initVal > 163 ) {
    shiftAndAdd(arrayH,h);
  }
  append(arrayH, h);

  // draw the nyan cat
  image(img, 140, h - 100); 
  initVal++;
  bgPos++;
}

void shiftAndAdd(float a[], float val){
  int a_length = a.length;
  System.arraycopy(a, 1, a, 0, a_length-1);
  a[a_length-1] = val;
}

