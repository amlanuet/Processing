import controlP5.*;
import KinectPV2.*;
import blobDetection.*;


KinectPV2 kinect;

ControlP5 cp5;

PImage img;
PImage imgc;

BlobDetection theBlobDetection;

float xpos = 0;
float ypos = 0;
int maxD = 4000; // 4m
int minD = 100;  //  0m


PGraphics pg;

boolean blob = true;

IntList ptrack;


void setup() {
  size(1024, 648);
  
  pg = createGraphics(512, 424);
  
  kinect = new KinectPV2(this);
  kinect.enableDepthImg(true);
  kinect.enablePointCloud(true);
  kinect.enableColorImg(true);
  
  kinect.init();
  
  cp5 = new ControlP5(this);
  
  cp5.addSlider("maxD")
    .setPosition(50,500)
    .setRange(0,4000)
    .setSize(200,20)
    .setValue(3000)
    .setColorForeground(color(20,200,200))
     .setColorLabel(color(255))
     .setColorBackground(color(70,70,70))
     .setColorValue(color(0,0,0))
     .setColorActive(color(0,255,255))
  ;
  
  cp5.addSlider("barea")
    .setPosition(50,540)
    .setRange(0,500)
    .setSize(200,20)
    .setValue(100)
    .setColorForeground(color(20,200,200))
     .setColorLabel(color(255))
     .setColorBackground(color(70,70,70))
     .setColorValue(color(0,0,0))
     .setColorActive(color(0,255,255))
  ;
  
  cp5.addToggle("blob")
     .setPosition(50,580)
     .setSize(20,20)
     .setColorForeground(color(20,20,20))
     .setColorLabel(color(255))
     .setColorBackground(color(70,70,70))
     .setColorValue(0xffff88ff)
     .setColorActive(color(0,200,200))
     ;
  
  img = new PImage(512,424); 
  
  theBlobDetection = new BlobDetection(img.width, img.height);
  theBlobDetection.setPosDiscrimination(true);
  theBlobDetection.setThreshold(0.1f); 
}

void draw() {
  background(0);
  
  ptrack = new IntList();
  
  kinect.setLowThresholdPC(minD);
  kinect.setHighThresholdPC(maxD);
  
  img = kinect.getPointCloudDepthImage();
  //img.filter(INVERT);
  
  pg.beginDraw();
  pg.background(0);
  pg.image(img,0,0);
  pg.endDraw();
  
  image(pg,512,0);

  theBlobDetection.computeBlobs(pg.pixels);
  drawBlobsAndEdges(true,blob);

  stroke(255);
  text(frameRate, width-150, height - 50);

}


// ==================================================
// drawBlobsAndEdges()
// ==================================================
void drawBlobsAndEdges(boolean drawBlobs, boolean drawEdges)
{
    float barea = cp5.getController("barea").getValue();
  float maxD = cp5.getController("maxD").getValue();
  boolean blob = cp5.getController("blob").isActive();
  noFill();
  Blob b;
  EdgeVertex eA,eB;
  xpos = 0;
  ypos = 0;
  int c = 0;
  for (int n=0 ; n<theBlobDetection.getBlobNb() ; n++)
  {
    b=theBlobDetection.getBlob(n);
    if (b!=null)
    {
      // Edges
      if (drawEdges)
      {
        strokeWeight(1);
        stroke(0,255,255);
        for (int m=0;m<b.getEdgeNb();m++)
        {
          eA = b.getEdgeVertexA(m);
          eB = b.getEdgeVertexB(m);
          if (eA !=null && eB !=null)
            line(
              eA.x*img.width, eA.y*img.height, 
              eB.x*img.width, eB.y*img.height
              );
        }
      }

      // Blobs
      if (drawBlobs)
      {
        if(b.w*img.width > barea && b.h*img.height > barea  ){
            strokeWeight(1);
            stroke(255,0,0);
        
            rect(b.xMin*img.width,b.yMin*img.height,b.w*img.width,b.h*img.height);
            fill(255);
            float cx = ((b.xMin*img.width) + b.w*img.width/2);
            float cy = ((b.yMin*img.height)+b.h*img.height/2);
            noStroke();
            ellipse(cx,cy,10,10);
            c++;
            ptrack.append(int(cx));
            ptrack.append(int(cy));
            if(dist(cx,cy,img.width/2,img.height/2) < dist(xpos,ypos,img.width/2,img.height/2)){
              xpos = cx;
              ypos = cy;
            }
            noFill();
          }
      }

    }

      }
      ptrack.append(c);
}
