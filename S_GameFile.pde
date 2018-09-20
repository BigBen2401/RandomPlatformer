GameFile gf;

class GameFile {
  ArrayList<MasterGeometry> geometry = new ArrayList<MasterGeometry>(); // All geometry, for easy iteration.
  ArrayList<MasterEntity> entity = new ArrayList<MasterEntity>(); // All entities (except the player), for easy iteration.
  Player player = new Player(10, 29, 1, 1); // The player is often treated differently than other entities (e.g. it is the only object to persist between areas).
  GameFile() {
  }
  String curArea = "tower", // The current area, so I know which entrance to use when I go to another area.
    nexArea = "tower"; // The next area, stored in a variable to delay the transition.
  boolean[] power = {false, false, false, false, false, false, false, false, false, false, false}, 
    tanks = {false, false, false, false, false, false, false, false, false, false, false};
  //{<Tower>, <Plains>, <Cave>, <Clouds>, <Mountains>, <Tundra>, <Ocean>, <Jungle>, <Desert>, <Lava>, <Castle>};
  int points = 0, coins = 0;
  void fileSave() {
    String[] file = new String[4+power.length+tanks.length];
    file[0] = curArea;
    file[1] = nexArea;
    file[2] = str(points);
    file[3] = str(coins);
    for (int i = 0; i < power.length; ++i) {
      file[i+4] = str(power[i]);
    }
    for (int i = 0; i < tanks.length; ++i) {
      file[i+4+power.length] = str(tanks[i]);
    }
    saveStrings("data/save.txt", file);
  }
  void fileLoad() {
    String[] file = loadStrings("save.txt");
    curArea = file[0];
    nexArea = file[1];
    points = int(file[2]);
    coins = int(file[3]);
    for (int i = 0; i < power.length; ++i) {
      power[i] = boolean(file[i+4]);
    }
    for (int i = 0; i < tanks.length; ++i) {
      tanks[i] = boolean(file[i+4+power.length]);
      if (tanks[i]) {
        player.hpmax += 4;
      }
    }
  }

  void loadArea() {
    while (geometry.size() > 0) {
      geometry.remove(0);
    }
    Table table = loadTable("data/"+nexArea+"/geometry.csv", "header");
    try {
      table.getRow(0);
    }
    catch (NullPointerException e) {
      curArea = "plains";
      nexArea = "tower";
      table = loadTable("data/"+nexArea+"/geometry.csv", "header");
    }
    loadTiles(nexArea);
    for (TableRow row : table.rows()) {
      switch(row.getInt("Type")) {
      case 0: // Normal Platform
        geometry.add(new PlatformNormal(row.getFloat("X Pos"), row.getFloat("Y Pos"), row.getFloat("Width"), row.getFloat("Height")));
        break;
      case 1: // Destroyable Platform
        geometry.add(new PlatformDestroy(row.getFloat("X Pos"), row.getFloat("Y Pos"), row.getFloat("Width"), row.getFloat("Height"), true));
        break;
      case 2: // Entrance
        Entrance e = new Entrance(row.getFloat("X Pos"), row.getFloat("Y Pos"), row.getFloat("Width"), row.getFloat("Height"), row.getString("Comment"));
        geometry.add(e);
        if (e.area.equals(curArea)) {
          player.pos = e.pos.copy();
          player.pos.add(e.size.x/2-player.size.x/2, e.size.y-player.size.y);
          player.vel = new Vector(0, 0);
          player.ground = true;
          player.fire = null;
        }
        break;
      case 3: // Hidden destroyable Platform
        geometry.add(new PlatformDestroy(row.getFloat("X Pos"), row.getFloat("Y Pos"), row.getFloat("Width"), row.getFloat("Height"), false));
        break;
      case -1: // Metadata
        screenX = row.getInt("X Pos");
        abscreenX = abs(screenX);
        screenY = row.getInt("Y Pos");
        abscreenY = abs(screenY);
        break;
      }
    }
    while (entity.size() > 0) {
      entity.remove(0);
    }
    table = loadTable("data/"+nexArea+"/entity.csv", "header");
    for (TableRow row : table.rows()) {
      switch(row.getInt("Type")) {
      case 100: // Basic Enemy
        entity.add(new EnemyBasic(row.getFloat("X Pos"), row.getFloat("Y Pos"), row.getFloat("Width"), row.getFloat("Height")));
        break;
      case 101: // Squish Enemy
        entity.add(new EnemySquish(row.getFloat("X Pos"), row.getFloat("Y Pos"), row.getFloat("Width"), row.getFloat("Height"), row.getInt("Health")));
        break;
      case 103: // Item
        if (!power[row.getInt("Health")]) {
          entity.add(new Item(row.getFloat("X Pos"), row.getFloat("Y Pos"), row.getFloat("Width"), row.getFloat("Height"), row.getInt("Health")));
        }
        break;
      case 104: // Coin
        entity.add(new Coin(row.getFloat("X Pos"), row.getFloat("Y Pos"), row.getFloat("Width"), row.getFloat("Height")));
        break;
      case 107: // ETank
        if (!tanks[row.getInt("Health")]) {
          entity.add(new ETank(row.getFloat("X Pos"), row.getFloat("Y Pos"), row.getFloat("Width"), row.getFloat("Height"), row.getInt("Health")));
        }
        break;
      }
    }
    if (pDead) {
      points /= 2;
      player.hpcur = 4;
      pDead = false;
    }
  }
}
