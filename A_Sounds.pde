AudioPlayer FXbutton[] = new AudioPlayer[2], 
  FXitem[] = new AudioPlayer[3], 
  FXmario[] = new AudioPlayer[3], 
  FXgoomba[] = new AudioPlayer[2], 
  FXwarp, FXdeath, FXpause, FXbreak;

void loadSounds() {
  for (int i = 0; i < 2; ++i) {
    FXbutton[i] = minim.loadFile("FX/Button"+i+".wav");
  }
  for (int i = 0; i < 3; ++i) {
    FXitem[i] = minim.loadFile("FX/Item"+i+".wav");
  }
  for (int i = 0; i < 3; ++i) {
    FXmario[i] = minim.loadFile("FX/Mario"+i+".wav");
  }
  for (int i = 0; i < 2; ++i) {
    FXgoomba[i] = minim.loadFile("FX/Goomba"+i+".wav");
  }
  FXwarp = minim.loadFile("FX/Warp.wav");
  FXdeath = minim.loadFile("FX/Death.wav");
  FXpause = minim.loadFile("FX/Pause.wav");
  FXbreak = minim.loadFile("FX/Break.wav");
}

// Play a sound effect from the beginning.
void playSound(AudioPlayer fx) {
  if (fx != null) {
    fx.rewind();
    fx.play();
  }
}
