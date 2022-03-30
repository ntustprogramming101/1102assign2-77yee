PImage bg, gh, ghRight, ghLeft, ghDown, life1, life2, life3,
  soil, soldier, cabbage, title, gameOver, startNormal,
  startHovered, restartNormal, restartHovered;

float sdX=0, sdY=0, sdW=80 ;

final int GAME_START = 0;
final int GAME_RUN = 1;
final int GAME_OVER = 2;
final int GAME_WIN = 3;
int gameState = GAME_START;

final int BUTTON_TOP = 360;
final int BUTTON_BOTTOM = 420;
final int BUTTON_LEFT = 248;
final int BUTTON_RIGHT = 392;


float ghX, ghY, ghRightX, ghRightY, ghLeftX, ghLeftY, ghDownX, ghDownY;
float ghSpeed = 80;
float ghW = 80;

final int life_Size=50+20;
      int lifeX1 = 10;
      int lifeX2 = 10+life_Size;
      int lifeX3 = 10+life_Size*2;
      int lifeY1,lifeY2,lifeY3;

final int cabbageW=80;
float cabbageX, cabbageY;


int Time;
final int GH_IDLE = 0;
final int GH_LEFT = 1;
final int GH_RIGHT = 2;
final int GH_UP = 3;
final int GH_DOWN = 4;
int ghState = GH_IDLE;


boolean upPressed = false;
boolean downPressed = false;
boolean rightPressed = false;
boolean leftPressed = false;


void setup() {
  size(640, 480, P2D);
  bg=loadImage("img/bg.jpg");
  gh=loadImage("img/groundhogIdle.png");
  ghLeft=loadImage("img/groundhogLeft.png");
  ghRight=loadImage("img/groundhogRight.png");
  ghDown=loadImage("img/groundhogDown.png");
  life1=loadImage("img/life.png");
  life2=loadImage("img/life.png");
  life3=loadImage("img/life.png");
  soil=loadImage("img/soil.png");
  soldier=loadImage("img/soldier.png");
  cabbage=loadImage("img/cabbage.png");
  title=loadImage("img/title.jpg");
  gameOver=loadImage("img/gameover.jpg");
  startNormal=loadImage("img/startNormal.png");
  startHovered=loadImage("img/startHovered.png");
  restartNormal=loadImage("img/restartNormal.png");
  restartHovered=loadImage("img/restartHovered.png");

  //soldier
  sdY = floor(random(2, 6))*80;

  //cabbage
  cabbageX = floor(random(1, 8))*80;
  cabbageY = floor(random(2, 6))*80;
  
  //groundhog
  ghX = width / 2 ;
  ghY = 80;
  
  //life
  lifeY1=10;
  lifeY2=10;
  lifeY3=-80;
}

void draw() {
  frameRate=60;
  switch(gameState) {
  case GAME_START:
    image(title, 0, 0);
    image(startNormal, 248, 360);
    if (mouseX > BUTTON_LEFT && mouseX < BUTTON_RIGHT
      && mouseY > BUTTON_TOP && mouseY < BUTTON_BOTTOM) {
      image(startHovered, 248, 360);
      if (mousePressed) {
        gameState = GAME_RUN;
      }
    }
    break;

  case GAME_RUN:
    //BackgroundAndSoil
    image(bg, 0, 0);
    image(soil, 0, 160);
    //grass
    stroke(124, 204, 25);
    strokeWeight(15);
    line(0, 153, 640, 153);
    //life
    image(life1, lifeX1, lifeY1);
    image(life2, lifeX2, lifeY2);
    image(life3, lifeX3, lifeY3);
    //Sun
    stroke(255, 255, 0);
    strokeWeight(5);
    fill(253, 184, 19);
    ellipse(590, 50, 125,125);
    //cabbage
    image(cabbage, cabbageX, cabbageY);

    //soldier
    image(soldier, sdX, sdY);
    sdX +=3; //soldierSpeed
    if (sdX>=640) {
      sdX=-40;
    }
//if the hog touches the cabbage
      if(ghX < cabbageX+79 && ghX+79 > cabbageX && 
         ghY < cabbageY+79 && ghY+79 > cabbageY){
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
      if(ghX < sdX+79 && ghX+79 > sdX && 
         ghY < sdY+79 && ghY+79 > sdY &&
         lifeY1==10 && lifeY2==10 && lifeY3==10){
          ghX=320;
          ghY=80;
          lifeY3=-80;}//3~2
      if(ghX < sdX+79 && ghX+79 > sdX && 
         ghY < sdY+79 && ghY+79 > sdY &&
         lifeY1==10 && lifeY2==10 && lifeY3==-80){
         ghX=320;
         ghY=80;
         lifeY2=-80;
         lifeY3=-80;}//2~1 
      if(ghX < sdX+79 && ghX+79 > sdX && 
         ghY < sdY+79 && ghY+79 > sdY &&
         lifeY1==10 && lifeY2==-80 && lifeY3==-80){
         ghX=320;
         ghY=80;
         lifeY2=10;
         lifeY3=-80;

        sdY = floor(random(2, 6))*80;
        cabbageX = floor(random(1, 8))*80;
        cabbageY = floor(random(2, 6))*80;
         gameState=GAME_OVER;
         }//1~0     
    
/*    //Play
    if (ghX<sdX+sdW && ghX+ghW>sdX && ghY+ghW>sdY+.3 && ghY<sdY+sdW-.3) {
        ghState=GH_IDLE;
        Time=0;
        ghX = width / 2.0 ;
        ghY = 80;
      I++;
    }
    if (ghX<cabbageX+cabbageW && ghX+ghW>cabbageX
      && ghY+ghW>cabbageY+.3 && ghY<cabbageY+cabbageW-.3
      && I<=2 && I>=0) {
      cabbageX=-100;
      cabbageY=-100;
      I--;
    }
    if (ghX < sdX+80 && ghX+80 > sdX && 
        ghY < sdY+80 && ghY+80 > sdY && I==0) {
      gameState = GAME_OVER;
    }
*/
    //groundhog move
    if (Time<15) {
      Time++;
      switch(ghState) {
      case GH_LEFT:
        ghX-=ghSpeed/15.0;
        break;
      case GH_RIGHT:
        ghX+=ghSpeed/15.0;
        break;
      case GH_DOWN:
        ghY+=ghSpeed/15.0;
        break;
      case GH_UP:
        ghY-=ghSpeed/15.0;
        break;
      }
    } else {
      ghState=GH_IDLE;
    }

    switch(ghState) {
    case GH_IDLE:
      image(gh, ghX, ghY);
      break;
    case GH_LEFT:
      image(ghLeft, ghX, ghY);
      break;
    case GH_RIGHT:
      image(ghRight, ghX, ghY);
      break;
    case GH_UP:
      image(ghDown, ghX, ghY);
      break;
    case GH_DOWN:
      image(ghDown, ghX, ghY);
      break;
    }


    //Groundhog_limit
    if (ghX+ghW>=width) {
      ghX=width-ghW;
    }
    if (ghX<=0) {
      ghX=0;
    }
    if (ghY+ghW>=height) {
      ghY=height-ghW;
    }
    if (ghY<=80) {
      ghY=80;
    }
    break;

  case GAME_OVER:
    image(gameOver, 0, 0);
    if (mouseX > BUTTON_LEFT && mouseX < BUTTON_RIGHT
      && mouseY > BUTTON_TOP && mouseY < BUTTON_BOTTOM) {
      image(restartHovered, 248, 360);
      if (mousePressed) {
      //groundhog
        ghState=GH_IDLE;
        Time=0;
        ghX = width / 2 ;
        ghY = 80;
      //soldier
        sdX=-40;
        sdY = floor(random(2, 6))*80;
      //cabbage
        cabbageX = floor(random(1, 7))*80;
        cabbageY = floor(random(2, 6))*80;
      //life and state
        gameState = GAME_RUN;
      }
    } else {
      image(restartNormal, 248, 360);
    }
    break;
  }
}

void keyPressed() {
  if (ghState == GH_IDLE ) {
    Time=0;
    switch(keyCode) {
    case UP:
      ghState=GH_UP;
      break;
    case DOWN:
      ghState=GH_DOWN;
      break;
    case RIGHT:
      ghState=GH_RIGHT;
      break;
    case LEFT:
      ghState=GH_LEFT;
      break;
    }
  }
}

void keyReleased() {
  if (key == CODED ) {
    switch(keyCode) {
    case UP:
      upPressed = false;
      break;
    case DOWN:
      downPressed = false ;
      break;
    case RIGHT:
      rightPressed = false ;
      break;
    case LEFT:
      leftPressed = false ;
      break;
    }
  }
}
