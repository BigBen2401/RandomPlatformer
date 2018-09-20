class Title extends State {

  Title() {
    super("Random Platformer™\n\n©u12palmero 2018");
    playMusic(BGMtitle);
    button = new Button[4];
    // Continue the game from a save file.
    button[0] = new Button(16, 80, 96, 32, "Continue", new ButtonAction() {
      @Override void click() {
        if (new File(dataPath("file.rpsf")).exists()) {
          gameFile = new GameFile();
          gameFile.loadFile();
          frameCount = -15;
        }
      }
    }
    );
    // Start the game from the beginning.
    button[1] = new Button(144, 80, 96, 32, "New Game", new ButtonAction() {
      @Override void click() {
        gameFile = new GameFile();
        frameCount = -15;
      }
    }
    );
    // Enter the options menu.
    button[2] = new Button(80, 144, 96, 32, "Options", new ButtonAction() {
      @Override void click() {
        state = new Options();
      }
    }
    );
    // Close the game.
    button[3] = new Button(80, 208, 96, 32, "Close", new ButtonAction() {
      @Override void click() {
        exit();
      }
    }
    );
  }
}
