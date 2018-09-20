// The playable character.
class Player extends MasterEntity {

  // Current and maximum health.
  int hpCur = 4, hpMax = 4;

  // Facing direction. (true = right)
  boolean dir = true;

  // A fireball.
  Projectile fire = null;

  Player(float x, float y, float w, float h) {
    super(x, y, w, h);
  }

  void run() {
    // If a fireball exists, run that first.
    if (fire != null) fire.run();
    // Jumping and ground pounding.
    if (keys.get(KEY_UP)^keys.get(KEY_DOWN)) {
      if (keys.get(KEY_UP) && ground && !attack) {
        playSound(FXmario[0]);
        vel.y = gameFile.powerUse[0]?-9:-7;
        ground = false;
      } else if (keys.get(KEY_UP) && !ground && attack) {
        vel.y = 0;
        attack = false;
      } else if (keys.get(KEY_DOWN) && gameFile.powerUse[1] && !ground && !attack) {
        playSound(FXmario[1]);
        vel.y = 10;
        attack = true;
      }
    }
    // Running left or right, or decelerating.
    if (keys.get(KEY_LEFT)^keys.get(KEY_RIGHT)) {
      if (keys.get(KEY_LEFT)) {
        dir = false;
        vel.sub(0.25, 0);
      } else if (keys.get(KEY_RIGHT)) {
        dir = true;
        vel.add(0.25, 0);
      }
    } else {
      if (vel.x > 0.5) {
        vel.sub(0.25, 0);
      } else if (vel.x < -0.5) {
        vel.add(0.25, 0);
      } else {
        vel.mul(0, 1);
      }
    }
    // Add gravity, and constrain the velocity.
    vel.add(GRAVITY);
    vel.conX(-5, 5);
    vel.conY(gameFile.powerUse[0]?-9:-7, 10);
    // Add to position, and constrain it within the screen.
    pos.add(vel);
    if (pos.conX(0, (16*gameFile.screenX-1)*16)) {
      vel.x = 0;
    }
    if (pos.conY(0, (16*gameFile.screenY-1)*16)) {
      vel.y = 0;
    }
    // Assume Mario isn't on the ground, unless a platform says he is.
    ground = false;
    // Shoot a fireball, if possible.
    if (gameFile.powerUse[3] && keys.get(KEY_ATTACK) && fire == null) {
      playSound(FXmario[2]);
      fire = new Projectile(pos.x/16, pos.y/16, 0.5, 0.5);
    }
  }

  void display() {
    super.display();
    if (fire != null) fire.display();
  }

  PImage getIMG() {
    if (ground) {
      if (abs(vel.x)>1) {
        if ((vel.x>0&&!dir)||(vel.x<0&&dir)) {
          return IMGmario[dir?1:0][4]; // Skidding while changing direction.
        } else {
          return IMGmario[dir?1:0][1+floor((frameCount>0?frameCount:0)/4)%3]; // Running, with animation.
        }
      } else {
        return IMGmario[dir?1:0][0]; // Standing still.
      }
    } else {
      if (attack) {
        return IMGmario[dir?1:0][6]; // Ground pounding.
      } else {
        return IMGmario[dir?1:0][5]; // Jumping.
      }
    }
  }
}
