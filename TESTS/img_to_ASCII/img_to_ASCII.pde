PImage frog;
int size;
boolean onOff;
String density = "@@@@@@@@@@@@%%%%%%%%#########********+++++++++====";

void setup () {
  size(612, 408);
  frog = loadImage("frog.jpg");
  background(0);
}

void draw () {
  float size = 0;
  float n = 0;
  //image(frog, 0, 0);
  loadPixels();
  background(0);
  frog.loadPixels();

  size = 5;

  for (int x = 0; x < frog.width; x++) {
    for (int y = 0; y < frog.height; y++) {
      int loc = x+y*width;
      float r = 255 - red    (frog.pixels[loc]);
      float g = 255 - green  (frog.pixels[loc]);
      float b = 255 - blue   (frog.pixels[loc]);
      float bright = ((0.3 * r) + (0.59 * g) + (0.11 * b));

      float len = density.length();
      int charIndex = floor(map(bright, 0, 255, 0, len));


      if ((bright >= 0 && bright < 20)) {
        beginShape(LINES);
        // do nothing
        endShape();
      } else if (bright > 20) {
        beginShape(LINES);
        textSize((bright / size) / size);
        text("e", x, y);
        endShape();
      }
      
      if ((bright >= 0 && bright < 20)) {
        beginShape(LINES);
        // do nothing
        endShape();
      } else if ((bright > 20 && bright < 85)) {
        beginShape(LINES);
        textSize((bright / size) / size);
        text("e", x, y);
        endShape();
      } else if ((bright > 85 && bright < 170)) {
        beginShape(LINES);
        textSize((bright / size) / size);
        text("e", x, y);
        endShape();
      } else if ((bright > 170 && bright < 255)) {
        beginShape(LINES);
        textSize((bright / size) / size);
        text("e", x, y);
        endShape();
      }

      y = y + int(size) +1;
      n = n+1;
    }

    x = x + int(size) +1;
    n = n+1;
  }
  frog.updatePixels();

  if (onOff) {
    endRecord();
    onOff = false;
  }
  println(n);
}

void mousePressed() {
  onOff = true;
}
