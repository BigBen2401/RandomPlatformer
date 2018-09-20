// I use a HashMap (equivalent of a dictionary) to store the keys.
HashMap<Character, Boolean> keys = new HashMap<Character, Boolean>();

// The player can bind keys, so I store them as variables.
char KEY_UP = 'w', KEY_LEFT = 'a', KEY_DOWN = 's', KEY_RIGHT = 'd', 
  KEY_INTERACT = 'q', KEY_ATTACK = 'e';

// When the controls change, reset the HashMap.
void setKeys() {
  keys = new HashMap<Character, Boolean>();
  keys.put(KEY_UP, false);
  keys.put(KEY_LEFT, false);
  keys.put(KEY_DOWN, false);
  keys.put(KEY_RIGHT, false);
  keys.put(KEY_INTERACT, false);
  keys.put(KEY_ATTACK, false);
}

// When keyboard events occur, update the HashMap.
void keyPressed() {
  key = Character.toLowerCase(key);
  // If the key has been bound, update the HashMap.
  if (keys.containsKey(key)) keys.put(key, true);
  // Pass key presses (not releases) to the state-specific function.
  if (frameCount > 15) state.keyPress();
  // Catch the escape key before Processing can.
  if (key == DELETE) save(frameCount+".png");
  if (key == ESC) key = ' ';
}
void keyReleased() {
  key = Character.toLowerCase(key);
  // If the key has been bound, update the HashMap.
  if (keys.containsKey(key)) keys.put(key, false);
}

void mouseReleased() {
  // Pass mouse releases (not presses) to the state-specific function.
  if (frameCount > 15) state.mouseRelease();
}
