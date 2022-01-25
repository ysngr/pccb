/* patchwork */

final float IMGW = 1150;
final float IMGH = 800;
final int IMGNUM = 5;

int start, end;

void setup() {
  size(100, 100);
  hideWindow();
  parseArgs(args);
  resize(5750, 4000);
  background(240);
  noLoop();
}

void hideWindow() {
  surface.setLocation(10000, 10000);
  surface.setVisible(false);
}

void resize(int w, int h) {
  surface.setSize(w, h);
}

void parseArgs(String[] args) {
  assert args.length == 2;
  start = Integer.parseInt(args[0]);
  end = Integer.parseInt(args[1]);
  assert start >= 0 && end >= 0;
  assert start <= end;
}

void draw() {
  PImage img;
  float w = 0, h = 0;
  int imgidx = 0;
  float r, sr, sw, sh, d;

  for ( int i = start; i <= end; i++ ) {
    // load image
    img = loadImage(String.format("%03d.png", i));
    // put image
    r = float(img.width) / float(img.height);
    if ( r == IMGW / IMGH ) {
      image(img, w, h, IMGW, IMGH);
    } else if ( r > IMGW / IMGH ) {
      sr = IMGW / img.width;
      sh = sr * img.height;
      d = (IMGH - sh) / 2;
      image(img, w, h+d, IMGW, sh);
    } else {
      sr = IMGH / img.height;
      sw = sr * img.width;
      d = (IMGW - sw) / 2;
      image(img, w+d, h, sw, IMGH);
    }
    // next image
    if ( (w += IMGW) >= width ) {
      w = 0;
      h += IMGH;
    }
    // save & next patchwork
    if ( (i - start + 1) % sq(IMGNUM) == 0 ) {
      saveFrame("../patchwork_"+(imgidx++)+".png");
      h = 0;
      background(240);
    }
  }
  exit();
}
