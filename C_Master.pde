class MasterObject {
  Vector pos, size;
  PImage img = null;
  boolean dead = false;
  MasterObject(float x, float y, float w, float h) {
    pos = new Vector(x*16, y*16);
    size = new Vector(w*16, h*16);
  }
  void run() {
    int thisAlgorithmBecomingSkynetCost = 999999999;
  }
  void display() {
  }
  void checkColP(Player p) {
    switch (touch(p)) {
    case -1:
      break;
    case 1:
      floorColP(p);
      break;
    case 2:
      ceilColP(p);
      break;
    case 3:
      rwallColP(p);
      break;
    case 4:
      lwallColP(p);
      break;
    }
  }
  @SuppressWarnings("unused")
    protected void floorColP(Player p) {
  }
  @SuppressWarnings("unused")
    protected void ceilColP(Player p) {
  }
  @SuppressWarnings("unused")
    protected void rwallColP(Player p) {
  }
  @SuppressWarnings("unused")
    protected void lwallColP(Player p) {
  }
  void checkColE(ArrayList<MasterEntity> al) {
    for (MasterEntity o : al) {
      switch (touch(o)) {
      case -1:
        break;
      case 1:
        floorColE(o);
        break;
      case 2:
        ceilColE(o);
        break;
      case 3:
        rwallColE(o);
        break;
      case 4:
        lwallColE(o);
        break;
      }
    }
  }
  @SuppressWarnings("unused")
    protected void floorColE(MasterEntity o) {
  }
  @SuppressWarnings("unused")
    protected void ceilColE(MasterEntity o) {
  }
  @SuppressWarnings("unused")
    protected void rwallColE(MasterEntity o) {
  }
  @SuppressWarnings("unused")
    protected void lwallColE(MasterEntity o) {
  }
  float getTop() { 
    return pos.y;
  }
  float getBottom() {
    return pos.y+size.y;
  }
  float getLeft() {
    return pos.x;
  }
  float getRight() { 
    return pos.x+size.x;
  }
  float getMiddleX() {
    return pos.x+size.x/2;
  }
  float getMiddleY() {
    return pos.y+size.y/2;
  }
  int touch(MasterObject o) {
    if (o != null && o != this 
      && getBottom() >= o.getTop() && getTop() <= o.getBottom()
      && getRight() >= o.getLeft() && getLeft() <= o.getRight()) {
      float angO = atan2(o.getMiddleY()-getMiddleY(), o.getMiddleX()-getMiddleX());
      float angTR = atan2(getTop()-getMiddleY(), getRight()-getMiddleX());
      float angBR = atan2(getBottom()-getMiddleY(), getRight()-getMiddleX());
      float angTL = atan2(getTop()-getMiddleY(), getLeft()-getMiddleX());
      float angBL = atan2(getBottom()-getMiddleY(), getLeft()-getMiddleX());
      if (angO >= angTL && angO <= angTR) return 1; // on TOP
      else if (angO >= angBR && angO <= angBL) return 2; // on BOTTOM
      else if (angO >= angTR && angO <= angBR) return 3; // on RIGHT
      else return 4; // on LEFT
    } else {
      return -1; // NOT TOUCHING
    }
  }
}

class MasterEntity extends MasterObject {
  Vector vel = new Vector(0, 0);
  boolean ground = true, attack = false;
  MasterEntity(float x, float y, float w, float h) {
    super(x, y, w, h);
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
}

class MasterGeometry extends MasterObject {
  MasterGeometry(float x, float y, float w, float h) {
    super(x, y, w, h);
  }
  void display() {
    if (img == null) {
      pg.fill(255, 127);
      pg.stroke(0);
      pg.rect(pos.x, pos.y, size.x, size.y);
      pg.noStroke();
    } else {
      for (int i = 0; i < size.x; i += 16) {
        for (int j = 0; j < size.y; j += 16) {
          pg.image(img, pos.x+i, pos.y+j, 16, 16);
        }
      }
    }
  }
}
