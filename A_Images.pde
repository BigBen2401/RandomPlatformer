PImage IMGcoin[][] = new PImage[2][3], 
  IMGcursor[] = new PImage[2], 
  IMGenemy[] = new PImage[2], 
  IMGfire[] = new PImage[2], 
  IMGhealth[][] = new PImage[3][2], 
  IMGitem[] = new PImage[11], 
  IMGmario[][] = new PImage[2][7], 
  IMGtank, 
  IMGtile[][] = new PImage[6][4];

void loadImages() {
  for (int i = 0; i < 3; ++i) {
    IMGcoin[0][i] = loadImage("IMG/CoinL"+i+".png");
    IMGcoin[1][i] = loadImage("IMG/CoinS"+i+".png");
  }
  for (int i = 0; i < 2; ++i) {
    IMGcursor[i] = loadImage("IMG/Cursor"+i+".png");
  }
  for (int i = 0; i < 2; ++i) {
    IMGenemy[i] = loadImage("IMG/Goomba"+i+".png");
  }
  for (int i = 0; i < 2; ++i) {
    IMGfire[i] = loadImage("IMG/Fire"+i+".png");
  }
  for (int i = 0; i < 2; ++i) {
    IMGhealth[0][i] = loadImage("IMG/HealthB"+i+".png");
    IMGhealth[1][i] = loadImage("IMG/HealthL"+i+".png");
    IMGhealth[2][i] = loadImage("IMG/HealthR"+i+".png");
  }
  for (int i = 0; i < 11; ++i) {
    IMGitem[i] = loadImage("IMG/Item"+i+".png");
  }
  for (int i = 0; i < 7; ++i) {
    IMGmario[0][i] = loadImage("IMG/MarioL"+i+".png");
    IMGmario[1][i] = loadImage("IMG/MarioR"+i+".png");
  }
  IMGtank = loadImage("IMG/Tank.png");
  for (int i = 0; i < 6; ++i) {
    for (int j = 0; j < 4; ++j) {
      IMGtile[i][j] = loadImage("IMG/Tile"+char(i+'A')+j+".png");
    }
  }
}
