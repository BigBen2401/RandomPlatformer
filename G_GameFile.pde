// All of the variables related to the game are contained within a GameFile.
GameFile gameFile = null;

class GameFile {

  // All geometry and entities. The player is often treated differently, so it is separate.
  ArrayList<MasterGeometry> geometry = new ArrayList<MasterGeometry>();
  ArrayList<MasterEntity> entity = new ArrayList<MasterEntity>();
  Player player = new Player(9, 21, 1, 1);

  // The total amount of points, and number
  int coins, points;

  boolean[] powerHave = {false, false, false, false, false, false, false, false, false, false, false}, 
    powerUse = {false, false, false, false, false, false, false, false, false, false, false}, 
    tanks = {false, false, false, false, false, false, false, false, false, false, false};

  // The current and previous levels (to determine which entrance to use).
  int curLev = 0, preLev = 0;
  // Which tileset to use.
  int tileSet = 0;
  // How big the level is.
  int screenX = 0, screenY = 0;

  GameFile() {
  }

  void loadLevel() {
    // If the player tries to go beyond the end of the demo,
    // swap curLev and preLev to keep them in the same level.
    if (curLev > 3) {
      curLev = curLev^preLev;
      preLev = curLev^preLev;
      curLev = curLev^preLev;
    }

    // Load the metadata.
    TableRow metadata = loadTable("data/Levels/Metadata.csv", "header").getRow(curLev);
    screenX = metadata.getInt("ScreenX");
    screenY = metadata.getInt("ScreenY");
    tileSet = metadata.getString("Tileset").charAt(0)-'A';
    playMusic(BGMlevel[gameFile.curLev]);

    // Load any geometry.
    geometry = new ArrayList<MasterGeometry>();
    Table table = loadTable("data/Levels/"+curLev+"geometry.csv", "header");
    for (TableRow row : table.rows()) {
      switch (row.getInt("Type")) {
      case 0: // Normal Platform
        geometry.add(new PlatformNormal(row.getFloat("X"), row.getFloat("Y"), row.getFloat("W"), row.getFloat("H")));
        break;
      case 1: // Destroyable Platform
        geometry.add(new PlatformDestroy(row.getFloat("X"), row.getFloat("Y"), row.getFloat("W"), row.getFloat("H")));
        break;
      case 10: // Entrance
        Entrance e = new Entrance(row.getFloat("X"), row.getFloat("Y"), row.getFloat("W"), row.getFloat("H"), int(row.getString("Comment").substring(4)));
        geometry.add(e);
        if (e.level == preLev) {
          player.pos = e.pos.copy();
          player.pos.add(e.size.x/2-player.size.x/2, e.size.y-player.size.y);
          player.vel.mul(0);
          player.ground = true;
          player.attack = false;
        }
      }
    }

    // Load any entities.
    entity = new ArrayList<MasterEntity>();
    table = loadTable("data/Levels/"+curLev+"entity.csv", "header");
    for (TableRow row : table.rows()) {
      switch (row.getInt("Type")) {
      case 0: // Coin
        entity.add(new Coin(row.getFloat("X"), row.getFloat("Y"), row.getFloat("W"), row.getFloat("H")));
        break;
      case 1: //E-Tank
        if (!tanks[row.getInt("Other")]) entity.add(new ETank(row.getFloat("X"), row.getFloat("Y"), row.getFloat("W"), row.getFloat("H"), row.getInt("Other")));
        break;
      case 2: //Upgrade
        if (!powerHave[row.getInt("Other")]) entity.add(new Item(row.getFloat("X"), row.getFloat("Y"), row.getFloat("W"), row.getFloat("H"), row.getInt("Other")));
        break;
      case 10: // Basic enemy
        entity.add(new EnemyBasic(row.getFloat("X"), row.getFloat("Y"), row.getFloat("W"), row.getFloat("H")));
        break;
      case 11: //Squishable enemy
        entity.add(new EnemySquish(row.getFloat("X"), row.getFloat("Y"), row.getFloat("W"), row.getFloat("H"), row.getInt("Other")));
        break;
      }
    }

    // If player is dead, penalise them
    if (player.dead) {
      player.dead = false;
      points /= 2;
      player.hpCur = 4;
    }
  }

  void loadFile() {
    byte[] dataLoad = loadBytes("data/file.rpsf");
    // Load powerups and tanks.
    for (int i = 0; i < 6; ++i) {
      String s = binary(dataLoad[i]);
      powerHave[2*i] = s.charAt(0)=='1';
      powerUse[2*i] = s.charAt(1)=='1';
      tanks[2*i] = s.charAt(2)=='1';
      if (i!=5) {
        powerHave[2*i+1] = s.charAt(4)=='1';
        powerUse[2*i+1] = s.charAt(5)=='1';
        tanks[2*i+1] = s.charAt(6)=='1';
      }
    }
    // Load points
    String s = "";
    for (int i = 0; i < 4; ++i) {
      s+=binary(dataLoad[6+i]);
    }
    try{
      points = unbinary(s);
    }catch(NumberFormatException e){
      points = 0;
    }
    // Load level progress
    curLev = int(dataLoad[10])/16;
    preLev = int(dataLoad[10])%16;
  }

  void saveFile() {
    byte[] dataSave = new byte[11];
    // Save powerups and tanks.
    for (int i = 0; i < 6; ++i) {
      String s = "";
      s += powerHave[2*i]?"1":"0";
      s += powerUse[2*i]?"1":"0";
      s += tanks[2*i]?"10":"00";
      if (i==5) s += "0000";
      else {
        s += powerHave[2*i+1]?"1":"0";
        s += powerUse[2*i+1]?"1":"0";
        s += tanks[2*i+1]?"10":"00";
      }
      dataSave[i] = byte(unbinary(s));
    }
    // Save points.
    String s = binary(points);
    for (int i = 0; i < 4; ++i) {
      dataSave[6+i] = byte(unbinary(s.substring(i*8, (i+1)*8)));
    }
    // Save level progress.
    dataSave[10] = byte(16*curLev+preLev);
    saveBytes("data/file.rpsf", dataSave);
  }
}
