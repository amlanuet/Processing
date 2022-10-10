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


void setup() {
  fullScreen();
  surface.setAlwaysOnTop(false);
  btn1 = new Button( width/2-150, height/2, 100, 100, "ASCII", this);
  btn2 = new Button( width/2+50, height/2, 100, 100, "Kinect Physics", this);
  btnclose = new Button(10, 10, 100, 100, "EXIT", this);
}

void draw() {
  background(0);
  btn1.buttonDisplay();
  btn2.buttonDisplay();
  btnclose.buttonDisplay();
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
