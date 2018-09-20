// All other classes within the game are subtypes of this, for inheritance.
abstract class MasterObject {

  // Properties that all classes need, and the constructor to set them.
  Vector pos, size;
  boolean dead = false;
  MasterObject(float x, float y, float w, float h) {
    pos = new Vector(x*16, y*16);
    size = new Vector(w*16, h*16);
  }

  // All classes need to run their logic, and display some image to the screen.
  abstract void run();
  abstract void display();
  abstract PImage getIMG();

  // All classes need to consider what happens on collision.
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
  void checkColE(ArrayList<MasterEntity> al) {
    for (MasterEntity e : al) {
      switch (touch(e)) {
      case -1:
        break;
      case 1:
        floorColE(e);
        break;
      case 2:
        ceilColE(e);
        break;
      case 3:
        rwallColE(e);
        break;
      case 4:
        lwallColE(e);
        break;
      }
    }
  }
  // Some classes don't care about some types of collisions, so they need an empty method,
  @SuppressWarnings("unused")  
    void floorColP(Player p) {
  }
  @SuppressWarnings("unused")
    void ceilColP(Player p) {
  }
  @SuppressWarnings("unused")
    void rwallColP(Player p) {
  }
  @SuppressWarnings("unused")
    void lwallColP(Player p) {
  }
  @SuppressWarnings("unused")
    void floorColE(MasterEntity e) {
  }
  @SuppressWarnings("unused")
    void ceilColE(MasterEntity e) {
  }
  @SuppressWarnings("unused")
    void rwallColE(MasterEntity e) {
  }
  @SuppressWarnings("unused")
    void lwallColE(MasterEntity e) {
  }

  // Get various useful coordinates.
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

  // Get the type (if any) of collision with another object.
  int touch(MasterObject o) {
    // If o is a different object to this, and is intersecting this.
    if (o != null && o != this
      && getBottom() >= o.getTop() && getTop() <= o.getBottom()
      && getRight() >= o.getLeft() && getLeft() <= o.getRight()) {
      // Look at the angle ranges, as defined in the report.
      float angO = atan2(o.getMiddleY()-getMiddleY(), o.getMiddleX()-getMiddleX());
      float angTR = atan2(getTop()-getMiddleY(), getRight()-getMiddleX());
      float angBR = atan2(getBottom()-getMiddleY(), getRight()-getMiddleX());
      float angTL = atan2(getTop()-getMiddleY(), getLeft()-getMiddleX());
      float angBL = atan2(getBottom()-getMiddleY(), getLeft()-getMiddleX());
      // o is above this.
      if (angO >= angTL && angO <= angTR) return 1;
      // o is below this
      else if (angO >= angBR && angO <= angBL) return 2;
      // o is to the right of this
      else if (angO >= angTR && angO <= angBR) return 3;
      // o is to the left of this
      else return 4;
    }
    // o is not touching this
    else return -1;
  }
}

// Some things are exclusive to entities.
abstract class MasterEntity extends MasterObject {

  Vector vel = new Vector(0, 0);
  boolean attack = false, ground = true;

  MasterEntity(float x, float y, float w, float h) {
    super(x, y, w, h);
  }

  void display() {
    try {
      pg.image(getIMG(), pos.x, pos.y, size.x, size.y);
    } 
    catch (NullPointerException e) {
      pg.fill(#ff6a00);
      pg.rect(pos.x, pos.y, size.x, size.y);
    }
  }
}

// Some things are exclusive to geometry.
abstract class MasterGeometry extends MasterObject {

  MasterGeometry(float x, float y, float w, float h) {
    super(x, y, w, h);
  }

  void display() {
    try {
      for (int i = 0; i < size.x; i += 16) {
        for (int j = 0; j < size.y; j += 16) {
          pg.image(getIMG(), pos.x+i, pos.y+j, 16, 16);
        }
      }
    } 
    catch (NullPointerException e) {
      pg.fill(#3fff00);
      pg.rect(pos.x, pos.y, size.x, size.y);
    }
  }
}
