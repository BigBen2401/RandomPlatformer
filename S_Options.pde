class Options extends State {
  Options() {
    super("Options");
    button = new Button[3];
    // Enter the controls menu.
    button[0] = new Button(80, 80, 96, 32, "Controls", new ButtonAction() {
      @Override void click() {
        state = new Controls();
      }
    }
    );
    // Resize the window.
    button[1] = new Button(80, 144, 96, 32, "Scale: "+int(SCALE/0.16)+"%", new ButtonAction() {
      @Override void click() {
        SCALE += 4;
        if (SCALE*16>=displayWidth||SCALE*16>=displayHeight) SCALE = 8;
        surface.setSize(16*SCALE, 16*SCALE);
        button[1].text = "Scale: "+int(SCALE/0.16)+"%";
      }
    }
    );
    // Return to the title screen.
    button[2] = new Button(80, 208, 96, 32, "Return", new ButtonAction() {
      @Override void click() {
        state = new Title();
      }
    }
    );
  }

  // Return to the title screen.
  void keyPress() {
    if (key==ESC) state = new Title();
  }
}
