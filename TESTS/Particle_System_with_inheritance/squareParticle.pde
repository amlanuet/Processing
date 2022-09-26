class SquareParticle extends Particle {
  float theta;

  SquareParticle(PVector l) {
    super(l);
    theta = 0.0;
  }
  
  void update(){
    super.update();
    float theta_vel = (velocity.x * velocity.mag()) / 10.0f;
    theta += theta_vel;
  }

  void display() {
    // Render the ellipse just like in a regular particle
    // Then add a rotating line
    pushMatrix();
    translate(position.x, position.y);
    rotate(theta);
    stroke(255, lifespan);
    rect(0, 0, 16, 16);
    line(0, 0, 25, 0);
    popMatrix();
  }
}
