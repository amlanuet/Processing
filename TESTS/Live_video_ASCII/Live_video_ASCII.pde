import org.openkinect.processing.*;

Kinect2 kinect2;
int size;
String density = "@@@@@@@@@@@@%%%%%%#######********+++++====";

void setup () {
  size(512, 424);
  kinect2 = new Kinect2(this);

  kinect2.initDevice();
}

void draw () {
  background(0);
  PImage img = kinect2.getDepthImage();
  image(img, 0, 0);
  //float size = 0;
  //float n = 0;
  ////image(frog, 0, 0);
  //loadPixels();
  //background(255);
  //frog.loadPixels();

  //size = 5;

  //for (int x = 0; x < frog.width; x++) {
  //  for (int y = 0; y < frog.height; y++) {
  //    int loc = x+y*width;
  //    float r = 255 - red    (frog.pixels[loc]);
  //    float g = 255 - green  (frog.pixels[loc]);
  //    float b = 255 - blue   (frog.pixels[loc]);
  //    float bright = ((0.3 * r) + (0.59 * g) + (0.11 * b));

  //    float len = density.length();
  //    int charIndex = floor(map(bright, 0, 255, len -1, 0));


  //    if ((bright >= 0 && bright < 20)) {
  //      beginShape(LINES);
  //      // do nothing
  //      endShape();
  //    } else if (bright > 20) {
  //      beginShape(LINES);
  //      fill(color(0));
  //      textSize((bright / size) / (size * 0.76));
  //      text(density.charAt(charIndex), x, y);
  //      endShape();
  //    }

  //    y = y + int(size) +1;
  //    n = n+1;
  //  }

  //  x = x + int(size) +1;
  //  n = n+1;
  //}
  //frog.updatePixels();

  //println(n);
}
