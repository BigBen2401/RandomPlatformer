class Pause extends State {
  Game pausedGame;
  Pause(State currentGame) {
    super("Paused");
    pausedGame = (Game)currentGame;
    overworld.pause();
    button = new Button[3];
    button[0] = new Button(80, 80, 96, 32, "Controls", new ButtonAction() {
      @Override public void click() {
        playAudio(hitFX);
      }
    }
    );
    button[1] = new Button(80, 144, 96, 32, "Screen: "+SCALE, new ButtonAction() {
      @Override public void click() {
        playAudio(buttonFX);
        SCALE += 4;
        if (SCALE*16>=displayWidth||SCALE*16>=displayHeight) SCALE = 8;
        surface.setSize(16*SCALE, 16*SCALE);
        delay(50);
        noLoop();
        loop();
        button[1].text = "Screen: "+SCALE;
      }
    }
    );
    button[2] = new Button(80, 208, 96, 32, "Exit", new ButtonAction() {
      @Override public void click() {
        playAudio(buttonFX);
        gf.fileSave();
        state = new Title();
      }
    }
    );
  }
  void keyPress() {
    if (key == ' ') {
      overworld.loop();
      playAudio(pauseFX);
      surface.setTitle(pausedGame.txt.replace("\n", "  "));
      Pause temp = (Pause)state;
      state = temp.pausedGame;
    }
  }
}
