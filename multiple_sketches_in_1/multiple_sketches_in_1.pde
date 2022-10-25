import KinectPV2.*;
import gab.opencv.*;
import com.sun.jna.Library;
import com.sun.jna.Native;
import com.sun.jna.Platform;
// import libraries
import processing.opengl.*; // opengl
import org.openkinect.freenect.*;
import org.openkinect.processing.*;
import blobDetection.*; // blobs
import toxi.geom.*; // toxiclibs shapes and vectors
import toxi.processing.*; // toxiclibs display
import shiffman.box2d.*; // shiffman's jbox2d helper library
import org.jbox2d.collision.shapes.*; // jbox2d
import org.jbox2d.common.*; // jbox2d
import org.jbox2d.dynamics.*; // jbox2d
import java.util.Collections;
import java.awt.*;

java.awt.Frame frame;
java.awt.Canvas canvas;

ASCIIWindow ASCII;
KinectPhysicsWindow KinectPhysics;

Button btn1;
Button btn2;
Button btnclose;
PImage p0, p1, p2, p3;

void setup() {
  fullScreen();
  surface.setAlwaysOnTop(false);
  btn1 = new Button( (width/2)-160, height/2, 164, 70, "ASCII", this);
  btn2 = new Button( (width/2)+10, height/2, 196, 70, "Kinect Physics", this);
  btnclose = new Button(10, 10, 146, 70, "EXIT", this);
  p0 = loadImage("data/button_ascii.png");
  p1 = loadImage("data/button_dashboard.png");
  p2 = loadImage("data/button_exit.png");
  p3 = loadImage("data/button_physics.png");
}

void draw() {
  background(0);
  //btn1.buttonDisplay();
  image(p0, (width/2)-160, height/2);
  //btn2.buttonDisplay();
  image(p3, (width/2)+10, height/2);
  //btnclose.buttonDisplay();
  image(p2, 10, 10);
}


void mousePressed() {
  if (btn1.hasClicked()) {
    ASCII = new ASCIIWindow();
  }
  if (btn2.hasClicked()) {
    KinectPhysics = new KinectPhysicsWindow();
  }
  if (btnclose.hasClicked()) {
    exit();
  }
}
