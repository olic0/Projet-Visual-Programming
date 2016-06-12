PImage convolute(PImage img) {
  float[][] kernel = { { 0, 0, 0 },
                       { 0, 2, 0 },
                       { 0, 0, 0 }};
                       
   float[][] kernel2 = { { 0, 1, 0 },
                       { 1, 0, 1 },
                       { 0, 1, 0 }};
                      
  PImage result = createImage(img.width, img.height, ALPHA);
  float weight = 2.f;
  int n = 3;
  for(int i = 1; i < img.height -1; i++){
      for(int j = 1; j< img.width -1; j++){
        int value = 0;
        for(int k = 0; k < n; k++){
          for(int l = 0; l < n; l++){
            value += brightness((int) (img.pixels[(i - n/2 +k)* img.width + (j - n/2 +l)]* kernel[k][l]));
          }
        }
        result.pixels[i*img.width + j] = color((value/weight));
      }
    }
  return result;
}

PImage gaussian(PImage img) {
   float[][] gaussianKernel = { { 9, 12, 9 },
                       { 12, 15, 12 },
                       { 9, 12, 9 }};
                       
                      
  PImage result = createImage(img.width, img.height, ALPHA);
  float weight = 50.f;
  int n = 3;
  for(int i = n/2; i < img.height - n/2; i++){
      for(int j = n/2; j< img.width - n/2; j++){
        int value = 0;
        for(int k = 0; k < n; k++){
          for(int l = 0; l < n; l++){
            value += brightness((int) (img.pixels[(i - n/2 +k)* img.width + (j - n/2 +l)]* gaussianKernel[k][l]));
          }
        }
        result.pixels[i*img.width + j] = color((int)(value/weight));
      }
    }
  return result;
}


PImage sobel(PImage img) {
  float[][] hKernel = { { 0, 1, 0 },
  { 0, 0, 0 },
  { 0, -1, 0 } };
  float[][] vKernel = { { 0, 0, 0 },
  { 1, 0, -1 },
  { 0, 0, 0 } };
  PImage result = createImage(img.width, img.height, ALPHA);
  // clear the image
  for (int i = 0; i < img.width * img.height; i++) {
  result.pixels[i] = color(0);
  }
  float max=0;
  float[] buffer = new float[img.width * img.height];

  int n = 3;
  for(int i = n/2; i < img.height - n/2; i++){
      for(int j = n/2; j< img.width - n/2; j++){
        int sum_h = 0;
        int sum_v = 0;
        for(int k = 0; k < n; k++){
          for(int l = 0; l < n; l++){
            sum_h += brightness((int) (img.pixels[(i - n/2 +k)* img.width + (j - n/2 +l)]))* hKernel[k][l];
            sum_v += brightness((int) (img.pixels[(i - n/2 +k)* img.width + (j - n/2 +l)])) * vKernel[k][l];
          }
        }
        float sum = sqrt(pow(sum_h, 2) + pow(sum_v, 2));
        buffer[i * img.width + j] = sum;
        max = Math.max(max, sum);
      }
    }
  
for (int y = 2; y < img.height - 2; y++) { // Skip top and bottom edges
  for (int x = 2; x < img.width - 2; x++) { // Skip left and right
    if (buffer[y * img.width + x] > (int)(max * 0.3f)) { // 30% of the max
      result.pixels[y * img.width + x] = color(255);
    } else {
      result.pixels[y * img.width + x] = color(0);
  }
}
}
return result;
}