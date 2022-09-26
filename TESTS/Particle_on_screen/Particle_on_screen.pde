Mover[] movers;

void setup() {
  size(640, 360);
  movers = new Mover[5];
  for (int i = 0; i < movers.length; i++) {
    movers[i] = new Mover();
  }
}
void mousePressed() {
  for (Mover mover : movers) {
    PVector wind = new PVector(0.2, 0);
    mover.applyForce(wind);
  }
}

void draw() {
  background(255);

  for (Mover mover : movers) {

    PVector gravity = new PVector(0, 0.2);
    gravity.mult(mover.mass);
    mover.applyForce(gravity);



    mover.update();
    mover.checkEdges();
    mover.display();
  }
}
