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


ASCIIWindow ASCII;
KinectPhysicsWindow KinectPhysics;

Button btn1;
Button btn2;


void setup() {
  PFont font = createFont("Anonymous.ttf", 1);


  size(1920, 1080);
  btn1 = new Button( 10, 10, 100, 100, "ASCII" );
  btn2 = new Button( 120, 10, 100, 100, "Kinect Physics" );
}

void draw() {
  background(255, 0, 0);
  btn1.buttonDisplay();
  btn2.buttonDisplay();
}


void mousePressed() {
  if (btn1.hasClicked()) {
    ASCII = new ASCIIWindow();
  }
  if (btn2.hasClicked()) {
    KinectPhysics = new KinectPhysicsWindow();
  }
}
