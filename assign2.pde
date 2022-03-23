PImage bgImg, soilImg, lifeImg, cabbageImg, soldierImg, gameoverImg, titleImg;
PImage ghdowImg, ghImg, ghlImg, ghrImg, restartyImg, restartwImg, startyImg, startwImg;

final int GAME_START = 0;
final int GAME_RUN = 1;
final int GAME_OVER = 2;
      int gameState = GAME_START;
      int soldierLocationX,soldierX;
      int soldierLocationY,soldierY;   
      int soldierSpeed;
      int cabbageLocationX,cabbageX;
      int cabbageLocationY,cabbageY;
      float groundhogX,groundhogY; 
      int life_Size=50+20;      
      int lifeX1 = 10;
      int lifeX2 = 10+life_Size;
      int lifeX3 = 10+life_Size*2;
      int lifeY1,lifeY2,lifeY3;
      int downCounter,leftCounter,rightCounter;
      boolean noLife;
      boolean downPressed,rightPressed,leftPressed;
      
void setup() {
	size(640, 480, P2D);
	bgImg=loadImage("img/bg.jpg");
  soilImg=loadImage("img/soil.png");
  lifeImg=loadImage("img/life.png");
  cabbageImg=loadImage("img/cabbage.png");
  soldierImg=loadImage("img/soldier.png");
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
  
  soldierLocationY=floor(random(2,6));
  soldierY=soldierLocationY*80;
  soldierX=-80;
  cabbageLocationX=floor(random(2,8));
  cabbageX=cabbageLocationX*80;
  cabbageLocationY=floor(random(2,6));
  cabbageY=cabbageLocationY*80;
  groundhogX=320;
  groundhogY=80;
  lifeY1=10;
  lifeY2=10;
  lifeY3=-80;
  noLife=false;
}

void draw() {
   switch(gameState) {
     case GAME_START:
     image(titleImg,0,0);
	    if(mouseX>248 && mouseX<248+144 && mouseY>360 && mouseY<360+60){
        image(startyImg,248,360);
      if(mousePressed){
       gameState = GAME_RUN;
     } 
}
      else{
       image(startwImg,248,360);}
   break;
   
    case GAME_RUN: 
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
    image(soldierImg,soldierX,soldierY);
    soldierSpeed=4;
    soldierX +=soldierSpeed;
    image(soldierImg,soldierX,soldierY);      
      if(soldierX>=width){
      image(soldierImg,soldierX,soldierY);
      soldierX=-80;
      soldierSpeed=4;
      soldierX+=soldierSpeed;
      soldierX%=640;}///soldier   
    image(cabbageImg,cabbageX,cabbageY);///cabbage
     if(groundhogX<0 ) {
        groundhogX=0;}
     if(groundhogX>width-80){
        groundhogX=560;          
          }
     if(groundhogY>height-80){
        groundhogY=400;          
          }//groundhog      
    image(lifeImg,lifeX1,lifeY1);
    image(lifeImg,lifeX2,lifeY2);
    image(lifeImg,lifeX3,lifeY3);//life
    //if the hog touches the cabbage
      if(groundhogX < cabbageX+80 && groundhogX+80 > cabbageX && 
         groundhogY < cabbageY+80 && groundhogY+80 > cabbageY){
         if (lifeY2==10) {
          lifeY3=10;
          cabbageX=-80;
          cabbageY=-80;//2~3
        }else{
          lifeY2=10;
          cabbageX=-80;
          cabbageY=-80;}//1~2
   }
   //if the hog touches the soldier
      if(groundhogX < soldierX+80 && groundhogX+80 > soldierX && 
         groundhogY < soldierY+80 && groundhogY+80 > soldierY &&
         lifeY1==10 && lifeY2==10 && lifeY3==10){
          groundhogX=320;
          groundhogY=80;
          lifeY3=-80;}//3~2
      if(groundhogX < soldierX+80 && groundhogX+80 > soldierX && 
         groundhogY < soldierY+80 && groundhogY+80 > soldierY &&
         lifeY1==10 && lifeY2==10 && lifeY3==-80){
         groundhogX=320;
         groundhogY=80;
         lifeY2=-80;
         lifeY3=-80;}//2~1 
      if(groundhogX < soldierX+80 && groundhogX+80 > soldierX && 
         groundhogY < soldierY+80 && groundhogY+80 > soldierY &&
         lifeY1==10 && lifeY2==-80 && lifeY3==-80){
         groundhogX=320;
         groundhogY=80;
         lifeY2=10;
         lifeY3=-80;
         cabbageLocationX=floor(random(2,8));
         cabbageX=cabbageLocationX*80;
         cabbageLocationY=floor(random(2,6));
         cabbageY=cabbageLocationY*80;
         image(cabbageImg,cabbageX,cabbageY);
         soldierLocationY=floor(random(2,6));
         soldierY=soldierLocationY*80;
         image(soldierImg,soldierX,soldierY);
         gameState=GAME_OVER;
         }//1~0 
      //move      
     if(downCounter==0 && leftCounter==0 && rightCounter==0 ){
       //pose
       image(ghImg,groundhogX,groundhogY);
      if(downPressed){
        downCounter=15;
      }
  
      else if(leftPressed){
        leftCounter=15;
        }
        
      else if(rightPressed){
        rightCounter=15;
        }
     }
     
     if(downCounter>0){
        groundhogY+=80.0/15;
        downCounter-=1;//--1
        image(ghdowImg,round(groundhogX),round(groundhogY));
        
        }
     else if(leftCounter>0){
        groundhogX-=80.0/15;
        leftCounter-=1;
        image(ghlImg,round(groundhogX),round(groundhogY));
        println(downCounter);
        
        }
     else if(rightCounter>0){
        groundhogX+=80.0/15;
        rightCounter-=1;
        image(ghrImg,round(groundhogX),round(groundhogY));
       
        }  
   break; 
   
    case GAME_OVER:
    image(gameoverImg,0,0);
    if(mouseX>248 && mouseX<248+144 && mouseY>360 && mouseY<360+60){
      image(restartyImg,248,360);
      if(mousePressed){
       gameState = GAME_RUN;
     }
    }     else{
      image(restartwImg,248,360);}
    break;
   }  
}

//groundhog move
void keyPressed(){
  if(key==CODED){
    switch(keyCode){
      case DOWN:
        downPressed=true;       
        break;
        
      case LEFT:
        leftPressed=true;
        break;
        
      case RIGHT:
        rightPressed=true;
        break;       
    }
  }  
}

void keyReleased(){
    if(key==CODED){
    switch(keyCode){
      case DOWN:
        downPressed=false;
        break;
        
      case LEFT:
        leftPressed=false;       
        break;
        
      case RIGHT:
        rightPressed=false;
        break;       
    }
  }  
}
