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

OpenCV opencv;
// declare SimpleOpenNI object
KinectPV2 kinect;
// declare BlobDetection object
BlobDetection theBlobDetection;
// ToxiclibsSupport for displaying polygons
ToxiclibsSupport gfx;
// declare custom PolygonBlob object (see class for more info)
PolygonBlob poly;

float polygonFactor = 1;

int threshold = 10;

//Distance in cm
int maxD = 3500; //2.5m
int minD = 15; //15cm

boolean    contourBodyIndex = true;

// PImage to hold incoming imagery and smaller one for blob detection
PImage cam, blobs;
// the kinect's dimensions to be used later on for calculations
int kinectWidth = 640;
int kinectHeight = 480;
// to center and rescale from 640x480 to higher custom resolutions
float reScale;

// background and blob color
color bgColor, blobColor;

String[] palettes = {
  "-14587720,-1323658,-908767,-7898215,-1849943,-5525290,-4250242,-8989771, -18520341,-5254852",
  "-67879,-9633503,-8858441,-144382,-4996094,-16604779,-588031",
  "-1978728,-724510,-15131349,-13932461,-4741770,-9232823,-4568234,-3195858,-2850983,-10314372"
};
String[] palettes2 = {
  "-10, -1, -2, -3, -4, -5, -6, -7, -8"
};

String[] palet = palettes2;

color[] colorPalette;

// the main PBox2D object in which all the physics-based stuff is happening
Box2DProcessing box2d;
// list to hold all the custom shapes (circles, polygons)
ArrayList<CustomShape> polygons = new ArrayList<CustomShape>();

boolean ir = false;
boolean colorDepth = false;
boolean mirror = false;

void setup() {
  // it's possible to customize this, for example 1920x1080
  size(1920, 1080, OPENGL);
  opencv = new OpenCV(this, 512, 424);
  kinect = new KinectPV2(this);
  kinect.enableColorImg(true);
  kinect.enableDepthImg(true);
  kinect.enableBodyTrackImg(true);
  kinect.enablePointCloud(true);
  kinect.enableDepthMaskImg(true);
  kinect.init();


  // mirror the image to be more intuitive
  // calculate the reScale value
  // currently it's rescaled to fill the complete width (cuts of top-bottom)
  // it's also possible to fill the complete height (leaves empty sides)
  reScale = (float) width / kinectWidth;
  reScale = 1.5;
  // create a smaller blob image for speed and efficiency
  blobs = createImage(kinectWidth/3, kinectHeight/3, RGB);
  // initialize blob detection object to the blob image dimensions
  theBlobDetection = new BlobDetection(blobs.width, blobs.height);
  theBlobDetection.setThreshold(0.2);
  // initialize ToxiclibsSupport object
  gfx = new ToxiclibsSupport(this);
  // setup box2d, create world, set gravity
  box2d = new Box2DProcessing(this);
  box2d.createWorld();
  box2d.setGravity(0, -20);
  // set random colors (background, blob)
  setRandomColors(1);
}

void draw() {
  background(bgColor);
  //image(kinect.getBodyTrackImage(), 512, 0);
  // put the image into a PImage
  cam = kinect.getBodyTrackImage();
  // copy the image into the smaller blob image
  blobs.copy(cam, 0, 0, cam.width, cam.height, 0, 0, blobs.width, blobs.height);
  // blur the blob image
  blobs.filter(BLUR, 1);
  // detect the blobs
  theBlobDetection.computeBlobs(blobs.pixels);
  // initialize a new polygon
  poly = new PolygonBlob();
  // create the polygon from the blobs (custom functionality, see class)
  poly.createPolygon();
  // create the box2d body from the polygon
  poly.createBody();
  // update and draw everything (see method)
  updateAndDrawBox2D();

  // display the person's polygon
  noStroke();
  fill(blobColor);
  gfx.polygon2D(poly);

  // destroy the person's body (important!)
  poly.destroyBody();
  // set the colors randomly every 240th frame
  setRandomColors(240);


  println("fps: "+frameRate);
  println("threshold: "+threshold);
  println("minD: "+minD);
  println("maxD: "+maxD);
  println(hex(colorPalette[1]));

  kinect.setLowThresholdPC(minD);
  kinect.setHighThresholdPC(maxD);
}

void updateAndDrawBox2D() {
  // if frameRate is sufficient, add a polygon and a circle with a random radius
  if (frameRate > 29) {
    polygons.add(new CustomShape(kinectWidth/2, -50, -1));
    polygons.add(new CustomShape(kinectWidth/2, -50, random(2.5, 20)));
  }
  // take one step in the box2d physics world
  box2d.step();

  // center and reScale from Kinect to custom dimensions
  translate(0, (height-kinectHeight*reScale)/2);
  scale(reScale);

  // display all the shapes (circles, polygons)
  // go backwards to allow removal of shapes
  for (int i=polygons.size()-1; i>=0; i--) {
    CustomShape cs = polygons.get(i);
    // if the shape is off-screen remove it (see class for more info)
    if (cs.done()) {
      polygons.remove(i);
      // otherwise update (keep shape outside person) and display (circle or polygon)
    } else {
      cs.update();
      cs.display();
    }
  }
}

// sets the colors every nth frame
void setRandomColors(int nthFrame) {
  if (frameCount % nthFrame == 0) {
    // turn a palette into a series of strings
    String[] paletteStrings = split(palet[int(random(palet.length))], ",");
    // turn strings into colors
    colorPalette = new color[paletteStrings.length];
    for (int i=0; i<paletteStrings.length; i++) {
      colorPalette[i] = int(paletteStrings[i]);
    }
    // set background color to first color from palette
    bgColor = colorPalette[0];
    // set blob color to second color from palette
    blobColor = colorPalette[1];
    // set all shape colors randomly
    for (CustomShape cs : polygons) {
      cs.col = getRandomColor();
    }
  }
}

// returns a random color from the palette (excluding first aka background color)
color getRandomColor() {
  return colorPalette[int(random(1, colorPalette.length))];
}

void keyPressed() {
  //change contour finder from contour body to depth-PC
  if ( key == 'b') {
    contourBodyIndex = !contourBodyIndex;
    if (contourBodyIndex)
      threshold = 200;
    else
      threshold = 40;
  }

  if (key == 'a') {
    threshold+=10;
  }
  if (key == 's') {
    threshold-=10;
  }
  if (key == 'k') {
    if (palet == palettes2) {
      palet = palettes;
    } else if (palet == palettes) {
      palet = palettes2;
    } else {
      println("ERROR: Palettes could not be changed");
    }
    setRandomColors(1);
  }
  if (key == '1') {
    minD += 10;
  }

  if (key == '2') {
    minD -= 10;
  }

  if (key == '3') {
    maxD += 10;
  }

  if (key == '4') {
    maxD -= 10;
  }

  if (key == '5')
    polygonFactor += 0.1;

  if (key == '6')
    polygonFactor -= 0.1;
}
