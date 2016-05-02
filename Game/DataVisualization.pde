void drawBottomRect() {
  bottomRect.beginDraw();
  bottomRect.background(0, 100, 200);
  bottomRect.endDraw();
}

void drawTopView(){
  topView.beginDraw();
  topView.background(100);
  for(int i = 0; i < cylinders.size(); i++){
    topView.fill(250, 160, 25);
    topView.noStroke();
    float coordX = map(cylinders.get(i).x, width/2 - boxX/2, width/2 + boxX/2, 0, topViewSize);
    float coordY = map(cylinders.get(i).y, height/2 - boxZ/2, height/2 + boxZ/2, 0, topViewSize);
    topView.ellipse(coordX, coordY, Cylinder.cylinderBaseSize, Cylinder.cylinderBaseSize);
  }
  topView.fill(200, 0, 0);
  topView.noStroke();
  topView.ellipse(topViewSize/2 + ball.location.x * topViewSize/boxX,
                  topViewSize/2 + ball.location.y * topViewSize/boxZ, ball.r, ball.r);
  topView.endDraw();
}

void drawScoreBoard(){
  scoreBoard.beginDraw();
  scoreBoard.background(0, 100, 200);
  scoreBoard.stroke(255);
  pushMatrix();
  scoreBoard.noFill();
  scoreBoard.rect(0, 0, scoreBoardSize, scoreBoardSize);
  scoreBoard.text("Total Score", 3, border + 10);
  scoreBoard.text(score, 3, border + 25);
  scoreBoard.text("Velocity", 3, border + 55);
  scoreBoard.text(ball.velocity.mag(), 3, border + 70);
  popMatrix();
  scoreBoard.endDraw();
}

void drawBarChart(){
 barChart.beginDraw();
 barChart.background(100, 0, 100);
 barChart.endDraw();
}