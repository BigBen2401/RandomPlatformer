class Game extends State {
  Game() {
    super("thisAlgorithmBecomingSkynetCost = 999999999");
  }
  void run() {
    if (frameCount > 15) {
      // Run (in order): the player, all other entities, all pieces of geometry.
      // For example: the player moves forward, an entity knocks them backwards, a wall pushes them out.
      gameFile.player.run();
      for (MasterEntity e : gameFile.entity) {
        e.run();
      }
      for (MasterGeometry g : gameFile.geometry) {
        g.run();
      }
      // Kill off any dead entities, and remove any destroyed geometry.
      for (int i = gameFile.entity.size()-1; i > -1; --i) {
        if (gameFile.entity.get(i).dead) gameFile.entity.remove(i);
      }
      for (int i = gameFile.geometry.size()-1; i > -1; --i) {
        if (gameFile.geometry.get(i).dead) gameFile.geometry.remove(i);
      }
    }
  }
  void display() {
    pg.noStroke();
    try {
      pg.image(IMGtile[gameFile.tileSet][0], -2, -2, 260, 260);
    } 
    catch (NullPointerException e) {
      pg.fill(255);
      pg.rect(-2, -2, 260, 260);
    }
    // Translate the canvas, which is how I scroll the screen.
    pg.pushMatrix();
    pg.translate(int(constrain(120-gameFile.player.pos.x, (gameFile.screenX-1)*-256, 0)), 
      int(constrain(120-gameFile.player.pos.y, (gameFile.screenY-1)*-256, 0)));
    // Draw the geometry and entities.
    for (MasterGeometry g : gameFile.geometry) {
      g.display();
    }
    for (MasterEntity e : gameFile.entity) {
      e.display();
    }
    gameFile.player.display();
    // Reset the translation, and draw the HUD.
    pg.popMatrix();
    // Health bar
    int hpCur = gameFile.player.hpCur, hpMax = gameFile.player.hpMax;
    try {
      // Health bar units
      for (int i = 0; i < hpCur; ++i) {
        pg.image(IMGhealth[0][1], 16+4*(i%24), 8+int(i/24)*16);
      }
      for (int i = hpCur; i < hpMax; ++i) {
        pg.image(IMGhealth[0][0], 16+4*(i%24), 8+int(i/24)*16);
      }
      // Health bar ends
      if (hpMax <= 24) {
        pg.image(IMGhealth[1][0], 8, 8);
        pg.image(IMGhealth[2][0], 16+4*hpMax, 8);
      } else if (hpMax < 48) {
        pg.image(IMGhealth[1][1], 8, 8);
        pg.image(IMGhealth[2][0], 112, 8);
        pg.image(IMGhealth[2][0], -80+4*hpMax, 24);
      } else {
        pg.image(IMGhealth[1][1], 8, 8);
        pg.image(IMGhealth[2][1], 112, 8);
      }
      // Coin units
      if (gameFile.player.hpCur<gameFile.player.hpMax) {
        for (int i = 0; i < gameFile.coins; ++i) {
          pg.image(IMGcoin[1][int(constrain(1.5+1.5*sin(frameCount*6), 0, 2))], 8+8*i, 24+int(hpMax/25)*16);
        }
        for (int i = gameFile.coins; i < 8; ++i) {
          pg.image(IMGcoin[1][2], 8+8*i, 24+int(hpMax/25)*16);
        }
      }
    } 
    catch (NullPointerException e) {
      // Health bar units
      pg.fill(#FF0000);
      for (int i = 0; i < hpCur; ++i) {
        pg.rect(16+4*(i%24), 8+int(i/24)*16, 4, 16);
      }
      pg.fill(#7F3F3F);
      for (int i = hpCur; i < hpMax; ++i) {
        pg.rect(16+4*(i%24), 8+int(i/24)*16, 4, 16);
      }
      // Health bar ends
      pg.fill(#7F0000);
      if (hpMax <= 24) {
        ;
        pg.rect(8, 8, 8, 16);
        pg.rect(16+4*hpMax, 8, 8, 16);
      } else if (hpMax < 48) {
        pg.rect(8, 8, 8, 32);
        pg.rect(112, 8, 8, 16);
        pg.rect(-80+4*hpMax, 24, 8, 16);
      } else {
        pg.rect(8, 8, 8, 32);
        pg.rect(112, 8, 8, 32);
      }
      // Coin units
      if (gameFile.player.hpCur<gameFile.player.hpMax) {
        pg.fill(#E79C21);
        for (int i = 0; i < gameFile.coins; ++i) {
          pg.rect(8+8*i, 24+int(hpMax/25)*16, 8, 8);
        }
        pg.fill(#522100);
        for (int i = gameFile.coins; i < 8; ++i) {
          pg.rect(8+8*i, 24+int(hpMax/25)*16, 8, 8);
        }
      }
    }
    // Text
    pg.fill(255, 0, 0);
    pg.textAlign(RIGHT, BOTTOM);
    pg.text("Points: "+gameFile.points*100, 224, 24);
    //pg.text("FPS: "+round(frameRate), 224, 40);
    fade();
  }
  // Pause the game.
  void keyPress() {
    if (key==ESC) {
      playSound(FXpause);
      state = new Pause();
    }
  }
}
