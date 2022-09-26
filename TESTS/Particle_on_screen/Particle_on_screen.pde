Mover[] movers;

void setup() {
  size(640, 360);
  movers = new Mover[5];
  for (int i = 0; i < movers.length; i++) {
    movers[i] = new Mover();
  }
}

void draw() {
  background(255);

  for (Mover mover : movers) {

    PVector gravity = new PVector(0, 0.3);
    mover.applyForce(gravity);

    PVector wind = new PVector(0.2, 0);
    mover.applyForce(wind);

    mover.update();
    mover.checkEdges();
    mover.display();
  }
}
