class Inventory extends State {
  Inventory() {
    super("Inventory");
    button = new Button[12];
    // Return to the pause menu.
    button[0] = new Button(80, 208, 96, 32, "Return", new ButtonAction() {
      void click() {
        state = new Pause();
      }
    }
    );
    // High Jump
    button[1] = new ButtonInventory(17, 81, 30, 30, 0, new ButtonAction() {
      void click() {
        if (gameFile.powerHave[0]) gameFile.powerUse[0] = !gameFile.powerUse[0];
      }
    }
    );
    // Ground Pound
    button[2] = new ButtonInventory(17, 113, 30, 30, 1, new ButtonAction() {
      void click() {
        if (gameFile.powerHave[1]) gameFile.powerUse[1] = !gameFile.powerUse[1];
      }
    }
    );
    // Wall Jump (unused)
    button[3] = new ButtonInventory(17, 145, 30, 30, 2, new ButtonAction() {
      void click() {
        if (gameFile.powerHave[2]) gameFile.powerUse[2] = !gameFile.powerUse[2];
      }
    }
    );
    // Fire Flower
    button[4] = new ButtonInventory(81, 81, 30, 30, 3, new ButtonAction() {
      void click() {
        if (gameFile.powerHave[3]) gameFile.powerUse[3] = !gameFile.powerUse[3];
      }
    }
    );
    // Everything below this is unimplemented.
    button[5] = new ButtonInventory(81, 113, 30, 30, 4, new ButtonAction() {
      void click() {
        if (gameFile.powerHave[4]) gameFile.powerUse[4] = !gameFile.powerUse[4];
      }
    }
    );
    button[6] = new ButtonInventory(81, 145, 30, 30, 5, new ButtonAction() {
      void click() {
        if (gameFile.powerHave[5]) gameFile.powerUse[5] = !gameFile.powerUse[5];
      }
    }
    );
    button[7] = new ButtonInventory(145, 81, 30, 30, 6, new ButtonAction() {
      void click() {
        if (gameFile.powerHave[6]) gameFile.powerUse[6] = !gameFile.powerUse[6];
      }
    }
    );
    button[8] = new ButtonInventory(145, 113, 30, 30, 7, new ButtonAction() {
      void click() {
        if (gameFile.powerHave[7]) gameFile.powerUse[7] = !gameFile.powerUse[7];
      }
    }
    );
    button[9] = new ButtonInventory(145, 145, 30, 30, 8, new ButtonAction() {
      void click() {
        if (gameFile.powerHave[8]) gameFile.powerUse[8] = !gameFile.powerUse[8];
      }
    }
    );
    button[10] = new ButtonInventory(209, 81, 30, 30, 9, new ButtonAction() {
      void click() {
        if (gameFile.powerHave[9]) gameFile.powerUse[9] = !gameFile.powerUse[9];
      }
    }
    );
    button[11] = new ButtonInventory(209, 113, 30, 30, 10, new ButtonAction() {
      void click() {
        if (gameFile.powerHave[10]) gameFile.powerUse[10] = !gameFile.powerUse[10];
      }
    }
    );
  }
  void display() {
    super.display();
  }
  // Return to the pause menu.
  void keyPress() {
    if (key==ESC) state = new Pause();
  }
}

// The buttons used for the inventory require an image and an item index.
class ButtonInventory extends Button {
  int item;
  ButtonInventory(float x, float y, float w, float h, int _item, ButtonAction _ba) {
    super(x, y, w, h, "", _ba);
    item = _item;
  }
  // Check whether the player is hovering over the button.
  void run() {
    if (gameFile.powerHave[item]) super.run();
  }
  // Display the button, highlighted if hovered over.
  void display() {
    pg.fill(hover?255:127, 63, 191);
    pg.rect(pos.x, pos.y, size.x, size.y);
    try {
      pg.image(IMGitem[item], pos.x+size.x/2-8, pos.y+size.y/2-8, 16, 16);
    } 
    catch (NullPointerException e) {
      pg.fill(#ff6a00);
      pg.rect(pos.x+size.x/2-8, pos.y+size.y/2-8, 16, 16);
    }
    pg.fill(0, gameFile.powerHave[item]?gameFile.powerUse[item]?0:127:255);
    pg.rect(pos.x, pos.y, size.x, size.y);
  }
}
