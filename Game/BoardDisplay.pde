import processing.video.*;
import java.util.*;

class ImageProcessing extends PApplet {
  Movie cam;
  boolean pause = false;

  public void mouseClicked() {
    if (!pause) {
      pause = true;
      cam.pause();
    } else {
      pause = false;
      cam.play();
    }
  }

  PImage img, result;
  int w = 640, h = 480;
  List<PVector> corners;
  PVector angle;

  void settings() {
    size(w, h);
  }

  void setup() {
    cam = new Movie(this, "testvideo.mp4");
    cam.loop();
    angle = new PVector(0, 0, 1);
  }

  public void stop() {
    cam.stop();
    cam = null;
    super.stop();
    System.exit(0);
  }

  void draw() {
    if (cam.available()) {
      cam.read();
      img = cam.get();
      if (img == null) {
        return;
      }
    } else {
      return;
    }

    result = saturationMap(brightnessMap(hueMap(img, 96, 140), 38, 137), 116, 255);
    result = convolute(result);
    result = brightnessMap(result, 0, 153);
    result = sobel(result);
    List<PVector> lines = hough(result, 4);
    
    QuadGraph quadGraph = new QuadGraph();
    quadGraph.build(lines, img.width, img.height);

    displayQuads(lines);
    corners = getIntersections(lines);
    TwoDThreeD converter = new TwoDThreeD(width, height);
    PVector end = converter.get3DRotations(corners);
    println("Value rx: "+ end.x +" Value ry: "+end.y+" Value rz: "+end.z); 

    // }

  }
}