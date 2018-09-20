AudioPlayer BGMlevel[] = new AudioPlayer[11], 
  BGMtitle;
AudioPlayer BGMcurrent = null; // A reference to the currently playing music.

void loadMusic(float gain) {
  for (int i = 0; i < 11; ++i) {
    BGMlevel[i] = minim.loadFile("BGM/Level"+i+".mp3");
    if (BGMlevel[i] != null) BGMlevel[i].setGain(-gain);
  }
  BGMtitle = minim.loadFile("BGM/Title.mp3");
  if (BGMtitle != null) BGMtitle.setGain(-gain*2); // Reduce the tracks to a sensible volume.
}

// Stop the current music track, and play the new one.
void playMusic(AudioPlayer fx) {
  if (BGMcurrent != fx) {
    if (BGMcurrent != null) {
      BGMcurrent.pause();
      BGMcurrent.rewind();
    }
    BGMcurrent = fx;
    if (BGMcurrent != null) BGMcurrent.loop();
  }
}
