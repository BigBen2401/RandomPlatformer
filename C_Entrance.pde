// The entrances between levels.
class Entrance extends MasterGeometry {

  // What level the entrance goes to.
  int level;
  Entrance(float x, float y, float w, float h, int _level) {
    super(x, y, w, h);
    level = _level;
  }

  // Go through the entrance.
  void run() {
    if (touch(gameFile.player)!=-1&&keys.get(KEY_INTERACT)) {
      playSound(FXwarp);
      gameFile.preLev = gameFile.curLev;
      gameFile.curLev = level;
      frameCount = -15;
    }
  }

  void display() {
    try {
      pg.image(getIMG(), pos.x, pos.y, size.x, size.y);
    } 
    catch (NullPointerException e) {
      pg.fill(#7f3f00);
      pg.rect(pos.x, pos.y, size.x, size.y);
    }
  }

  PImage getIMG() {
    return IMGtile[gameFile.tileSet][3];
  }
}
