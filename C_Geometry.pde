class PlatformNormal extends MasterGeometry {
  PlatformNormal(float x, float y, float w, float h) {
    super(x, y, w, h);
    img = normal;
  }
  void run() {
    checkColP(gf.player);
    checkColE(gf.entity);
  }
  protected void floorColP(Player p) {
    if (p.vel.y >= 0) {
      p.vel.y = 0;
      p.pos.y = pos.y-p.size.y;
      p.ground = true;
      p.attack = false;
    }
  }
  protected void ceilColP(Player p) {
    p.vel.y = 0;
    p.pos.y = pos.y+size.y;
  }
  protected void rwallColE(MasterEntity o) {
    o.vel.x = -o.vel.x;
    o.pos.x = pos.x+size.x;
  }
  protected void rwallColP(Player p) {
    p.vel.x = 0;
    p.pos.x = pos.x+size.x;
    if (gf.power[2] && keys.get(KEY_UP) && p.vel.y > 0) {
      p.vel.x = SPEED_MAX;
      p.vel.y = gf.power[0]?JUMP_HI:JUMP_NOR;
      p.ground = false;
    }
  }
  protected void lwallColE(MasterEntity o) {
    o.vel.x = -o.vel.x;
    o.pos.x = pos.x-o.size.x;
  }
  protected void lwallColP(Player p) {
    p.vel.x = 0;
    p.pos.x = pos.x-p.size.x;
    if (gf.power[2] && keys.get(KEY_UP) && p.vel.y > 0) {
      p.vel.x = -SPEED_MAX;
      p.vel.y = gf.power[0]?JUMP_HI:JUMP_NOR;
      p.ground = false;
    }
  }
  protected void floorColE(MasterEntity o) {
    if (o.vel.y >= 0) {
      o.vel.y = 0;
      o.pos.y = pos.y-o.size.y;
      o.ground = true;
      o.attack = false;
    }
  }
  protected void ceilColE(MasterEntity o) {
    o.vel.y = 0;
    o.pos.y = pos.y+size.y;
  }
}

class PlatformDestroy extends PlatformNormal {
  PlatformDestroy(float x, float y, float w, float h, boolean show) {
    super(x, y, w, h);
    img = show?destroy:normal;
  }
  protected void floorColP(Player p) {
    if (p.attack) {
      playAudio(destroyFX);
      dead = true;
      gf.points += 1;
    } else {
      super.floorColP(p);
    }
  }
}

class Entrance extends MasterGeometry {
  String area;
  Entrance(float x, float y, float w, float h, String _area) {
    super(x, y, w, h);
    area = _area;
    img = entrance;
  }
  void display() {
    if (img == null) {
      pg.fill(255, 127);
      pg.stroke(0);
      pg.rect(pos.x, pos.y, size.x, size.y);
      pg.noStroke();
    } else {
      pg.image(img, pos.x, pos.y, size.x, size.y);
    }
  }
  void run() {
    if (touch(gf.player)!=-1&&keys.get(KEY_INTERACT)) {
      playAudio(warpFX);
      gf.curArea = gf.nexArea;
      gf.nexArea = area;
      frameCount = -LOADTIME; 
      overworld.pause();
    }
  }
}
