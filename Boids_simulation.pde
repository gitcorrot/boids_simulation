/* BOIDS SIMULATION */

Boid b;

final int sightRange = 150;
final int speed = 3;
final int populationSize = 10;
Boid[] flock;

void setup() {
  size(800, 800);

  // instantiate flock
  flock = new Boid[populationSize];
  for (int i = 0; i < populationSize; i++) {
    flock[i] = new Boid(speed);
  }
}

void draw() {
  background(255);
  translate(width/2, height/2);
  rectMode(CENTER);
  for (int i = 0; i < populationSize; i++) {
    flock[i].update();
    flock[i].show();
  }
}
