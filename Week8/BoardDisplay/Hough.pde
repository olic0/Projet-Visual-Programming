void hough(PImage edgeImg) {
  float discretizationStepsPhi = 0.06f;
  float discretizationStepsR = 2.5f;
  
  // dimensions of the accumulator
  int phiDim = (int) (Math.PI / discretizationStepsPhi);
  int rDim = (int) (((edgeImg.width + edgeImg.height) * 2 + 1) / discretizationStepsR);
  int[] accumulator = new int[(phiDim + 2) * (rDim + 2)];
  
  // Fill the accumulator: on edge points (ie, white pixels of the edge
  // image), store all possible (r, phi) pairs describing lines going
  // through the point.
  for (int y = 0; y < edgeImg.height; y++) {
    for (int x = 0; x < edgeImg.width; x++) {
      // Are we on an edge?
      if (brightness(edgeImg.pixels[y * edgeImg.width + x]) != 0) {
        for(int phi = 0; phi <= phiDim; phi++){
           int r = (int) ((x * cos(phi) + y * sin(phi)) / discretizationStepsR);
           r += (rDim - 1) * 0.5f;
           accumulator[phi * rDim + r] += 1;
        }
      }
    }
  }
  
 


  
  for (int idx = 0; idx < accumulator.length; idx++)
    if (accumulator[idx] > 200) {
      int accPhi = (int) (idx / (rDim + 2)) - 1;
      int accR = idx - (accPhi + 1) * (rDim + 2) - 1;
      float r = (accR - (rDim - 1) * 0.5f) * discretizationStepsR;
      float phi = accPhi * discretizationStepsPhi;
      
      int x0 = 0, y0 = (int) (r / sin(phi));
      int x1 = (int) (r / cos(phi)), y1 = 0;
      int x2 = edgeImg.width, y2 = (int) (-cos(phi) / sin(phi) * x2 + r / sin(phi));
      int y3 = edgeImg.width, x3 = (int) (-(y3 - r / sin(phi)) * (sin(phi) / cos(phi)));
  
      stroke(204,102,0);
      if (y0 > 0) {
        if (x1 > 0)
          line(x0, y0, x1, y1);
        else if (y2 > 0)
          line(x0, y0, x2, y2);
        else
          line(x0, y0, x3, y3);
      } else {
        if (x1 > 0) {
          if (y2 > 0)
            line(x1, y1, x2, y2);
          else
            line(x1, y1, x3, y3);
        } else
            line(x2, y2, x3, y3);
        }
      }
}