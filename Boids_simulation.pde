/* BOIDS SIMULATION */

Boid b;

final int sightRange = 100;
final int speed = 3;
final int populationSize = 50;
Boid[] flock;

void setup() {
  size(1200, 800);

  // instantiate flock
  flock = new Boid[populationSize];
  for (int i = 0; i < populationSize; i++) {
    flock[i] = new Boid(speed);
  }
}

void draw() {
  background(150,180,225, 10);
  translate(width/2, height/2);
  rectMode(CENTER);
  for (int i = 0; i < populationSize; i++) {
    flock[i].update();
    flock[i].show();
  }
}

public ArrayList<Boid> findBoidsInRange(Boid boid) {
  ArrayList<Boid> boidsInRange = new ArrayList<Boid>();

  for (int i = 0; i < populationSize; i++) {
    if (flock[i] != boid && PVector.dist(flock[i].pos, boid.pos) < sightRange) {
      boidsInRange.add(flock[i]);
    }
  }
  return boidsInRange;
}
