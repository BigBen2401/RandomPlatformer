State state;

class State {
  Button[] button;
  String txt;
  State(String _txt) {
    // Equivalent of setup().
    txt = _txt;
    surface.setTitle(txt.replace("\n", "  "));
  }
  void run() {
    // Equivalent of draw().
    for (Button b : button) {
      b.run();
    }
    if (pmousePressed && !mousePressed) {
      for (Button b : button) {
        if (b.hover) b.click();
      }
    }
    pg.stroke(0);
    pg.textAlign(CENTER, CENTER);
    pg.background(255);
    pg.fill(0);
    pg.text(txt, 128, 40);
    for (Button b : button) {
      b.display();
    }
    fade();
  }
  void fade() {
    pg.fill(0, map(abs(frameCount), 1, LOADTIME, 255, 0));
    pg.rect(-10, -10, 16*16+10, 16*16+10);
  }
  void keyPress() {
    // Equivalent of keyPressed().
  }
  void keyRelease() {
    // Equivalent of keyRelease().
  }

  // A button, for the menus.
  class Button {

    Vector pos, size;
    String text;
    boolean hover = false;
    ButtonAction ba;

    Button(float x, float y, float w, float h, String s, ButtonAction _ba) {
      pos = new Vector(x, y);
      size = new Vector(w, h);
      text = s;
      ba = _ba;
    }

    // Check whether the player is hovering over the button.
    // Whether they click is checked by the relevant State subclass.
    void run() {
      if (frameCount < 0) {
        hover = false;
      } else {
        hover = pos.y+size.y >= mouse.y && pos.y <= mouse.y
          && pos.x+size.x >= mouse.x && pos.x <= mouse.x;
      }
      if (hover) hand = true;
    }

    void click() {
      if (hover) ba.click();
    }

    // Display the button, highlight it if hovered over.
    void display() {
      pg.fill(hover?255:127, 63, 191);
      pg.rect(pos.x, pos.y, size.x, size.y);
      pg.fill(0);
      pg.text(text, pos.x+size.x/2, pos.y+size.y/2);
    }
  }
}

interface ButtonAction {
  void click();
}
