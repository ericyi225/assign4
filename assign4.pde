PImage fighterImg;
PImage hpImg;
PImage treasureImg;
PImage enemyImg;
PImage bg1Img;
PImage bg2Img;
PImage start1Img;
PImage start2Img;
PImage end1Img;
PImage end2Img;

//Other
int hp, B; 

//Treasure
int Treasure_x, Treasure_y;

//Fighter
int Fight_x,Fight_y;

//Enemy
int[] Enemy_x = new int[8];
int[] Enemy_y = new int[8];
boolean Enemy_is_crash[] = new boolean[8];
int restartEnemy;
int speed = 0;
boolean All_Enemy_Out;

//gamestate
final int GAME_START=1, GAME_RUN=2, GAME_FINISH=3,E1=1,E2=2,E3=3;
int gameState;
int enemyState;

//buttom
boolean upPressed = false;
boolean downPressed = false;
boolean leftPressed = false;
boolean rightPressed = false;

void setup () {
  size(640,480);
  //Image
  fighterImg=loadImage("img/fighter.png");
  hpImg=loadImage("img/hp.png");
  treasureImg=loadImage("img/treasure.png");
  enemyImg=loadImage("img/enemy.png");
  bg1Img=loadImage("img/bg1.png");
  bg2Img=loadImage("img/bg2.png");
  start1Img=loadImage("img/start1.png");
  start2Img=loadImage("img/start2.png");
  end1Img=loadImage("img/end1.png");
  end2Img=loadImage("img/end2.png");
  
  hp=40;
  B=0;
  //Treasure
  Treasure_x=floor(random(20,550));
  Treasure_y=floor(random(30,460));

  //Enemy
  restartEnemy = floor(random(60, 400));
  for(int i = 0; i < 8; i++){
    Enemy_x[i] = 0;
  }
  for(int i = 0; i < 8; i++){
    Enemy_y[i] = restartEnemy;
  }
  for(int i = 0; i < 8; i++){
    Enemy_is_crash[i] = false;
  }
  All_Enemy_Out = false;

  //Fighter
  Fight_x=580;
  Fight_y=240;
  gameState = GAME_START;
  enemyState=1;
}

void draw() 
{
  switch(gameState)
  {  

  case GAME_START:  
    image(start2Img,0,0);
    if(mouseX>202.3 && mouseX<457.1 && mouseY>373 && mouseY<415){
      if(mousePressed){
        gameState = GAME_RUN;
      }
      else{
        image(start1Img,0,0);
      }
    }
    break;
  
  case GAME_RUN:
    //Boundary Set
    image(bg1Img,B,0);
    image(bg2Img,B-640,0);
    image(bg1Img,B-1280,0);
    image(fighterImg,Fight_x,Fight_y);
    rect(20,10,hp,20);
    fill(255,0,0);
    image(treasureImg,Treasure_x,Treasure_y);
    image(hpImg,10,10);
  
    //Back ground move  
    B++;
    B%=1280;

    if (upPressed) {
      Fight_y -= 5;
      if(Fight_y<0){
      Fight_y=0;
      }
    }
    if (downPressed) {
      Fight_y += 5;
      if(Fight_y>430){
      Fight_y=430;
      }
    }
    if (leftPressed) {
      Fight_x -= 5;
      if(Fight_x<0){
      Fight_x=0;
      }
    }
    if (rightPressed) {
      Fight_x += 5;
      if(Fight_x>590){
      Fight_x=590;
      }
    }
   
     //treasure + hp
    if(Fight_x<Treasure_x+41 && Fight_x>=Treasure_x-41 && Fight_y<=Treasure_y+41 && Fight_y>=Treasure_y-41)
    {
      Treasure_x=floor(random(20,550));
      Treasure_y=floor(random(30,430));
      hp+=20;
    }
    if(hp>=195)
    {
      hp=195;
    }
    
    switch(enemyState)
     {
      
      case E1:
      for(int i = 0; i < 5; i++)
      {
         speed++;
        if( Enemy_is_crash[i] != true)
        {
         
          Enemy_x[i] = (-enemyImg.width)*i + speed;
          image(enemyImg, Enemy_x[i], restartEnemy);
        }
      }
      if( (speed - 240)>width )
      {
        speed = 0;
        restartEnemy = floor(random(60, height - 400));
        enemyState = E2;
        
        for(int i = 0; i < 5; i++)
        {
          Enemy_y[i] = restartEnemy;
          Enemy_is_crash[i] = false;
        }
      }
      break;
        
      case E2:  
      for(int i = 0; i < 5; i++)
      {
        speed++;
        if( Enemy_is_crash[i] != true)
        {
          Enemy_x[i] = (-enemyImg.width)*i + speed;
          Enemy_y[i] = restartEnemy + (enemyImg.height)*i;
          image(enemyImg,Enemy_x[i],Enemy_y[i]);
        }
      }
      if((speed - 240)>width)
      {
        speed = 0;
        restartEnemy = floor(random(180, height - 200));
        enemyState = E3;
        
        for(int i = 0; i < 5; i++)
        {
          Enemy_y[i] = restartEnemy;
          Enemy_is_crash[i] = false;
        }
      }
      break;
     
      case E3:
      for(int i = 0; i < 8; i++)
      {
        if(i < 5)
        {
          speed++;
          if( Enemy_is_crash[i] != true)
          {
            Enemy_x[i] = (-60)*i + speed;
            if(i < 3)
            {
              Enemy_y[i] = restartEnemy - 40*i;
              image(enemyImg,Enemy_x[i],Enemy_y[i]);
            }
            else
            {
              Enemy_y[i] = restartEnemy - 40*(4-i);
              image(enemyImg,Enemy_x[i],Enemy_y[i]);
            }
          }
         }
         else
         {
          if( Enemy_is_crash[i] != true)
          {
            Enemy_x[i] = (-60)*(8-i) + speed;
            if(i < 7)
            {
              Enemy_y[i] = restartEnemy + 40*(i-4);
              image(enemyImg,Enemy_x[i],Enemy_y[i]);
            }
            else
            {
              Enemy_y[i] = restartEnemy + 40*(8-i);
              image(enemyImg,Enemy_x[i],Enemy_y[i]);
            }
          }
         }
      }
      if((speed - 240)>width)
      {
        
         speed = 0;
         restartEnemy = floor(random(60, 400));
         enemyState = E1;
         for(int i = 0; i < 8; i++)
         {
          Enemy_y[i] = restartEnemy;
          Enemy_is_crash[i] = false;
        }
      }
      break;      
    }
    
    //enemy-hp
    if(enemyState == E3)
    {
      for(int i = 0; i < 8; i++)
      {
        if(Fight_x<=Enemy_x[i]+50 && Fight_x>=Enemy_x[i]-50 && Fight_y<=Enemy_y[i]+50 && Fight_y>=Enemy_y[i]-50)
        {
          hp -= 40;
          Enemy_x[i] = width + 1;
          Enemy_y[i] = height + 1;
          Enemy_is_crash[i] = true;
        }
      }
    }
    else
    {
      for(int i = 0; i < 5; i++)
      {  
        if(Fight_x<=Enemy_x[i]+50 && Fight_x>=Enemy_x[i]-60.8 && Fight_y<=Enemy_y[i]+60.8 && Fight_y>=Enemy_y[i]-60.8)
        {
          hp -= 40;
          Enemy_x[i] = width + 1;
          Enemy_y[i] = height + 1;
          Enemy_is_crash[i] = true;
        }
      }
    }


    //Fighter's hp = 0
    if(hp <= 0)
    {
      gameState = GAME_FINISH;
    }

    break;
   
  case GAME_FINISH:
      
    image(end2Img,0,0);
    if(mouseX>202.3 && mouseX<440 && mouseY>300 && mouseY<355)
    {
      image(end1Img,0,0);
      if(mousePressed)
      {
        speed = 0;
        hp=40;
        Treasure_x=floor(random(20,550));
        Treasure_y=floor(random(30,460));
        restartEnemy = floor(random(60,400));
        for(int i = 0; i < 8; i++){
          Enemy_x[i] = 0;
        }
        for(int i = 0; i < 8; i++){
          Enemy_y[i] = restartEnemy;
        }
        for(int i = 0; i < 8; i++){
          Enemy_is_crash[i] = false;
        }
        B=0;
        Fight_x=580;
        Fight_y=240;
        enemyState = E1;
        gameState = GAME_RUN;
        break;
      }
    }
  }
}

void keyPressed() 
{
  if (key == CODED) { // detect special keys 
    switch (keyCode) {
      case UP:
        upPressed = true;
        break;
      case DOWN:
        downPressed = true;
        break;
      case LEFT:
        leftPressed = true;
        break;
      case RIGHT:
        rightPressed = true;
        break;
    }
  }
}
  void keyReleased() {
  if (key == CODED) {
    switch (keyCode) {
      case UP:
        upPressed = false;
        break;
      case DOWN:
        downPressed = false;
        break;
      case LEFT:
        leftPressed = false;
        break;
      case RIGHT:
        rightPressed = false;
        break;
    }
  }
}
