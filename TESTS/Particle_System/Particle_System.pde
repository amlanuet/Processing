ParticleSystem ps;
ArrayList<ParticleSystem> systems;

void setup() {
  size(640, 360);
  systems = new ArrayList<ParticleSystem>();
}

void draw() {
  background(255);
  for (ParticleSystem ps : systems) {
    ps.run();
    ps.addParticle();
  }
  fill(0);
  text("click mouse to add particle systems", 10, height-30);
}

void mousePressed() {
  systems.add(new ParticleSystem(1, new PVector(mouseX, mouseY)));
}
