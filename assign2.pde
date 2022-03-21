PImage bgImg, soilImg, lifeImg, cabbageImg, soldierImg, gameoverImg, titleImg;
PImage ghdowImg, ghImg, ghlImg, ghrImg, restartyImg, restartwImg, startyImg, startwImg;

void setup() {
	size(640, 480, P2D);
	bgImg=loadImage("img/bg.jpg");
  soilImg=loadImage("img/soil.png");
  lifeImg=loadImage("img/life.png");
  cabbageImg=loadImage("img/cabbage.png");
  gameoverImg=loadImage("img/gameover.jpg");
  titleImg=loadImage("img/title.jpg");
  
  ghdowImg=loadImage("img/groundhogDown.png");
  ghImg=loadImage("img/groundhogIdle.png");
  ghlImg=loadImage("img/groundhogLeft.png");
  ghrImg=loadImage("img/groundhogRight.png");
  restartyImg=loadImage("img/restartHovered.png");
  restartwImg=loadImage("img/restartNormal.png");
  startyImg=loadImage("img/startHovered.png");
  startwImg=loadImage("img/startNormal.png");
  //Red Line
  int x = 0 ;
  int y = 160 ;
  stroke ( 260,0,0 ) ;

  while ( x < width ){
  line ( x, y, x, height ) ;
  x += 80 ;
  }///X
  while ( y >= 160 ){
  line ( x, y, width, y ) ;
  x += 80 ;
  }///Y
}

void draw() {
  //Background
   image(bgImg,0,0);///Sky
   fill(124,204,25);
   noStroke();
   rect(0,145,640,15);///Grassland
   image(soilImg,0,160);///Soil
   fill(253,184,19);
   strokeWeight(5);
   stroke(255,255,0);
   ellipse(590,50,120,120); ///sun
	// Game Start
  if(mouseX>248 && mouseX<248+144 && mouseY>360 && mouseY<360+60){
     image(startyImg,0,0);}
  else{
     image(startwImg,0,0);}
  // Game Run

  // Game Lose
  if(mouseX>248 && mouseX<248+144 && mouseY>360 && mouseY<360+60){
     image(restartyImg,0,0);}
  else{
     image(restartwImg,0,0);}
}

void keyPressed(){
}

void keyReleased(){
}
