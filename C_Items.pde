// Floating coins.
class Coin extends MasterEntity {
  Coin(float x, float y, float w, float h) {
    super(x, y, w, h);
  }

  // Collect if the player touches it at all.
  void run() {
    if (touch(gameFile.player)!=-1) {
      playSound(FXitem[0]);
      dead = true;
      gameFile.points += 1;
      // Recover health.
      if (gameFile.player.hpCur<gameFile.player.hpMax) {
        ++gameFile.coins;
        if (gameFile.coins==8) {
          playSound(FXitem[1]);
          gameFile.coins = 0;
          ++gameFile.player.hpCur;
        }
      }
    }
  }

  PImage getIMG() {
    return IMGcoin[0][int(constrain(1.5+1.5*sin(frameCount*6), 0, 2))];
  }
}

// Major items.
class Item extends MasterEntity {

  // Which item it corresponds to.
  int item;

  Item(float x, float y, float w, float h, int _item) {
    super(x, y, w, h);
    item = _item;
  }

  // The player has to actively interact with it to obtain it.
  void run() {
    if (touch(gameFile.player)!=-1&&keys.get(KEY_INTERACT)) {
      playSound(FXitem[2]);
      dead = true;
      gameFile.points += 10;
      gameFile.powerHave[item] = true;
      gameFile.powerUse[item] = true;
    }
  }

  PImage getIMG() {
    return IMGitem[item];
  }
}

// Energy Tanks, or E-Tanks.
class ETank extends Item {

  ETank(float x, float y, float w, float h, int _item) {
    super(x, y, w, h, _item);
  }

  // The player has to actively interact with it to obtain it.
  void run() {
    if (touch(gameFile.player)!=-1&&keys.get(KEY_INTERACT)) {
      playSound(FXitem[2]);
      gameFile.tanks[item] = true;
      dead = true;
      gameFile.points += 10;
      gameFile.player.hpMax += 4;
      gameFile.player.hpCur += 4;
    }
  }

  PImage getIMG() {
    return IMGtank;
  }
}
