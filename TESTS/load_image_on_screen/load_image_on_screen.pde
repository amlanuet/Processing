PImage hog;

void setup() {
  size(1200, 627);
  hog = loadImage("hog.jpg");
}

void draw() {
  background(0);
  tint(0, mouseX, mouseY);
  image(hog,0,0, mouseX, mouseY);
}
