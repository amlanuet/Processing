float angle = 90;
void setup() {
  size(900, 900);
}

void draw() {
  background(0);
  translate(width/2,height/2);
  strokeWeight(3);
  for (int i=0; i<280; i+=10){
    float ranR = random(255);
    float ranG = random(255);
    float ranB = random(255);
    stroke(ranR, ranG, ranB);
    pushMatrix();
    rotate(radians(i) * cos(radians(angle)));
    line(200*sin(radians(angle)),0,0,200);
    popMatrix();
  }
  angle++;
}
