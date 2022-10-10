import KinectPV2.*;

KinectPV2 kinect;
Button closebtn;

String density = "@@@@@@@@%%%%%%########*******++++++++========------";
int [] depthZero;
float size = 5;
float skip = 5;
//BUFFER ARR2Y TO CLEAN DE PIXLES
PImage depthToColorImg;


class ASCIIWindow extends PApplet {
  ASCIIWindow() {
    super();
    PApplet.runSketch(new String[] {this.getClass().getSimpleName()}, this);
  }
  public void settings() {
    size(1920, 1080);
  }

  void setup() {
    closebtn = new Button( width/2-150, height/2, 100, 100, "close" );

    //textFont(font, 128);

    depthZero    = new int[ KinectPV2.WIDTHDepth * KinectPV2.HEIGHTDepth];

    //SET THE ARRAY TO 0s
    for (int i = 0; i < KinectPV2.WIDTHDepth; i+=skip) {
      for (int j = 0; j < KinectPV2.HEIGHTDepth; j+=skip) {
        depthZero[424*i + j] = 0;
      }
    }
    kinect = new KinectPV2(this);
    kinect.enableDepthImg(true);
    kinect.enableColorImg(true);
    kinect.enablePointCloud(true);
    kinect.enableDepthMaskImg(true);
    kinect.enableBodyTrackImg(true);

    kinect.init();
    depthToColorImg = kinect.getPointCloudDepthImage();
    setDefaultClosePolicy(this, false);
  }


  void draw() {
    background(0);

    size = 3;

    float [] mapDCT = kinect.getMapDepthToColor(); // 434176
    //print(mapDCT.length, TAB);

    //println(mapDCT.length, KinectPV2.WIDTHDepth, KinectPV2.HEIGHTDepth);

    int [] depthRaw = kinect.getRawDepthData(); // 434176

    //clean de pixels
    PApplet.arrayCopy(depthZero, depthToColorImg.pixels);

    int count = 0;
    depthToColorImg.loadPixels();
    for (int i = 0; i < KinectPV2.WIDTHDepth; i+=skip) {
      for (int j = 0; j < KinectPV2.HEIGHTDepth; j+=skip) {

        //incoming pixels 512 x 424 with position in 1920 x 1080
        float valX = mapDCT[count * 2 + 0];
        float valY = mapDCT[count * 2 + 1];


        //maps the pixels to 512 x 424, not necessary but looks better
        int valXDepth = (int)((valX/1920.0) * 512.0);
        int valYDepth = (int)((valY/1080.0) * 424.0);

        int  valXColor = (int)(valX);
        int  valYColor = (int)(valY);

        if ( valXDepth >= 0 && valXDepth < 512 && valYDepth >= 0 && valYDepth < 424 &&
          valXColor >= 0 && valXColor < 1920 && valYColor >= 0 && valYColor < 1080) {
          //color colorPixel = colorRaw[valYColor * 1920 + valXColor];
          float col = map(depthRaw[(valYDepth * int(skip)) * 512 + valXDepth], 0, 4500, 255, 0);
          float len = (density.length() - 1);
          int charIndex = floor(map(col, 0, 255, len, 0));
          if ((col >= 0 && col < 5)) {
            beginShape(LINES);
            // do nothing
            endShape();
          } else if ((col > 20 && col < 255)) {
            beginShape(LINES);
            textSize((col / size) / size);
            text(density.charAt(charIndex), valXColor, valYColor * int(skip));
            endShape();
          }
        }
        count+=skip;
      }
    }
    textSize(10);
    text("fps: "+frameRate, 50, 50);
  }

  void mousePressed() {
    println("mousePressed in ASCIIWindow");
  }

  void exit()
  {
    dispose();
    ASCII = null;
  }

  final void setDefaultClosePolicy(PApplet pa, boolean keepOpen) {
    final Object surf = pa.getSurface().getNative();
    final PGraphics canvas = pa.getGraphics();

    if (canvas.isGL()) {
      final com.jogamp.newt.Window w = (com.jogamp.newt.Window) surf;

      for (com.jogamp.newt.event.WindowListener wl : w.getWindowListeners())
        if (wl.toString().startsWith("processing.opengl.PSurfaceJOGL"))
          w.removeWindowListener(wl);

      w.setDefaultCloseOperation(keepOpen?
        com.jogamp.nativewindow.WindowClosingProtocol.WindowClosingMode
        .DO_NOTHING_ON_CLOSE :
        com.jogamp.nativewindow.WindowClosingProtocol.WindowClosingMode
        .DISPOSE_ON_CLOSE);
    } else if (canvas instanceof processing.awt.PGraphicsJava2D) {
      final javax.swing.JFrame f = (javax.swing.JFrame)
        ((processing.awt.PSurfaceAWT.SmoothCanvas) surf).getFrame();

      for (java.awt.event.WindowListener wl : f.getWindowListeners())
        if (wl.toString().startsWith("processing.awt.PSurfaceAWT"))
          f.removeWindowListener(wl);

      f.setDefaultCloseOperation(keepOpen?
        f.DO_NOTHING_ON_CLOSE : f.DISPOSE_ON_CLOSE);
    }
  }
}
