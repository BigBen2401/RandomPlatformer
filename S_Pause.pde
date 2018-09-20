class Pause extends State {
  Pause() {
    super("Pause");
    button = new Button[4];
    // Enter the controls menu.
    button[0] = new Button(80, 80, 96, 32, "Controls", new ButtonAction() {
      @Override void click() {
        state = new Controls();
      }
    }
    );
    // Enter the inventory menu.
    button[1] = new Button(80, 144, 96, 32, "Inventory", new ButtonAction() {
      @Override void click() {
        state = new Inventory();
      }
    }
    );
    // Reload the level (equivalent of savewarping).
    button[2] = new Button(16, 208, 96, 32, "Restart Level", new ButtonAction() {
      void click() {
        playSound(FXpause);
        state = new Game();
        frameCount = -15;
      }
    }
    );
    // Save progress, and return to the title screen.
    button[3] = new Button(144, 208, 96, 32, "Quit", new ButtonAction() {
      @Override public void click() {
        gameFile.saveFile();
        gameFile = null;
        state = new Title();
      }
    }
    );
  }

  // Return to the game.
  void keyPress() {
    if (key==ESC) {
      playSound(FXpause);
      state = new Game();
    }
  }
}
