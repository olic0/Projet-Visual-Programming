void settings() {
size(500,500,P2D);
}
void setup () {
}
void draw() {
background(255, 255, 255);
My3DPoint eye = new My3DPoint(0, 0, -5000);
My3DPoint origin = new My3DPoint(0, 0, 0);
My3DBox input3DBox = new My3DBox(origin, 100, 150, 300);
//rotated around x
float[][] transform1 = rotateXMatrix(PI/8);
input3DBox = transformBox(input3DBox, transform1);
projectBox(eye, input3DBox).render();
//rotated and translated
float[][] transform2 = translationMatrix(200, 200, 0);
input3DBox = transformBox(input3DBox, transform2);
projectBox(eye, input3DBox).render();
//rotated, translated, and scaled
float[][] transform3 = scaleMatrix(2, 2, 2);
input3DBox = transformBox(input3DBox, transform3);
projectBox(eye, input3DBox).render();
}

class My2DPoint {
  float x;
  float y;
  My2DPoint(float x, float y) {
    this.x = x;
    this.y = y;
  }
}

class My3DPoint {
  float x;
  float y;
  float z;
  My3DPoint(float x, float y, float z) {
    this.x = x;
    this.y = y;
    this.z = z;
  }
}

class My2DBox{
  My2DPoint[] s;
  My2DBox(My2DPoint[] s){
    this.s = s;
  }
  void render(){
    line(s[0].x, s[0].y, s[1].x, s[1].y);
    line(s[0].x, s[0].y, s[3].x, s[3].y);
    line(s[0].x, s[0].y, s[4].x, s[4].y);
    line(s[1].x, s[1].y, s[2].x, s[2].y);
    line(s[1].x, s[1].y, s[5].x, s[5].y);
    line(s[2].x, s[2].y, s[3].x, s[3].y);
    line(s[2].x, s[2].y, s[6].x, s[6].y);
    line(s[3].x, s[3].y, s[7].x, s[7].y);
    line(s[4].x, s[4].y, s[5].x, s[5].y);
    line(s[4].x, s[4].y, s[7].x, s[7].y);
    line(s[5].x, s[5].y, s[6].x, s[6].y);
    line(s[6].x, s[6].y, s[7].x, s[7].y);
  }
}

class My3DBox {
  My3DPoint[] p;
  My3DBox(My3DPoint origin, float dimX, float dimY, float dimZ){
    float x = origin.x;
    float y = origin.y;
    float z = origin.z;
    this.p = new My3DPoint[]{new My3DPoint(x,y+dimY,z+dimZ),
              new My3DPoint(x,y,z+dimZ),
              new My3DPoint(x+dimX,y,z+dimZ),
              new My3DPoint(x+dimX,y+dimY,z+dimZ),
              new My3DPoint(x,y+dimY,z),
              origin,
              new My3DPoint(x+dimX,y,z),
              new My3DPoint(x+dimX,y+dimY,z)
              };
  }
  My3DBox(My3DPoint[] p) {
    this.p = p;
  }
}


My2DPoint projectPoint(My3DPoint eye, My3DPoint p) {
    float[][] T = {{1, 0, 0, -eye.x},
                   {0, 1, 0, -eye.y},
                   {0, 0, 1, -eye.z},
                   {0, 0, 0, 1}};
    float[][] P = {{1, 0, 0, 0},
                   {0, 1, 0, 0},
                   {0, 0, 1, 0},
                   {0, 0, -1.0/(eye.z), 0}};
                   
    float[] vect = {p.x, p.y, p.z, 1};
    float[] result = multiplyMwithV(multiplyMatrix(P, T), vect);
   return new My2DPoint(result[0]/result[3], result[1]/result[3]);
  }
  
float[][] multiplyMatrix(float[][] A, float[][] B){
  float[][] C = new float[A.length][B[0].length];
  for(int i = 0; i < A.length; i++){
   for(int j = 0; j < B[0].length; j++){
     C[i][j] = 0;
   }
  }
  for(int i = 0; i < A.length; i++){
    for(int j = 0; j < B[0].length; j++){
      for(int k = 0; k < A.length; k++){
        C[i][j] += A[i][k]*B[k][j];
        System.out.println(C[i][j]);
      }
    }
  }
  return C;
}

float[] multiplyMwithV(float[][] M, float[] V){
  float[] result = new float[V.length];
  for(int i = 0; i < M.length; i++){
    float sum = 0;
   for(int j = 0; j < M[0].length; j++){
    sum += M[i][j] * V[j]; 
   }
   result[i] = sum;
  }
  return result;
}

My2DBox projectBox (My3DPoint eye, My3DBox box){
  My3DPoint[] points = box.p;
  My2DPoint[] result = new My2DPoint[points.length];
  for(int i = 0; i < points.length; i++){
    result[i] = projectPoint(eye, points[i]);
  }
  return new My2DBox(result);
}

float[] homogeneous3DPoint (My3DPoint p) {
float[] result = {p.x, p.y, p.z , 1};
return result;
}

float[][] rotateXMatrix(float angle) {
  return(new float[][] {{1, 0 , 0 , 0},
                        {0, cos(angle), sin(angle) , 0},
                        {0, -sin(angle) , cos(angle) , 0},
                        {0, 0 , 0 , 1}});
}

float[][] rotateYMatrix(float angle) {
// Complete the code!
  return(new float[][] {{cos(angle), 0 , sin(angle) , 0},
                        {0, 1, 0, 0},
                        {-sin(angle), 0, cos(angle) , 0},
                        {0, 0 , 0 , 1}});
}

float[][] rotateZMatrix(float angle) {
// Complete the code!
  return(new float[][] {{cos(angle), -sin(angle) , 0 , 0},
                        {sin(angle), cos(angle), 0, 0},
                        {0, 0, 1, 0},
                        {0, 0 , 0 , 1}});
}

float[][] scaleMatrix(float x, float y, float z) {
// Complete the code!
  return(new float[][] {{x, 0 , 0 , 0},
                        {0, y, 0, 0},
                        {0, 0, z, 0},
                        {0, 0 , 0 , 1}});
}

float[][] translationMatrix(float x, float y, float z) {
// Complete the code!
  return(new float[][] {{1, 0 , 0 , x},
                        {0, 1, 0, y},
                        {0, 0, 1, z},
                        {0, 0 , 0 , 1}});
}

My3DBox transformBox(My3DBox box, float[][] transformMatrix) {
//Complete the code! You need to use the euclidian3DPoint() function given below.
  My3DPoint[] points = box.p;
  My3DPoint[] newPoints = new My3DPoint[points.length];
  for(int i = 0; i < points.length; i++){
    float[] point = {points[i].x, points[i].y, points[i].z, 1};
    newPoints[i] = euclidian3DPoint(multiplyMwithV(transformMatrix, point));
  }
  return new My3DBox(newPoints);
}

My3DPoint euclidian3DPoint (float[] a) {
My3DPoint result = new My3DPoint(a[0]/a[3], a[1]/a[3], a[2]/a[3]);
return result;
}