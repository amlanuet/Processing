import java.awt.Frame;
import processing.awt.PSurfaceAWT;
import processing.awt.PSurfaceAWT.SmoothCanvas;
PWindow win;

public void settings() {
  size(690, 700);
  
};

void setup() { 
  win = new PWindow(width-5,0,width,700,"Second Window");
  surface.setLocation(-5, 0);
};

void draw() {
  background(255, 0, 0);
  fill(255);
  rect(10, 10, frameCount, 10);
};

void mousePressed() {
  println("mousePressed in primary window");
};
