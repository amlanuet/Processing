class ParticleSystem {
  ArrayList<Particle> particles;
  PVector origin;

  ParticleSystem(int num, PVector v) {
    particles = new ArrayList<Particle>();
    origin = v.get();
    for (int i = 0; i < num; i++) {
      particles.add(new Particle(origin));
    }
  }

  void addParticle() {
    particles.add(new SquareParticle(origin));
  }

  void run() {
    for (int i = particles.size()-1; i >= 0; i--) {
      Particle p = particles.get(i);
      p.run();
      if (p.isDead()) {
        particles.remove(i);
      }
    }
  }
}
