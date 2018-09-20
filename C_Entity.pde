class Player extends MasterEntity {
  int hpcur = 4, hpmax = 4;
  boolean dir = true;
  Projectile fire = null;
  Player(float x, float y, float w, float h) {
    super(x, y, w, h);
    img = play[
      ground?
      abs(vel.x)>1?
      (vel.x>0&&!dir)||(vel.x<0&&dir)?
      5
      :2+floor((frameCount>0?frameCount:0)/4)%3
      :0
      :attack?6:1
      ][dir?1:0];
  }
  void run() {
    if (fire != null) fire.run();
    if (keys.get(KEY_UP)^keys.get(KEY_DOWN)) {
      if (keys.get(KEY_UP) && (ground||moonJump) && !attack) {
        playAudio(jumpFX);
        vel.y = gf.power[0]?JUMP_HI:JUMP_NOR;
        ground = false;
      } else if (keys.get(KEY_UP) && !ground && attack) {
        vel.y = 0;
        attack = false;
      } else if (keys.get(KEY_DOWN) && gf.power[1] && !ground && !attack) {
        vel.y = FALL;
        attack = true;
      }
    }
    if (keys.get(KEY_LEFT)^keys.get(KEY_RIGHT)) {
      if (keys.get(KEY_LEFT)) {
        dir = false;
        vel.sub(ACCEL, 0);
      } else if (keys.get(KEY_RIGHT)) {
        dir = true;
        vel.add(ACCEL, 0);
      }
    } else {
      if (vel.x > 0.5) {
        vel.sub(ACCEL, 0);
      } else if (vel.x < -0.5) {
        vel.add(ACCEL, 0);
      } else {
        vel.mul(0, 1);
      }
    }
    vel.add(GRAVITY);
    vel.conX(-SPEED_MAX, SPEED_MAX);
    vel.conY(gf.power[0]?JUMP_HI:JUMP_NOR, FALL);
    pos.add(vel);
    if (screenX<0) {
      pos.add(size.x/2, 0);
      pos.modX(16*16*abscreenX);
      pos.sub(size.x/2, 0);
    } else {
      if (pos.conX(0, (16*abscreenX-1)*16)) {
        vel.x = 0;
      }
    }
    if (screenY<0) {
      pos.modY(16*16*abscreenY);
    } else {
      if (pos.conY(0, (16*abscreenY-1)*16)) {
        vel.y = 0;
      }
    }
    img = play[
      ground?
      abs(vel.x)>1?
      (vel.x>0&&!dir)||(vel.x<0&&dir)?
      5
      :2+floor((frameCount>0?frameCount:0)/4)%3
      :0
      :attack?6:1
      ][dir?1:0];
    ground = false;
    if (gf.power[3] && keys.get(KEY_ATTACK) && fire == null) {
      playAudio(fireFX);
      fire = new Projectile(pos.x/16, pos.y/16, 0.5, 0.5);
    }
  }
  void display() {
    super.display();
    if (fire != null) fire.display();
  }
}

class EnemyBasic extends MasterEntity {
  EnemyBasic(float x, float y, float w, float h) {
    super(x, y, w, h);
    vel.x = 0.5;
    img = basic[floor((frameCount>0?frameCount:0)/10)%2];
  }
  void run() {
    vel.add(GRAVITY);
    pos.add(vel);
    img = basic[floor((frameCount>0?frameCount:0)/10)%2];
    checkColP(gf.player);
  }
  protected void floorColP(Player p) {
    playAudio(killFX);
    dead = true;
    gf.points += 1;
    p.vel.y = gf.power[0]?JUMP_HI:JUMP_NOR;
    p.pos.y = pos.y-p.size.y;
  }
  protected void lwallColP(Player p) {
    p.pos.x = pos.x-p.size.x;
    p.vel.x = -SPEED_MAX;
    p.vel.y = (gf.power[0]?JUMP_HI:JUMP_NOR)/2;
    --p.hpcur;
    playAudio(hitFX);
    if (p.hpcur==0) {
      playAudio(deathFX);
      pDead = true;
      frameCount = -LOADTIME*10; 
      overworld.pause();
    }
  }
  protected void rwallColP(Player p) {
    p.pos.x = pos.x+size.x;
    p.vel.x = SPEED_MAX;
    p.vel.y = (gf.power[0]?JUMP_HI:JUMP_NOR)/2;
    --p.hpcur;
    playAudio(hitFX);
    if (p.hpcur==0) {
      playAudio(deathFX);
      pDead = true;
      frameCount = -LOADTIME*10; 
      overworld.pause();
    }
  }
}
class EnemySquish extends EnemyBasic {
  float hOrig;
  int hits;
  EnemySquish(float x, float y, float w, float h, int _hits) {
    super(x, y, w, h);
    hits = _hits;
    hOrig = h*16;
  }
  protected void floorColP(Player p) {
    playAudio(killFX);
    p.pos.y = pos.y-p.size.y;
    size.sub(0, hOrig/hits);
    pos.add(0, hOrig/hits);
    dead = size.y<=0;
    gf.points += 1;
    p.vel.y = p.attack?0:gf.power[0]?JUMP_HI:JUMP_NOR;
  }
}

class Item extends MasterEntity {
  int item;
  Item(float x, float y, float w, float h, int _item) {
    super(x, y, w, h);
    item = _item;
    img = boots[item];
  }
  void run() {
    if (touch(gf.player)!=-1&&keys.get(KEY_INTERACT)) {
      playAudio(itemFX);
      dead = true;
      gf.points += 10;
      gf.power[item] = true;
    }
  }
}

class ETank extends Item {
  ETank(float x, float y, float w, float h, int _item) {
    super(x, y, w, h, _item);
    img = tank;
  }
  void run() {
    if (touch(gf.player)!=-1&&keys.get(KEY_INTERACT)) {
      playAudio(itemFX);
      gf.tanks[item] = true;
      dead = true;
      gf.points += 10;
      gf.player.hpmax += 4;
      gf.player.hpcur += 4;
    }
  }
}

class Coin extends MasterEntity {
  Coin(float x, float y, float w, float h) {
    super(x, y, w, h);
    img = coin[int(
      map(
      sin(
      frameCount*6
      ), 
      -1, 1, 0, 3)
      )
    ];
  }
  void run() {
    img = coin[int(
      map(
      sin(
      frameCount*6
      ), 
      -1, 1, 0, 3)
      )
    ];
    if (touch(gf.player)!=-1) {
      dead = true;
      ++gf.coins;
      gf.points += 1;
      playAudio(coinFX);
      if (gf.coins%10==0) {
        if (gf.player.hpcur<gf.player.hpmax) {
          ++gf.player.hpcur;
        }
        playAudio(lifeFX);
      }
    }
  }
}

class Projectile extends MasterEntity {
  Projectile(float x, float y, float w, float h) {
    super(x, y, w, h);
    vel = new Vector(gf.player.vel.x+(gf.player.dir?FIRE_SPEEDX:-FIRE_SPEEDX), 5);
    img = fire[gf.player.dir?1:0];
  }
  void run() {
    if (vel.x > FIRE_SPEEDX) {
      vel.sub(ACCEL, 0);
    } else if (vel.x < -FIRE_SPEEDX) {
      vel.add(ACCEL, 0);
    }
    vel.add(GRAVITY);
    vel.conY(0, 0);
    //vel.conY(-FIRE_SPEEDY, 5);
    pos.add(vel);
    if (screenX<0) {
      pos.add(size.x/2, 0);
      pos.modX(16*16*abscreenX);
      pos.sub(size.x/2, 0);
    } else {
      if (pos.conX(0, (16*abscreenX-1)*16+8)) {
        gf.player.fire = null;
      }
    }
    if (screenY<0) {
      pos.modY(16*16*abscreenY);
    } else {
      if (pos.conY(0, (16*abscreenY-1)*16+8)) {
        vel.y = 0;
      }
    }
    checkCol();
  }
  void checkCol() {
    for (MasterEntity o : gf.entity) {
      if (o instanceof EnemySquish) {
        EnemySquish e = (EnemySquish)o;
        switch (e.touch(this)) {
        case -1:
          break;
        case 1:
        case 2:
        case 3:
        case 4:
          playAudio(killFX);
          e.size.sub(0, e.hOrig/e.hits);
          e.pos.add(0, e.hOrig/e.hits);
          e.dead = e.size.y<=0;
          gf.   points += 1;
          gf.player.fire = null;
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
          playAudio(killFX);
          o.dead = true;
          gf.points += 1;
          gf.player.fire = null;
          break;
        }
      }
    }
    for (MasterGeometry o : gf.geometry) {
      if (o instanceof PlatformDestroy) {
        switch (o.touch(this)) {
        case -1:
          break;
        case 1:
        case 2:
        case 3:
        case 4:
          playAudio(destroyFX);
          o.dead = true;
          gf.points += 1;
          gf.player.fire = null;
          break;
        }
      } else if (!(o instanceof Entrance)) {
        switch (o.touch(this)) {
        case -1:
          break;
        case 1:
          pos.y = o.pos.y-size.y;
          vel.y = -FIRE_SPEEDY;
          break;
        case 2:
          vel.y = 0;
          break;
        case 3:
        case 4:
          gf.player.fire = null;
          break;
        }
      }
    }
  }
}
