// I use the Minim library for music and sound effects.
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;
Minim minim;

// I draw the game at a constant size, and then upscale it.
PGraphics pg;
int SCALE = 16;

// Because I upscale the game, I have to downscale the mouse position.
Vector mouse = new Vector(0, 0);
// Which cursor image to use.
boolean mouseHover = false;

// This is called at the very start of the program.
void settings() {
  size(256, 256);
  noSmooth();
}

// This is called whenever frameCount is 0, so I avoid manually checking it.
void setup() {
  // This only occurs on the first call to setup.
  if (keys.size() == 0) {
    // Set up the window.
    surface.setResizable(true);
    surface.setTitle("RANDOM PLATFORMER");
    frameRate(60);
    pg = createGraphics(256, 256);
    // Set up the keys and load the assets.
    setKeys();
    minim = new Minim(this);
    loadMusic(10);
    loadSounds();
    loadImages();
    // Start the title screen.
    state = new Title();
  }
  // This occurs on every other call to setup.
  else {
    // Start the game, when going from the title screen.
    if (!(state instanceof Game)) {
      state = new Game();
    }
    // Load the next level.
    gameFile.loadLevel();
  }
}

// This is called every frame.
void draw() {
  // Reset the cursor image.
  mouseHover = false;
  // Downscale the mouse position.
  mouse.x = int(map(mouseX, 0, width, 0, 256));
  mouse.y = int(map(mouseY, 0, height, 0, 256));
  // Run the current state.
  state.run();
  // Set the cursor image.
  try {
    cursor(IMGcursor[mouseHover?1:0]);
  } 
  catch (NullPointerException e) {
    cursor(mouseHover?HAND:ARROW);
  }

  // Draw the current screen.
  pg.beginDraw();
  state.display();
  pg.endDraw();
  // Upscale the screen.
  image(pg, 0, 0, width, height);
}

// If the player quits during the game, save their progress.
void exit() {
  if (gameFile != null) gameFile.saveFile();
  super.exit();
}
