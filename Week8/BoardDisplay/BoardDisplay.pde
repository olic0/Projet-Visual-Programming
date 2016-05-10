import processing.video.*;
import java.util.*;
Capture cam;

PImage img, result;
HScrollbar thresholdBarHue1, thresholdBarHue2, thresholdBarBright1, thresholdBarBright2, 
            thresholdBarSatur1, thresholdBarSatur2;

void settings() {
  size(800, 600);
}

void setup() {
  thresholdBarHue1 = new HScrollbar(0, 550, 200, 20);
  thresholdBarHue2 = new HScrollbar(0, 580, 200, 20);
  thresholdBarBright1 = new HScrollbar(300, 550, 200, 20);
  thresholdBarBright2 = new HScrollbar(300, 580, 200, 20);
  thresholdBarSatur1 = new HScrollbar(600, 550, 200, 20);
  thresholdBarSatur2 = new HScrollbar(600, 580, 200, 20);
  img = loadImage("board3.jpg");
  //noLoop(); 
  /*String[] cameras = Capture.list();
  if (cameras.length == 0) {
    println("There are no cameras available for capture.");
    exit();
  } else {
    println("Available cameras:");
    for (int i = 0; i < cameras.length; i++) {
      println(cameras[i]);
    }
    cam = new Capture(this, cameras[0]);
    cam.start();
  }*/
}

void draw() {
  //background(color(0, 0, 0));
  //binar = binary(img, 255*thresholdBar1.getPos());
  float i = thresholdBarHue1.getPos();
  float j = thresholdBarHue2.getPos();
  float k = thresholdBarBright1.getPos();
  float l = thresholdBarBright2.getPos();
  float m = thresholdBarSatur1.getPos();
  float n = thresholdBarSatur2.getPos();
  
  //if (cam.available() == true) {
    //cam.read();
  
  //img = cam.get();

  result = saturationMap(brightnessMap(hueImage(img, i, j), k, l), m, n);

  image(result, 0, 0);
  result = sobel(gaussian(binar(result, 15)));
  ArrayList<PVector> lines = hough(result, 6);
  
  List<int[]> quads = filterQuads(lines);

  for (int[] quad : quads) {
    PVector l1 = lines.get(quad[0]);
    PVector l2 = lines.get(quad[1]);
    PVector l3 = lines.get(quad[2]);
    PVector l4 = lines.get(quad[3]);

    PVector c12 = getIntersection(l1, l2);
    PVector c23 = getIntersection(l2, l3);
    PVector c34 = getIntersection(l3, l4);
    PVector c41 = getIntersection(l4, l1);
    // Choose a random, semi-transparent colour
    Random random = new Random();
    fill(color(min(255, random.nextInt(300)), 
      min(255, random.nextInt(300)), 
      min(255, random.nextInt(300)), 50));
    quad(c12.x, c12.y, c23.x, c23.y, c34.x, c34.y, c41.x, c41.y);
  }
  
  //}

   thresholdBarHue1.display();
   thresholdBarHue2.display();
   thresholdBarHue1.update();
   thresholdBarHue2.update();
   
   thresholdBarBright1.display();
   thresholdBarBright2.display();
   thresholdBarBright1.update();
   thresholdBarBright2.update();
   
   thresholdBarSatur1.display();
   thresholdBarSatur2.display();
   thresholdBarSatur1.update();
   thresholdBarSatur2.update();
}