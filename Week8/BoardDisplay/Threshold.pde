PImage binary(PImage image, float threshold){
  
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

PImage hueImage(PImage image, float scroll1, float scroll2){
  PImage result = createImage(width, height, RGB);
  
  for(int i = 0; i < image.width * image.height; i++) {
    if(hue(img.pixels[i]) < 255*scroll1 || hue(img.pixels[i]) > 255*scroll2){
      result.pixels[i] = color(0);
    } else {
      result.pixels[i] = color(hue(image.pixels[i]));
    }
  }
  return result;
}