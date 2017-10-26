import gifAnimation.*;

GifMaker gifExport;
int frames = 0;
int totalFrames = 360;
float theta;   

void setup() {
  smooth();
  size(640, 360); //size(640, 360);

  gifExport = new GifMaker(this, "export.gif", 100);
  gifExport.setRepeat(0); // make it an "endless" animation
}

void draw() {
  background(#449CED);
  frameRate(30);
  stroke(#BA4A00);
  strokeWeight(2);
  // Let's pick an angle 0 to 90 degrees based on the mouse position
  //float a = (mouseX / (float) width) * 90f;

  float a = (frames / (float) width) * 90f;

  // Convert it to radians
  theta = radians(a);
  // Start the tree from the bottom of the screen
  translate(width/2, height);
  //start a tree from the centre of the screen
  //translate(width/2, height/2);
  // Draw a line 120 pixels
  line(0, 0, 0, -120);
  // Move to the end of that line
  translate(0, -120);
  // Start the recursive branching!
  branch(120);


  export();
}

void branch(float h) {
  // Each branch will be 2/3rds the size of the previous one
  h *= 0.66;

  // All recursive functions must have an exit condition!!!!
  // Here, ours is when the length of the branch is 2 pixels or less
  if (h > 2) {
    pushMatrix();    // Save the current state of transformation (i.e. where are we now)
    rotate(theta);   // Rotate by theta
    line(0, 0, 0, -h);  // Draw the branch
    translate(0, -h); // Move to the end of the branch
    branch(h);       // Ok, now call myself to draw two new branches!!

    noStroke();
    ellipse(0, 0, 5, 20);
    stroke(#BA4A00);
    popMatrix();     // Whenever we get back here, we "pop" in order to restore the previous matrix state

    // Repeat the same thing, only branch off to the "left" this time!
    pushMatrix();
    rotate(-theta);
    line(0, 0, 0, -h);
    translate(0, -h);
    branch(h);
    noStroke();
    ellipse(0, 0, 20, 5);
    stroke(#BA4A00);
    popMatrix();

    fill(39, 174, 96);
  }
}


void export() {
  if (frames < totalFrames) {
    gifExport.setDelay(20);
    gifExport.addFrame();
    frames++;
  } else {
    gifExport.finish();
    frames++;
    println("gif saved");
    exit();
  }
}
