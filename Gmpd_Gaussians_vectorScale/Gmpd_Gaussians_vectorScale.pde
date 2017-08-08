// File: GPG_vectorScale.pde
// Author: Mario Ezekiel H. (m-ezekiel.com)
// Playback and image export of Gamepad Gaussians data files
// It renders at about 10 fps for 5120 x 3200 image resolution

Table table;
int index = 0;

// VARIABLE DEFINITIONS
float analogX, analogY, analogU, analogV;
boolean A1, A2, A3, A4, M1, M2, L1, L2, R1, R2;
boolean left, right, up, down, select1, select2;

// INITIALIZE PARAMETERS
int xpos = 0; int ypos = 0;
int dpX = 300; int dpY = 300;
int brushSize_X = 350;
int brushSize_Y = 350;
int red, blue, green = 0;
int alpha = 60;

int scaleFactor = 1;

int x_mean;
int y_mean;

void setup() {
  // size(10240, 6400);
  // size(5120, 3200);
  // size(3840, 2400);
  // size(1920, 1200);
  size(1280, 800);
  background(0, 100);
  noStroke();
  frameRate(60);
  x_mean = width / 2;
  y_mean = height / 2;

  // Gorgeous transparent color manipulation
  table = loadTable("2017-04-09-18-59-15_gamepadKeys.txt", "header, tsv");

  println(table.getRowCount() + " total rows in table");
  println(table.getColumnCount() + " total columns in table");
}


void draw() {

  // GET DATA
  xpos = table.getInt(index, "xpos") * scaleFactor;
  ypos = table.getInt(index, "ypos") * scaleFactor;
  brushSize_X = table.getInt(index, "sX") * scaleFactor;
  brushSize_Y = table.getInt(index, "sY") * scaleFactor;
  dpX = table.getInt(index, "dpX") * scaleFactor;
  dpY = table.getInt(index, "dpY") * scaleFactor;
  red = table.getInt(index, "red");
  green = table.getInt(index, "green");
  blue = table.getInt(index, "blue");
  alpha = table.getInt(index, "opacity");
  analogX = table.getFloat(index, "anlgX");
  analogY = table.getFloat(index, "anlgY");
  analogU = table.getFloat(index, "anlgU");
  analogV = table.getFloat(index, "anlgV");
  x_mean = table.getInt(index, "x_mean");
  y_mean = table.getInt(index, "y_mean");

  if (index < table.getRowCount() - 1) {
    drawShapes();
    // Must fix preview to reflect updated keymap
    // togglePreview();
    index = index + 1; 
  }

  println("index: "+index);

  // Add save frame and exit.
  if (index == table.getRowCount() - 1) {
    saveFrame("hd_image11.png");
    exit();
  }
}


public void drawShapes() {
  fill(red, green, blue, alpha);
  ellipse(xpos, ypos, analogX * brushSize_X, analogY * brushSize_Y);
  ellipse(xpos, ypos, analogU * brushSize_X, analogV * brushSize_Y);
}


// ---------------
// Toggle preview
// ---------------

public void togglePreview() {
  int w = width;
  int h = height;

  // Outer window
  int owB = w/9; // 160 (default is 8)
  float owH = owB/2.5; // 60
  int owX = width - owB - 0; // Minus 300 for the video demo, 0 otherwise
  int owY = 0;
  int gap = w/45; // 28
  // Inner window
  float iwB = owB/3.125;
  float iwH = iwB * 0.625;
  // Centerpoints
  float owCX = owX + (owB/2);
  float owCY = owY + (owH/2);
  float iwCX = owX + owB/12 + iwB/2;
  float iwCY = owY + owH/6 + iwH/2;  
  // Parameter values
  String opacity = str(alpha);
  String rd = str(red);
  String grn = str(green);
  String blu = str(blue);
  String x_mn = str(x_mean);
  String y_mn = str(y_mean);
  String dX = str(dpX/4);
  String dY = str(dpY/4);

  int brushScale = w/45;

  // Head Up Display (outer window)
  fill(0, 155);
  rect(owX, owY, owB, owH);


  // Prototype for inner window preview
  stroke(100);
  rect(owX + owB/12, owY + owH/6, iwB, iwH);
  noStroke();


  stroke(150);
  fill(red, green, blue, 127);

  // X-DISPERSION
  ellipse(iwCX - dpX/20 + (x_mean - width/2)/25, iwCY + (y_mean - height/2)/25, 
    brushSize_X/brushScale, brushSize_Y/brushScale);

  ellipse(iwCX + dpX/20 + (x_mean - width/2)/25, iwCY + (y_mean - height/2)/25, 
    brushSize_X/brushScale, brushSize_Y/brushScale);

  // Y-DISPERSION
  ellipse(iwCX + (x_mean - width/2)/25, iwCY - dpY/30 + (y_mean - height/2)/25, 
    brushSize_X/brushScale, brushSize_Y/brushScale);
  ellipse(iwCX + (x_mean - width/2)/25, iwCY + dpY/30 + (y_mean - height/2)/25, 
    brushSize_X/brushScale, brushSize_Y/brushScale);

  // Brush pigment colored ellipse
  noStroke();
  fill(red, green, blue, alpha*3);
  ellipse(owCX + gap + gap/11, owCY - gap/11, gap/2, gap/2);


  // Display color values according to controller position
  textAlign(CENTER, TOP);
  textSize(owB/15);
  // Color Values
  fill(200);
  text(opacity, owCX + gap + gap/11, owCY - gap/1.1);

  fill(0, 255, 0, 255);
  text(grn, owCX + gap + gap/11, owCY + gap/3);

  fill(0, 200, 255, 255);
  text(blu, owCX + gap/5, owCY - gap/3);

  fill(255, 0, 0, 255);
  text(rd, owCX + (2*gap), owCY - gap/3);

  // Position Values
  fill(180);
  text(x_mn, iwCX - gap/2, owCY + gap/2);
  text(y_mn, iwCX + gap/2, owCY + gap/2);

}