class Boid {

  PVector pos = new PVector(); 
  PVector velocity = new PVector();

  public Boid(int speed) {
    this.velocity = PVector.random2D().mult(speed);
  }

  public void update() {
    this.pos.add(this.velocity);

    // check boundaries
    if (this.pos.x > width/2 || this.pos.x < -width/2) 
      this.pos.x *= -1;
    if (this.pos.y > height/2 || this.pos.y < -height/2) 
      this.pos.y *= -1;
  }

  public void show() {
    pushMatrix();

    strokeWeight(4);
    translate(this.pos.x, this.pos.y);
    rotate(this.velocity.heading() + radians(90));

    // draw range of sight
    noStroke();
    fill(80, 80, 250, 70);
    circle(0, 0, sightRange);

    // draw boid
    stroke(0);
    fill(255, 255, 255);
    triangle(0, -30, -10, 10, 10, 10);

    // draw center of boid
    stroke(255, 0, 0);
    point(0, 0);

    popMatrix();
  }
}
