// Regular platforms.
class PlatformNormal extends MasterGeometry {
  PlatformNormal(float x, float y, float w, float h) {
    super(x, y, w, h);
  }

  void run() {
    checkColP(gameFile.player);
    checkColE(gameFile.entity);
  }

  // Act as a floor.
  void floorColP(Player p) {
    if (p.vel.y >= 0) {
      p.vel.y = 0;
      p.pos.y = pos.y-p.size.y;
      p.ground = true;
      p.attack = false;
    }
  }

  // Act as a ceiling.
  void ceilColP(Player p) {
    p.vel.y = 0;
    p.pos.y = pos.y+size.y;
  }

  // Act as a wall.
  void rwallColP(Player p) {
    p.vel.x = 0;
    p.pos.x = pos.x+size.x;
    if (gameFile.powerUse[2] && keys.get(KEY_UP) && p.vel.y > 0) { // Wall Jump.
      playSound(FXmario[0]);
      p.vel.x = 5;
      p.vel.y = gameFile.powerUse[0]?-9:-7;
      p.ground = false;
    }
  }
  void lwallColP(Player p) {
    p.vel.x = 0;
    p.pos.x = pos.x-p.size.x;
    if (gameFile.powerUse[2] && keys.get(KEY_UP) && p.vel.y > 0) { // Wall Jump.
      playSound(FXmario[0]);
      p.vel.x = -5;
      p.vel.y = gameFile.powerUse[0]?-9:-7;
      p.ground = false;
    }
  }

  // Stop enemies from going out of bounds.
  void floorColE(MasterEntity o) {
    if (o.vel.y >= 0) {
      o.vel.y = 0;
      o.pos.y = pos.y-o.size.y;
      o.ground = true;
    }
  }
  void ceilColE(MasterEntity o) {
    o.vel.y = 0;
    o.pos.y = pos.y+size.y;
  }
  void rwallColE(MasterEntity o) {
    o.vel.x = -o.vel.x;
    o.pos.x = pos.x+size.x;
  }
  void lwallColE(MasterEntity o) {
    o.vel.x = -o.vel.x;
    o.pos.x = pos.x-o.size.x;
  }

  PImage getIMG() {
    return IMGtile[gameFile.tileSet][1];
  }
}

// Platforms that can be destroyed.
class PlatformDestroy extends PlatformNormal {

  PlatformDestroy(float x, float y, float w, float h) {
    super(x, y, w, h);
  }

  // If the player is ground pounding, destroy this platform.
  void floorColP(Player p) {
    if (p.attack) {
      playSound(FXbreak);
      dead = true;
      gameFile.points += 1;
    } else {
      super.floorColP(p);
    }
  }

  PImage getIMG() {
    return IMGtile[gameFile.tileSet][2];
  }
}
