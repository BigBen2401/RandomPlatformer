class Controls extends State {

  // Which button is waiting for a key press.
  ButtonControl awaitingInput = null;

  Controls() {
    super("Controls");
    button = new Button[7];
    // Return to the options or pause menu (depending on how it is accessed).
    button[0] = new Button(80, 208, 96, 32, "Return", new ButtonAction() {
      @Override void click() {
        setKeys();
        state = gameFile==null?new Options():new Pause();
      }
    }
    );
    // Left button.
    button[1] = new ButtonControl(16, 81, 96, 30, keyLabel("LEFT", KEY_LEFT), new ButtonAction() {
      @Override void click() {
        awaitingInput = (ButtonControl)button[1];
      }
    }
    , new ButtonAction() {
      @Override void click() {
        KEY_LEFT = Character.toLowerCase(key);
        button[1].text = keyLabel("LEFT", KEY_LEFT);
      }
    }
    );
    // Jump button.
    button[2] = new ButtonControl(16, 113, 96, 30, keyLabel("JUMP", KEY_UP), new ButtonAction() {
      @Override void click() {
        awaitingInput = (ButtonControl)button[2];
      }
    }
    , new ButtonAction() {
      @Override void click() {
        KEY_UP = Character.toLowerCase(key);
        button[2].text = keyLabel("JUMP", KEY_UP);
      }
    }
    );
    // Interact button.
    button[3] = new ButtonControl(16, 145, 96, 30, keyLabel("INTERACT", KEY_INTERACT), new ButtonAction() {
      @Override void click() {
        awaitingInput = (ButtonControl)button[3];
      }
    }
    , new ButtonAction() {
      @Override void click() {
        KEY_INTERACT = Character.toLowerCase(key);
        button[3].text = keyLabel("INTERACT", KEY_INTERACT);
      }
    }
    );
    // Right button.
    button[4] = new ButtonControl(144, 81, 96, 30, keyLabel("RIGHT", KEY_RIGHT), new ButtonAction() {
      @Override void click() {
        awaitingInput = (ButtonControl)button[4];
      }
    }
    , new ButtonAction() {
      @Override void click() {
        KEY_RIGHT = Character.toLowerCase(key);
        button[4].text = keyLabel("RIGHT", KEY_RIGHT);
      }
    }
    );
    // Pound button.
    button[5] = new ButtonControl(144, 113, 96, 30, keyLabel("POUND", KEY_DOWN), new ButtonAction() {
      @Override void click() {
        awaitingInput = (ButtonControl)button[5];
      }
    }
    , new ButtonAction() {
      @Override void click() {
        KEY_DOWN = Character.toLowerCase(key);
        button[5].text = keyLabel("POUND", KEY_DOWN);
      }
    }
    );
    // Attack button.
    button[6] = new ButtonControl(144, 145, 96, 30, keyLabel("ATTACK", KEY_ATTACK), new ButtonAction() {
      @Override void click() {
        awaitingInput = (ButtonControl)button[6];
      }
    }
    , new ButtonAction() {
      @Override void click() {
        KEY_ATTACK = Character.toLowerCase(key);
        button[6].text = keyLabel("ATTACK", KEY_ATTACK);
      }
    }
    );
  }

  void run () {
    // If not waiting for a key, act normal.
    if (awaitingInput==null) {
      super.run();
    } else {
      // Prevent the user from clicking any other buttons.
      for (Button b : button) {
        b.hover = b==awaitingInput;
      }
      // If the user presses a valid key, set that as the key.
      if (keyPressed && key != CODED && key != ESC) {
        playSound(FXbutton[1]);
        awaitingInput.ba2.click();
        awaitingInput = null;
      }
    }
  }

  // Return to the options or pause menu (depending on how it is accessed).
  void keyPress() {
    if (key==ESC) {
      setKeys();
      state = gameFile==null?new Options():new Pause();
    }
  }

  // Create the label for the button.
  String keyLabel(String s, char c) {
    return s+": "+(c>32&&c<127?c:'�');
  }
}

// The buttons used for the controls require a second ButtonAction.
class ButtonControl extends Button {
  ButtonAction ba2;
  ButtonControl(float x, float y, float w, float h, String s, ButtonAction _ba, ButtonAction _ba2) {
    super(x, y, w, h, s, _ba);
    ba2 = _ba2;
  }
}
