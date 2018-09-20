import java.util.Arrays;
int[][] codes = {{65, 66, 39, 37, 39, 37, 40, 40, 38, 38}, 
                 {68, 76, 82, 79, 87, 79, 76, 76, 69, 72}};
int[] keyHi = new int[10];
HashMap<Character, Boolean> keys = new HashMap<Character, Boolean>();
void initKeys() {
  keys.put('w', false);
  keys.put('a', false);
  keys.put('s', false);
  keys.put('d', false);
  for (int i = 0; i < 10; i++) {
    keyHi[i] = 0;
  }
}
void keyPressed() {
  for (int i = 9; i > 0; i--) {
    keyHi[i] = keyHi[i-1];
  }
  keyHi[0] = keyCode;
  if (frameCount > 10 && key == ' ') {
    keys = new HashMap<Character, Boolean>();
    frameCount = -60;
  }
  char keyLower = Character.toLowerCase(key);
  try {
    boolean temp = keys.get(keyLower);
    keys.put(keyLower, true);
  }
  catch (NullPointerException e) {
  }
  if (Arrays.equals(keyHi, codes[0])) {
    konami = true;
  } else if (Arrays.equals(keyHi, codes[1])) {
    exit();
  }
}
void keyReleased() {
  char keyLower = Character.toLowerCase(key);
  try {
    boolean temp = keys.get(keyLower);
    keys.put(keyLower, false);
  }
  catch (NullPointerException e) {
  }
}
void mousePressed() {
  frameRate(3);
}
void mouseReleased() {
  frameRate(60);
}