class Boid {

  PVector pos = new PVector(); 
  PVector velocity = new PVector();

  public Boid(int speed) {
    this.pos = new PVector(random(-400, 400), random(-400, 400));
    this.velocity = PVector.random2D().mult(speed);
  }

  private void alignment(ArrayList<Boid> boids) {
    PVector desiredVelocity = calculateAverageVelocity(boids);
    PVector force = desiredVelocity.sub(this.velocity);
    this.velocity.add(force.mult(0.05));
  }

  private void cohesion(ArrayList<Boid> boids) {
    PVector desiredPosition = calculateDesiredPosition(boids);
    PVector force = desiredPosition.sub(this.pos);
    this.velocity.add(force.mult(0.0001));
  }

  public void update() {

    ArrayList<Boid> boidsInRange = findBoidsInRange(this);
    this.alignment(boidsInRange);
    this.cohesion(boidsInRange);

    this.pos.add(this.velocity);

    // check boundaries
    if (this.pos.x > width/2 || this.pos.x < -width/2) 
      this.pos.x *= -1;
    if (this.pos.y > height/2 || this.pos.y < -height/2) 
      this.pos.y *= -1;
  }

  public void show() {
    pushMatrix();

    strokeWeight(2);
    translate(this.pos.x, this.pos.y);
    rotate(this.velocity.heading() + radians(90));

    // draw range of sight
    noStroke();
    fill(80, 80, 250, 70);
    circle(0, 0, sightRange);

    // draw boid
    stroke(0);
    fill(255, 255, 255);
    triangle(0, -15, -5, 5, 5, 5);

    // draw center of boid
    stroke(255, 0, 0);
    point(0, 0);

    popMatrix();
  }


  public PVector calculateAverageVelocity(ArrayList<Boid> boids) {
    PVector averageVelocity = new PVector(0, 0);

    for (Boid b : boids) {
      averageVelocity.add(b.velocity);
    }
    if (boids.size() > 0) 
      averageVelocity = averageVelocity.div(boids.size());

    return averageVelocity;
  }

  public PVector calculateDesiredPosition(ArrayList<Boid> boids) {
    PVector averagePosition = new PVector(0, 0);

    for (Boid b : boids) {
      averagePosition.add(b.pos);
    }
    if (boids.size() > 0) 
      averagePosition = averagePosition.div(boids.size());

    return averagePosition;
  }
}
