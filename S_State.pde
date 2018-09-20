// Every screen is a separate State subclass, so I don't have to check the state manually.
State state;

abstract class State {

  // Each state (except Game) uses the same format, for consistency.
  Button[] button = new Button[0];
  String txt;

  // The buttons are set within the subclasses' constructors.
  State(String _txt) {
    txt = _txt;
  }

  // By default, only check if the user is hovering over a button.
  void run () {
    for (Button b : button) {
      b.run();
    }
  }

  // Display the state (all states except Game use the same format).
  void display() {
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

  // Fade out, to simulate loading.
  void fade() {
    pg.fill(0, map(abs(frameCount), 1, 15, 255, 0));
    pg.rect(-10, -10, 16*16+10, 16*16+10);
  }

  // State-specific inputs, if needed.
  void keyPress() {
  }

  // Buttons wait for a mouse release.
  void mouseRelease() {
    for (Button b : button) {
      if (b.hover) b.click();
    }
  }
}

// An implementation of a button.
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
  void run() {
    boolean phover = hover;
    hover = frameCount > 15 // Prevent buttons from running during the fade.
      && pos.y+size.y >= mouse.y && pos.y <= mouse.y
      && pos.x+size.x >= mouse.x && pos.x <= mouse.x;
    if (hover) mouseHover = true;
    if (!phover && hover) playSound(FXbutton[0]);
  }

  // Run the ButtonAction's click method.
  void click() {
    playSound(FXbutton[1]);
    ba.click();
  }

  // Display the button, highlighted if hovered over.
  void display() {
    pg.fill(hover?255:127, 63, 191);
    pg.rect(pos.x, pos.y, size.x, size.y);
    pg.fill(0);
    pg.text(text, pos.x+size.x/2, pos.y+size.y/2);
  }
}

// I use this so that each button can be given its own click() function.
interface ButtonAction {
  void click();
}
