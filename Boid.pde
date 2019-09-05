class Boid {

  PVector pos = new PVector(); 
  PVector velocity = new PVector();
  private float maxSpeed;

  public Boid(int speed) {
    this.maxSpeed = speed;
    this.pos = new PVector(random(-width/2, width/2), random(-height/2, height/2));
    this.velocity = PVector.random2D().mult(this.maxSpeed);
  }

  private void separation(ArrayList<Boid> boids) {
    PVector crowdAvoidingForce = calculateCrowdAvoidingForce(boids);
    this.velocity.add(crowdAvoidingForce.mult(0.1));
  }

  private void alignment(ArrayList<Boid> boids) {
    PVector desiredVelocity = calculateAverageVelocity(boids);
    if (desiredVelocity != null) {
      PVector force = desiredVelocity.sub(this.velocity);
      this.velocity.add(force.mult(0.01));
    }
  }

  private void cohesion(ArrayList<Boid> boids) {
    PVector desiredPosition = calculateDesiredPosition(boids);
    if (desiredPosition != null) {
      PVector force = desiredPosition.sub(this.velocity);
      this.velocity.add(force.mult(0.0001));
    }
  }

  public void update() {

    //if(this.velocity.mag() < 0.1) this.velocity.setMag(random(1,2));

    ArrayList<Boid> boidsInRange = findBoidsInRange(this);
    this.separation(boidsInRange);
    this.alignment(boidsInRange);
    this.cohesion(boidsInRange);

    this.velocity.limit(3);
    this.pos.add(this.velocity);

    // check boundaries
    if (this.pos.x > width/2) this.pos.x = (-width/2) + 10;
    else if (this.pos.x < -width/2) this.pos.x = (width/2) - 10;
    else if (this.pos.y > height/2) this.pos.y = (-height/2) + 10;
    else if (this.pos.y < -height/2) this.pos.y = (height/2) - 10;
  }

  public void show() {
    pushMatrix();

    strokeWeight(1);
    translate(this.pos.x, this.pos.y);
    rotate(this.velocity.heading() + radians(90));

    // draw range of sight
    //noStroke();
    //fill(80, 80, 250, 10);
    //circle(0, 0, sightRange);

    // draw boid
    stroke(0);
    fill(255, 255, 255);
    triangle(0, -15, -5, 5, 5, 5);

    popMatrix();
  }

  public PVector calculateCrowdAvoidingForce(ArrayList<Boid> boids) {
    PVector crowdAvoidingForce = new PVector();
    int crowdCount = 0;

    for (Boid b : boids) {
      float distance = PVector.dist(this.pos, b.pos);
      if (distance < sightRange/2) {
        crowdAvoidingForce.add((PVector.sub(this.pos, b.pos)).mult(1/distance));
        crowdCount++;
      }
    }
    if (crowdCount > 0) 
      crowdAvoidingForce = crowdAvoidingForce.div(crowdCount);

    crowdAvoidingForce.setMag(this.maxSpeed);
    return crowdAvoidingForce;
  }

  public PVector calculateAverageVelocity(ArrayList<Boid> boids) {
    PVector averageVelocity = new PVector();

    for (Boid b : boids) {
      averageVelocity.add(b.velocity);
    }

    if (boids.size() > 0) {
      averageVelocity = averageVelocity.div(boids.size());
      averageVelocity.setMag(this.maxSpeed);

      return averageVelocity;
    } else {
      return null;
    }
  }

  public PVector calculateDesiredPosition(ArrayList<Boid> boids) {
    PVector averagePosition = new PVector();

    for (Boid b : boids) {
      averagePosition.add(b.pos);
    }
    if (boids.size() > 0) {
      averagePosition = averagePosition.div(boids.size());
      averagePosition.setMag(this.maxSpeed);

      return averagePosition;
    } else {
      return null;
    }
  }
}
