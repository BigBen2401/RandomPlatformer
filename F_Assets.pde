// I use the Minim library to play music and sound effects.
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;
Minim minim;
// Each sound effect and music track is stored in a different variable.
AudioPlayer coinFX, lifeFX, jumpFX, itemFX, warpFX, destroyFX, fireFX, killFX, hitFX, pauseFX, buttonFX, deathFX;
AudioPlayer overworld;
void loadAudio() {
  minim = new Minim(this);
  coinFX = minim.loadFile("data/audio/Coin.wav");
  lifeFX = minim.loadFile("data/audio/1up.wav");
  jumpFX = minim.loadFile("data/audio/Jump.wav");
  itemFX = minim.loadFile("data/audio/Powerup.wav");
  warpFX = minim.loadFile("data/audio/Warp.wav");
  destroyFX = minim.loadFile("data/audio/Break.wav");
  fireFX = minim.loadFile("data/audio/Fire Ball.wav");
  killFX = minim.loadFile("data/audio/Squish.wav");
  hitFX = minim.loadFile("data/audio/Thwomp.wav");
  pauseFX = minim.loadFile("data/audio/Pause.wav");
  buttonFX = minim.loadFile("data/audio/Beep.wav");
  deathFX = minim.loadFile("data/audio/Die.wav");

  overworld = minim.loadFile("data/audio/Overworld.mp3");
  overworld.setGain(-10);
}
void playAudio(AudioPlayer fx) {
  fx.rewind();
  fx.play();
}

// These images are loaded once, and apply to the whole game.
PImage basic[] = new PImage[2],
boots[] = new PImage[4], coin[] = new PImage[3], tank,
play[][] = new PImage[7][2], hpBar[] = new PImage[3], fire[] = new PImage[2],
cursor[] = new PImage[2];
void loadImages() {
  basic[0] = loadImage("data/global/EnemyBasic0.png");
  basic[1] = loadImage("data/global/EnemyBasic1.png");
  play[0][0] = loadImage("data/global/PlayerStillL.png");
  play[0][1] = loadImage("data/global/PlayerStillR.png");
  play[1][0] = loadImage("data/global/PlayerJumpL.png");
  play[1][1] = loadImage("data/global/PlayerJumpR.png");
  play[2][0] = loadImage("data/global/PlayerRunL1.png");
  play[2][1] = loadImage("data/global/PlayerRunR1.png");
  play[3][0] = loadImage("data/global/PlayerRunL2.png");
  play[3][1] = loadImage("data/global/PlayerRunR2.png");
  play[4][0] = loadImage("data/global/PlayerRunL3.png");
  play[4][1] = loadImage("data/global/PlayerRunR3.png");
  play[5][0] = loadImage("data/global/PlayerSlideL.png");
  play[5][1] = loadImage("data/global/PlayerSlideR.png");
  play[6][0] = loadImage("data/global/PlayerPoundL.png");
  play[6][1] = loadImage("data/global/PlayerPoundR.png");
  fire[0] = loadImage("data/global/FireL1.png");
  fire[1] = loadImage("data/global/FireR1.png");
  boots[0] = loadImage("data/global/HiJump.png");
  boots[1] = loadImage("data/global/GroundPound.png");
  boots[2] = loadImage("data/global/WallJump.png");
  boots[3] = loadImage("data/global/FireFlower.png");
  coin[0] = loadImage("data/global/Coin1.png");
  coin[1] = loadImage("data/global/Coin2.png");
  coin[2] = loadImage("data/global/Coin3.png");
  tank = loadImage("data/global/ETank.png");
  hpBar[0] = loadImage("data/global/HPstart.png");
  hpBar[1] = loadImage("data/global/HPon.png");
  hpBar[2] = loadImage("data/global/HPoff.png");
  cursor[0] = loadImage("data/Cursor0.png");
  cursor[1] = loadImage("data/Cursor1.png");
}
// These images are different for each level (different tilesets).
PImage normal, destroy, entrance;
void loadTiles(String area) {
  normal = loadImage("data/"+area+"/PlatformNormal.png");
  destroy = loadImage("data/"+area+"/PlatformDestroy.png");
  entrance = loadImage("data/"+area+"/Entrance.png");
}
