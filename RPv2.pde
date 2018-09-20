int SCALE = 32;
PGraphics pg;

final int LOADTIME = 15;

boolean moonJump = false;
boolean hand = false;

void settings() {
  size(16*SCALE, 16*SCALE);
  noSmooth();
}

void setup() {
  if (keys.size() == 0) {
    frameRate(60);
    surface.setResizable(true);
    pg = createGraphics(256, 256);
    setKeys();
    loadAudio();
    loadImages();
    state = new Title();
  } else {
    if (!(state instanceof Game)) {
      state = new Game();
      gf = new GameFile();
      if (fileLoad) {
        gf.fileLoad();
        fileLoad = false;
      }
    }
    gf.loadArea();
  }
}

Vector mouse = new Vector(0, 0);
boolean pmousePressed = false;
void draw() {
  hand = false;
  mouse.x = int(map(mouseX, 0, width, 0, 256));
  mouse.y = int(map(mouseY, 0, height, 0, 256));
  pg.beginDraw();
  state.run();
  pg.endDraw();
  image(pg, 0, 0, width, height);
  pmousePressed = mousePressed;
  cursor(cursor[hand?1:0],0,0);
}

void exit() {
  if (state instanceof Game || state instanceof Pause) {
    gf.fileSave();
  }
  super.exit();
}
