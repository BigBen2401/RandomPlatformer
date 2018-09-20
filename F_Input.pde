final char KEY_UP = 'w', KEY_LEFT = 'a', KEY_DOWN = 's', KEY_RIGHT = 'd', KEY_INTERACT = 'q', KEY_ATTACK = 'e';
HashMap<Character, Boolean> keys = new HashMap<Character, Boolean>();

char[] keyHistory = {' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '};


boolean konami = false;

void setKeys() {
  keys = new HashMap<Character, Boolean>();
  // Initialize the keys.
  keys.put(KEY_UP, false);
  keys.put(KEY_LEFT, false);
  keys.put(KEY_RIGHT, false);
  keys.put(KEY_DOWN, false);
  keys.put(KEY_INTERACT, false);
  keys.put(KEY_ATTACK, false);
}

void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
      key = KEY_UP;
    } else if (keyCode == DOWN) {
      key = KEY_DOWN;
    } else if (keyCode == LEFT) {
      key = KEY_LEFT;
    } else if (keyCode == RIGHT) {
      key = KEY_RIGHT;
    }
  }
  key = Character.toLowerCase(key);
  state.keyPress();
  try {
    @SuppressWarnings("unused")
      boolean temp = keys.get(key);
    keys.put(key, true);
  }
  catch (NullPointerException e) {
  }
  for (int i = 0; i < 9; ++i) {
    keyHistory[i] = keyHistory[i+1];
  }
  keyHistory[9] = key;
  if (Arrays.toString(keyHistory).equals("[u, u, d, d, l, r, l, r, b, a]")) {
    konami = !konami;
  }
}

void keyReleased() {
  if (key == CODED) {
    if (keyCode == UP) {
      key = KEY_UP;
    } else if (keyCode == DOWN) {
      key = KEY_DOWN;
    } else if (keyCode == LEFT) {
      key = KEY_LEFT;
    } else if (keyCode == RIGHT) {
      key = KEY_RIGHT;
    }
  }
  key = Character.toLowerCase(key);
  try {
    @SuppressWarnings("unused")
      boolean temp = keys.get(key);
    keys.put(key, false);
  }
  catch (NullPointerException e) {
  }
}

//void mousePressed() {
//  if (state instanceof Game) {
//    frameRate(3);
//  }
//}
//void mouseReleased() {
//  if (state instanceof Game) {
//    frameRate(60);
//  }
//}
