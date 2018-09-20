import java.util.Arrays;
Vector GRAVITY = new Vector(0, 0.25); // A global vector that applies to all objects.

final float SPEED_MAX = 5;
final float JUMP_NOR = -7;
final float JUMP_HI = -9;
final float FALL = 10;
final float ACCEL = 0.25;
final float FIRE_SPEEDX = 5, FIRE_SPEEDY = 2;

int screenX = 1, screenY = 1, abscreenX = 1, abscreenY = 1;

boolean pDead = false;

class Game extends State {
  Game() {
    super("Random Platformer");
  }
  void run() {
    // I don't want anything to move while the game is 'loading'.
    if (frameCount > LOADTIME) {
      // Run (in order): the player, all other entities, all pieces of geometry.
      // For example: the player moves forward, an entity knocks them backwards, a wall pushes them out.
      gf.player.run();
      for (MasterEntity me : gf.entity) {
        me.run();
      }
      for (MasterGeometry mg : gf.geometry) {
        mg.run();
      }
      // Kill off any dead entity, and remove any destroyed geometry.
      for (int i = gf.entity.size()-1; i > -1; --i) {
        if (gf.entity.get(i).dead) gf.entity.remove(i);
      }
      for (int i = gf.geometry.size()-1; i > -1; --i) {
        if (gf.geometry.get(i).dead) gf.geometry.remove(i);
      }
    } else if (frameCount == LOADTIME) {
      overworld.loop();
    }
    // Start drawing to the PGraphics canvas.
    pg.noStroke();
    // Translate the canvas, which is how I scroll the screen.
    pg.pushMatrix();
    pg.translate(int(constrain(120-gf.player.pos.x, (abscreenX-1)*-256, 0)), int(constrain(120-gf.player.pos.y, (abscreenY-1)*-256, 0)));
    // Draw the background, geometry and entities.
    if (konami) {
      pg.background(int(random(0, 2))*255, int(random(0, 2))*255, int(random(0, 2))*255);
    } else {
      pg.background(191, 255, 255);
    }
    for (MasterGeometry mg : gf.geometry) {
      mg.display();
    }
    for (MasterEntity me : gf.entity) {
      me.display();
    }
    gf.player.display();
    // Reset the translation, and draw the HUD.
    pg.popMatrix();
    //player.hpcur = player.hpmax;
    for (int i = 0; i*24 < gf.player.hpmax; ++i) {
      pg.image(hpBar[0], 8, 8+16*i);
    }
    pg.image(hpBar[0], 8, 8);
    int xPos = 24, yPos = 8;
    for (int i = 0; i < gf.player.hpcur; ++i) {
      pg.image(hpBar[1], xPos, yPos);
      xPos+=4;
      if (i%24==23) {
        xPos = 24;
        yPos+=16;
      }
    }
    for (int i = gf.player.hpcur; i < gf.player.hpmax; ++i) {
      pg.image(hpBar[2], xPos, yPos);
      xPos+=4;
      if (i%24==23) {
        xPos = 24;
        yPos+=16;
      }
    }
    pg.fill(0);
    pg.textAlign(RIGHT, BOTTOM);
    pg.text("Points: "+gf.points*100, 224, 24);
    pg.text("Coins: " +gf.coins, 224, 40);
    pg.text("FPS: "+round(frameRate), 224, 56);
    fade();
  }
  void keyPress() {
    if (key == DELETE) {
      gf.power[2] = !gf.power[2];
    }
    if (key == ENTER) {
      moonJump = !moonJump;
    }
    if (key == ' ') {
      playAudio(pauseFX);
      state = new Pause(state);
    }
  }
}
