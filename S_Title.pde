boolean fileLoad = false;
class Title extends State {
  Title() {
    super("Random Platformer™\n\n©u12palmero 2018");
    button = new Button[4];
    button[0] = new Button(16, 80, 96, 32, "Continue", new ButtonAction() {
      @Override public void click() {
        if (new File("save.txt").exists()) {
          playAudio(buttonFX);
          fileLoad = true;
          frameCount = -LOADTIME; 
          overworld.pause();
        } else {
          println("WHY");
          playAudio(hitFX);
        }
      }
    }
    );
    button[1] = new Button(144, 80, 96, 32, "New Game", new ButtonAction() {
      @Override public void click() {
        playAudio(buttonFX);
        frameCount = -LOADTIME; 
        overworld.pause();
      }
    }
    );
    button[2] = new Button(80, 144, 96, 32, "Options", new ButtonAction() {
      @Override public void click() {
        playAudio(buttonFX);
        state = new Options();
      }
    }
    );
    button[3] = new Button(80, 208, 96, 32, "Quit", new ButtonAction() {
      @Override public void click() {
        playAudio(buttonFX);
        exit();
      }
    }
    );
  }
}
