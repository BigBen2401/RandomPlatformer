boolean konami = false;
int scrollX = 0, scrollY = 0, abscrollX = 0, abscrollY = 0;
String level = "Tower";
final PVector GRAV = new PVector(0, 0.5);
Player player = new Player(300, 1085);
ArrayList<Platform> platform = new ArrayList<Platform>();
void setup() {
  size(600, 600, FX2D);
  if (keys.size() == 0) {
    noStroke();
    rectMode(CENTER);
    initKeys();
  }
  loadPlatforms(level);
}
void draw() {
  println(frameRate);
  if (frameCount < 30) {
    keys.put('w', false);
    keys.put('a', false);
    keys.put('s', false);
    keys.put('d', false);
  }
  background(color(75, 225, 225));
  pushMatrix();
  translate(constrain(300-player.pos.x, -600*(abscrollX-1), 0), constrain(300-player.pos.y, -600*(abscrollY-1), 0));
  player.move(null);
  for (Platform geo : platform) {
    geo.run(player, geo.type==2?color(0):geo.des?color(150, 225, 150):color(75, 225, 75));
  }
  player.display(color(225, 75, 225));
  popMatrix();
  if (frameCount < 30) {
    if (frameCount < -30) {
      fill(0, map(frameCount, -60, -30, 0, 255));
      rect(300, 300, 620, 620);
    } else if (frameCount < 1) {
      background(0);
      fill(75);
      ellipse(300, 300, 200, 200);
      fill(225);
      arc(300, 300, 200, 200, -HALF_PI, map(frameCount, -30, -1, -HALF_PI, TAU-HALF_PI));
    } else {
      fill(0, map(frameCount, 0, 30, 255, 0));
      rect(300, 300, 620, 620);
    }
  }
}