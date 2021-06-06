snake s;
float scl = 20;
PVector food;
float[] tailx = new float[1];
float[] taily = new float[1];


void setup(){
 size(800,800);
 s = new snake(0,0,1,0,5);
 tailx[0]=0;
 taily[0]=0;
 frameRate(10);
 food=  pickLocation();
 
}
  
PVector pickLocation() {
  int cols = floor(width/scl);
  int rows = floor(height/scl);
  food = new PVector(floor(random(cols)), floor(random(rows)));
  food.mult(scl);
  return food;
}

void draw() {
  background(51);
  s.death();
  s.update();
  s.show();
  if(s.eat(food)){
    
  food=pickLocation();
  //print("Enter picklocation");
  };
  fill(255,0,100);
  rect(food.x,food.y,scl,scl);
  
}

void keyPressed() {
  if(keyCode == UP) {
    s.dir(0,-1);
  } else if (keyCode == DOWN) {
    s.dir(0,1);
  }else if (keyCode == RIGHT) {
    s.dir(1,0);
  }
  else if (keyCode == LEFT) {
    s.dir(-1,0);
  }
}

class snake {
 float x;
 float y;
 float xspeed;
 float yspeed;
 float total;


 
 
 
snake(color tempx, float tempy, float tempxspeed, float tempyspeed, float temptotal) {
   x = tempx;
   y = tempy;
   xspeed = tempxspeed;
   yspeed = tempyspeed;
   total = temptotal; 
 }
 
 void update() {
    
    if(total==tailx.length){
     for(int i= 0;i<tailx.length-1;i++){
       tailx[i]=tailx[i+1];
       taily[i]=taily[i+1];
     }
      tailx[int(total)-1]=x;
      
      taily[int(total)-1]=y;
   }
   
    if(total>tailx.length){
      tailx=append(tailx,x);
      taily=append(taily,y);
    
    }
   
     x = x + xspeed*scl;
     y = y + yspeed*scl;
     x=constrain(x,0,width-scl);
     y=constrain(y,0,height-scl);
    
  }
 void show() {
   fill(255);
   for(int i=0;i<tailx.length;i++){
   rect(tailx[i],taily[i],scl,scl);
   }
   rect(x,y,scl,scl);
   }
  void dir(float x,float y) {
   xspeed=x;
   yspeed=y;
  }
  boolean eat(PVector pos) {
   float d = dist(x,y,pos.x,pos.y);
   if(d<1){
     
     total++;
     return true;
   }else {
     return false;
   }
  }
  void death(){
for(int i=0;i<tailx.length;i++){
float posx = tailx[i];
float posy = taily[i];
float d = dist(x,y,posx,posy);
if(d<1){total=1;
    tailx=new float[1];
    taily=new float[1];
    background(51);
text("Game over",200,200);
}
}
}
}
