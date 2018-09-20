class Player extends MasterObject {
  Player(float _x, float _y) {
    super(_x, _y, 30, 30, false);
    state = new int[5];
    state[0] = 1; // Ground
    state[1] = 0; // Pound
    state[2] = 0; // WallJumpTime
    state[3] = 0; // WallJumpAble
    state[4] = 1; // CanWallJump
  }
  void move(MasterObject o) {
    if (keys.get('w')) { // 232.5 units jump
      if (state[1] == 1) {
        state[1] = 0;
        vel.y = 0;
      }
      if (state[0] == 1) {
        vel.set(vel.x, -15);
        state[0] = 0;
        state[2] = 0;
      } else if (state[3] == 1 && state[4] == 1 && state[2]!=0) {
        vel.set(state[2]<0?-5:state[2]>0?5:vel.x, -15);
        state[2] = 0;
      }
    }
    if (keys.get('s') && state[0]==0) {
      vel.set(0, 20);
      state[1] = 1;
    }
    if (keys.get('a') && keys.get('d')) {
    } else if (keys.get('a')) {
      vel.add(-0.5, 0);
    } else if (keys.get('d')) {
      vel.add(0.5, 0);
    } else if (vel.x > 1) {
      vel.add(-0.5, 0);
    } else if (vel.x < -1) {
      vel.add(0.5, 0);
    } else {
      vel.set(0, vel.y);
    }
    vel.add(GRAV);
    vel.x = constrain(vel.x, -10, 10);
    vel.y = constrain(vel.y, -15, 20);
    pos.add(vel);
    if (scrollX > 0) {
      pos.x = constrain(pos.x, 0, 600*scrollX);
    } else {
      pos.x = (pos.x+(600*abscrollX))%(600*abscrollX);
    }
    if (scrollY > 0) {
      pos.y = constrain(pos.y, 0, 600*scrollY);
    } else {
      pos.y = (pos.y+(600*abscrollY))%(600*abscrollY);
    }
    if (state[2] > 0) {
      state[2]--;
    }
    if (state[2] < 0) {
      state[2]++;
    }
    state[3] = (vel.y > 0)?1:0;
    state[0] = 0;
  }
}