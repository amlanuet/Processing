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

    PVector gravity = new PVector(0, 0.1);
    gravity.mult(mover.mass);
    mover.applyForce(gravity);

    if (mousePressed) {
      PVector drag = mover.velocity.get();
      float speed = mover.velocity.mag();
      drag.normalize();
      float c = -0.01;
      drag.mult(c*speed*speed);
      mover.applyForce(drag);
    }

    mover.update();
    mover.checkEdges();
    mover.display();
  }
}
