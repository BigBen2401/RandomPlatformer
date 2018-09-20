// Basic enemies, with one health.
class EnemyBasic extends MasterEntity {

  EnemyBasic(float x, float y, float w, float h) {
    super(x, y, w, h);
    vel.x = 0.5;
  }

  void run() {
    vel.add(GRAVITY);
    pos.add(vel);
    checkColP(gameFile.player);
  }

  // The player jumps on it.
  void floorColP(Player p) {
    playSound(FXgoomba[0]);
    dead = true;
    gameFile.points += 1;
    p.vel.y = gameFile.powerUse[0]?-9:-7;
    p.pos.y = pos.y-p.size.y;
    p.attack = false;
  }

  // The player gets hit by it.
  void lwallColP(Player p) {
    p.pos.x = pos.x-p.size.x;
    p.vel.x = -5;
    p.vel.y = (gameFile.powerUse[0]?-9:-7)/2;
    --p.hpCur;
    playSound(FXgoomba[1]);
    if (p.hpCur==0) { // The player dies from it.
      playSound(FXdeath);
      BGMcurrent.pause();
      BGMcurrent = null;
      p.dead = true;
      frameCount = -150;
    }
  }
  // The player gets hit by it.
  void rwallColP(Player p) {
    p.pos.x = pos.x+size.x;
    p.vel.x = 5;
    p.vel.y = (gameFile.powerUse[0]?-9:-7)/2;
    --p.hpCur;
    playSound(FXgoomba[1]);
    if (p.hpCur==0) { // The player dies from it.
      playSound(FXdeath);
      BGMcurrent.pause();
      BGMcurrent = null;
      p.dead = true;
      frameCount = -150;
    }
  }

  PImage getIMG() {
    return IMGenemy[floor((frameCount>0?frameCount:0)/10)%2];
  }
}

// Enemies with multiple units of health.
class EnemySquish extends EnemyBasic {

  // With each hit, they shrink.
  float hShrink;

  EnemySquish(float x, float y, float w, float h, int health) {
    super(x, y, w, h);
    hShrink = h*16/health;
  }

  // Only die when they run out of health.
  void floorColP(Player p) {
    playSound(FXgoomba[0]);
    p.pos.y = pos.y-p.size.y;
    size.sub(0, hShrink);
    pos.add(0, hShrink);
    dead = size.y<=1;
    gameFile.points += 1;
    p.vel.y = p.attack?0:gameFile.powerUse[0]?-9:-7;
  }
}
