import processing.video.*;
import java.util.*;
Capture cam;

PImage img, houghImg, result;
int w = 800, h = 600;
HScrollbar thresholdBarHue1, thresholdBarHue2, thresholdBarBright1, thresholdBarBright2, 
            thresholdBarSatur1, thresholdBarSatur2;
List<PVector> corners;

void settings() {
  size(w, h);
}

void setup() {
  thresholdBarHue1 = new HScrollbar(0, h - 50, w/4, 20);
  thresholdBarHue2 = new HScrollbar(0, h - 20, w/4, 20);
  thresholdBarBright1 = new HScrollbar(w/4 + w/8, h - 50, w/4, 20);
  thresholdBarBright2 = new HScrollbar(w/4 + w/8, h - 20, w/4, 20);
  thresholdBarSatur1 = new HScrollbar(w/2 + w/4, h - 50, w/4, 20);
  thresholdBarSatur2 = new HScrollbar(w/2 + w/4, h - 20, w/4, 20);
  img = loadImage("board1.jpg");
  result = createImage(img.width, img.height, RGB);
  noLoop();
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
  /*float i = thresholdBarHue1.getPos();
  float j = thresholdBarHue2.getPos();
  float k = thresholdBarBright1.getPos();
  float l = thresholdBarBright2.getPos();
  float m = thresholdBarSatur1.getPos();
  float n = thresholdBarSatur2.getPos();
  System.out.println("hue : "+ i +" "+ j +" bright : "+ k +"  " + l +" satur : "+ m +"  "+n);*/
  
 //if (cam.available() == true) {
   // cam.read();
  
  //img = cam.get();

  result = saturationMap(brightnessMap(hueMap(img, 96, 140), 38, 137), 116, 255);
  result = convolute(result);
  result = brightnessMap(result, 0, 153);
  result = sobel(result);
  List<PVector> lines = hough(result, 4);

  image(img, 0, 0);
  //image(houghImg, img.width, 0);
  //image(result, img.width + 400, 0);
 
  displayQuads(lines);
  corners = getIntersections(lines);
  TwoDThreeD converter = new TwoDThreeD(width, height);
  PVector end = converter.get3DRotations(corners);
  println("Value rx: "+ degrees(end.x) +" Value ry: "+degrees(end.y)+" Value rz: "+degrees(end.z)); 
  
 // }

   /*thresholdBarHue1.display();
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
   thresholdBarSatur2.update();*/
}