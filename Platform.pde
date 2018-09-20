class Platform extends MasterObject {
  int type;
  Platform(float _x, float _y, float _w, float _h, boolean _des) {
    super(_x, _y, _w, _h, _des);
    type = 0;
  }
  void colCeil(MasterObject o) {
    o.vel.y = GRAV.y*2;
    o.pos.y = getBottom() + o.h/2;
  }
  void colFloor(MasterObject o) {
    if (o.state[1]==1&&des) {
      pos.y = -1000;
    } else {
      o.vel.y = 0;
      o.pos.y = getTop() - o.h/2;
      o.state[0] = 1;
      o.state[1] = 0;
    }
  }
  void colWallR(MasterObject o) {
    o.vel.x = 0;
    o.pos.x = getRight() + o.w/2;
    o.state[2] = 10;
  }
  void colWallL(MasterObject o) {
    o.vel.x = 0;
    o.pos.x = getLeft() -o. w/2;
    o.state[2] = -10;
  }
}
class MovePlatform extends Platform {
  PVector posMin, posMax;
  float xSpeed, ySpeed;
  MovePlatform(float _x1, float _y1, float _x2, float _y2, float _w, float _h, boolean _des, float _xSpeed, float _ySpeed) {
    super(_x2, _y2, _w, _h, _des);
    posMin = new PVector(_x1, _y1);
    posMax = new PVector(_x2, _y2);
    xSpeed = _xSpeed;
    ySpeed = _ySpeed;
    type = 1;
  }
  void move(MasterObject o) {
    if (touch(o)!=-1) {
      float temp = pos.x-o.pos.x;
      pos.x = map(cos(frameCount*xSpeed), -1, 1, posMin.x, posMax.x);
      o.pos.x = pos.x-temp;
      temp = pos.y-o.pos.y;
      pos.y = map(cos(frameCount*ySpeed), -1, 1, posMin.y, posMax.y);
      o.pos.y = pos.y-temp;
    } else {
      pos.x = map(cos(frameCount*xSpeed), -1, 1, posMin.x, posMax.x);
      pos.y = map(cos(frameCount*ySpeed), -1, 1, posMin.y, posMax.y);
    }
  }
}
class Entrance extends Platform {
  String level = "";
  Entrance(float _x, float _y, float _w, float _h, boolean _des, String _level) {
    super(_x, _y, _w, _h, _des);
    level = _level;
    type = 2;
  }
  void collide(MasterObject o) {
    if (touch(o)!=-1 && keys.get('s')) {
      frameCount = -60;
    }
  }
}
void loadPlatforms(String file) {
  platform = new ArrayList<Platform>();
  Table table = loadTable(file+".csv", "header");
  for (TableRow row : table.rows()) {
    switch (row.getInt("Type")) {
    case 0:
      // Still platform.
      platform.add(new Platform(row.getInt("xPos")*25, row.getInt("yPos")*25, 
        row.getInt("width")*25, row.getInt("height")*25, row.getInt("destroyable")==1));
      break;
    case 1:
      // Moving platform.
      platform.add(new MovePlatform(row.getInt("xPos")*25, row.getInt("yPos")*25, 
        row.getInt("xTarget")*25, row.getInt("yTarget")*25, row.getInt("width")*25, row.getInt("height")*25, 
        row.getInt("destroyable")==1, row.getFloat("xSpeed"), row.getFloat("ySpeed")));
      break;
    case 2:
      //Entrance.
      platform.add(new Entrance(row.getInt("xPos")*25, row.getInt("yPos")*25, 
        row.getInt("width")*25, row.getInt("height")*25, row.getInt("destroyable")==1, row.getString("Comment")));
      player.vel = new PVector(0, 0);
      player.pos = new PVector(row.getInt("xPos")*25, row.getInt("yPos")*25);
      player.state[1] = 0;
      break;
    case -1:
      // Level metadata.
      scrollX = row.getInt("xPos");
      abscrollX = abs(scrollX);
      scrollY = row.getInt("yPos");
      abscrollY = abs(scrollY);
      break;
    }
  }
}