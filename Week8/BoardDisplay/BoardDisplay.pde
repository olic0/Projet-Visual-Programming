PImage img, result;
HScrollbar thresholdBar1, thresholdBar2;

void settings() {
size(800, 600);
}

void setup() {
thresholdBar2 = new HScrollbar(0, 580, 800, 20);
thresholdBar1 = new HScrollbar(0, 560, 800, 20);
img = loadImage("board1.jpg");
//noLoop(); 
}

void draw() {
  background(color(0,0,0));
  //binar = binary(img, 255*thresholdBar1.getPos());
  //float i = thresholdBar1.getPos();
  //float j = thresholdBar2.getPos();
  result = hueImage(img, 0.465, 0.525);
  
  image(sobel(convolute(binary(result, 15))), 0, 0);
  hough(sobel(convolute(binary(result, 15))));


  /*thresholdBar1.display();
  thresholdBar2.display();
  thresholdBar1.update();
  thresholdBar2.update();*/
}