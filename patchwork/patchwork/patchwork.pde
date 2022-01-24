/* patchwork */

final float IMGW = 1150;
final float IMGH = 800;
final int IMGNUM = 5;

int start, end;

void setup() {
  size(100, 100);
  hideWindow();
  parseArgs(new String[]{"100", "124"});//debug
  //parseArgs(args);
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
  float r, expw, exph, d;

  for ( int i = start; i <= end; i++ ) {
    // load image
    img = loadImage(String.format("%03d.png", i));
    /// TODO start
    // put image
    //if ( img.width == IMGW && img.height == IMGH ) {
    //  image(img, w, h, IMGW, IMGH);
    //} else if ( img.width >= img.height ) {
    //  r = IMGH / img.height;
    //  expw = r * img.width;
    //  d = ( img.width >= IMGW )? 0 : (IMGW-expw)/2;
    //  image(img, w+d, h, expw, IMGH);
    //} else {
    //  r = IMGW / img.width;
    //  exph = r * img.height;
    //  //image(img, w, h+(IMGH-exph)/2, IMGW, exph);
    //  d = ( img.height >= IMGH )? 0 : (IMGH-exph)/2;
    //  image(img, w, h+d, IMGW, exph);
    //}
    if ( img.width == IMGW && img.height == IMGH ) {
      image(img, w, h, IMGW, IMGH);
    } else if ( img.width >= img.height ) {
      r = IMGW / img.width;
      exph = r * img.height;
      image(img, w, h, IMGW, exph);
    } else {
      r = IMGH / img.height;
      expw = r * img.width;
      image(img, w, h, expw, IMGH);
    }
    /// TODO end
    // next line
    if ( (w += IMGW) >= width ) {
      w = 0;
      h += IMGH;
    }
    // save & next patchwork
    if ( (i + 1) % sq(IMGNUM) == 0 ) {
      saveFrame("../patchwork_"+(imgidx++)+".png");
      h = 0;
      background(240);
    }
  }
  println("end");//debug
  exit();
}
