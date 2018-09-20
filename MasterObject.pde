class MasterObject {
  int[] state;
  boolean des;
  PVector pos, vel = new PVector(0, 0);
  float w, h;
  MasterObject(float _x, float _y, float _w, float _h, boolean _des) {
    des = _des;
    pos = new PVector(_x, _y);
    w = _w;
    h = _h;
  }
  void run(MasterObject o, color c) {
    move(o);
    collide(o);
    display(c);
  }
  void move(MasterObject o) {
  }
  void collide(MasterObject o) {
    switch (touch(o)) {
    case -1:
      break;
    case 0:
      colCeil(o);
      break;
    case 1:
      colFloor(o);
      break;
    case 2:
      colWallR(o);
      break;
    case 3:
      colWallL(o);
      break;
    }
  }
  void colCeil(MasterObject o) {
  }
  void colFloor(MasterObject o) {
  }
  void colWallR(MasterObject o) {
  }
  void colWallL(MasterObject o) {
  }
  void display(color c) {
    if (konami&&player==this) {
      fill(random(255), random(255), random(255));
    } else {
      fill(c);
    }
    rect(pos.x, pos.y, w, h);
  }
  float getLeft() {
    return pos.x - (w/2);
  }
  float getRight() {
    return pos.x + (w/2);
  }
  float getTop() {
    return pos.y - (h/2);
  }
  float getBottom() {
    return pos.y + (h/2);
  }
  int touch(MasterObject o) {
    if (o != null && getBottom() >= o.getTop() && getTop() <= o.getBottom()
      && getRight() >= o.getLeft() && getLeft() <= o.getRight()) {
      float ang = atan2(pos.y-o.pos.y, pos.x-o.pos.x);
      if (ang >= atan2(h/2, w/2) && ang <= atan2(h/2, w/-2)) {
        return 1; // The platform is acting as a floor.
      } else if (ang <= atan2(h/-2, w/2) && ang >= atan2(h/-2, w/-2)) {
        return 0; // The platform is acting as a ceiling.
      } else if (ang <= atan2(h/2, w/2) &&  ang >= atan2(h/-2, w/2)) {
        return 3; // The platform is acting as a left wall.
      } else {
        return 2; // The platform is acting as a right wall.
      }
    } else {
      return -1;
    }
  }
}