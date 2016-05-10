PImage binar(PImage image, float threshold){
  
  PImage result = createImage(image.width, image.height, RGB);
  
  for(int i = 0; i < image.width * image.height; i++) {
    if(brightness(image.pixels[i]) > threshold){
      result.pixels[i] = color(255);
    } else {
      result.pixels[i] = color(0);
    }
  }
  return result;
}

PImage invertedBinary(PImage image, float threshold){
  
  PImage result = createImage(image.width, image.height, RGB);
  
  for(int i = 0; i < image.width * image.height; i++) {
    if(brightness(image.pixels[i]) <= threshold){
      result.pixels[i] = color(255);
    } else {
      result.pixels[i] = color(0);
    }
  }
  return result;
}

PImage hueImage(PImage image, float min, float max){
  PImage result = createImage(width, height, RGB);
  
  for(int i = 0; i < image.width * image.height; i++) {
    if(hue(img.pixels[i]) < 255*min || hue(img.pixels[i]) > 255*max){
      result.pixels[i] = color(0);
    } else {
      result.pixels[i] = color(image.pixels[i]);
    }
  }
  return result;
}

PImage brightnessMap(PImage image, float min, float max){
  PImage result = createImage(width, height, RGB);
  
  for(int i = 0; i < image.width * image.height; i++) {
    if(brightness(img.pixels[i]) < 255*min || brightness(img.pixels[i]) > 255*max){
      result.pixels[i] = color(0);
    } else {
      result.pixels[i] = color(image.pixels[i]);
    }
  }
  return result;
}

PImage saturationMap(PImage image, float min, float max){
  PImage result = createImage(width, height, RGB);
  
  for(int i = 0; i < image.width * image.height; i++) {
    if(saturation(img.pixels[i]) < 255*min || saturation(img.pixels[i]) > 255*max){
      result.pixels[i] = color(0);
    } else {
      result.pixels[i] = color(image.pixels[i]);
    }
  }
  return result;
}