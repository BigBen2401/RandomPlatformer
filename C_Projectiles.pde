// A fireball (in the full game, this would be a generic projectile).
class Projectile extends MasterEntity {

  Projectile(float x, float y, float w, float h) {
    super(x+0.25, y+0.25, w, h);
    // Give the fireball some of Mario's momentum.
    vel = new Vector(gameFile.player.vel.x+(gameFile.player.dir?5:-5), 5);
  }

  PImage getIMG() {
    return IMGfire[gameFile.player.dir?1:0];
  }

  void run() {
    // Decrease the speed to a minimum.
    if (vel.x > 5) {
      vel.sub(0.25, 0);
    } else if (vel.x < -5) {
      vel.add(0.25, 0);
    }
    // Add gravity, and constrain the velocity.
    vel.add(GRAVITY);
    //vel.conY(0, 0); This would be used for a potential bow & arrow projectile.
    vel.conY(-2, 5);
    // Add to position, and either constrain or remove the fireball (as appropriate).
    pos.add(vel);
    if (pos.conX(0, (16*gameFile.screenX-1)*16+8)) {
      gameFile.player.fire = null;
    }
    if (pos.conY(0, (16*gameFile.screenY-1)*16+8)) {
      vel.y = 0;
    }
    checkCol();
  }
  // Because attacking with the fireball is different to jumping,
  // I have to create new code to handle this type of attack.
  void checkCol() {
    for (MasterEntity o : gameFile.entity) {
      if (o instanceof EnemySquish) {
        EnemySquish e = (EnemySquish)o;
        switch (e.touch(this)) {
        case -1:
          break;
        case 1:
        case 2:
        case 3:
        case 4:
          playSound(FXgoomba[0]);
          e.size.sub(0, e.hShrink);
          e.pos.add(0, e.hShrink);
          e.dead = e.size.y<=0;
          gameFile.points += 1;
          gameFile.player.fire = null;
          break;
        }
      } else if (o instanceof EnemyBasic) {
        switch (o.touch(this)) {
        case -1:
          break;
        case 1:
        case 2:
        case 3:
        case 4:
          playSound(FXgoomba[0]);
          o.dead = true;
          gameFile.points += 1;
          gameFile.player.fire = null;
          break;
        }
      }
    }
    for (MasterGeometry o : gameFile.geometry) {
      if (o instanceof PlatformDestroy) {
        switch (o.touch(this)) {
        case -1:
          break;
        case 1:
        case 2:
        case 3:
        case 4:
          playSound(FXbreak);
          o.dead = true;
          gameFile.points += 1;
          gameFile.player.fire = null;
          break;
        }
      } else if (!(o instanceof Entrance)) {
        switch (o.touch(this)) {
        case -1:
          break;
        case 1:
          pos.y = o.pos.y-size.y;
          vel.y = -2;
          break;
        case 2:
          vel.y = 0;
          break;
        case 3:
        case 4:
          gameFile.player.fire = null;
          break;
        }
      }
    }
  }
}
