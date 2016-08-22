
//import java.lang.*;
import peasy.*;
 
PeasyCam cam;
 
int worldX = 30;
int worldY = 30;
int gen = 1;
int genNumber = 600;

float angle = 0;
double d = 180;

int[][][] data = new int[worldX][worldY][genNumber];

int intRule=250;

String ruleset = "";

int iteracoes=1;

PFont font; 

String typedRule="";
 
void setup(){
  //size(1920,1080,P3D);
  size(1280,720,P3D);
  //fullScreen(P3D);
  background(0);
  smooth(8);
  noStroke();
  colorMode(HSB);
  ruleset = Integer.toBinaryString(intRule);
  
  //normalize string: 10 bits
  while (ruleset.length() < 10) {
   ruleset = "0" + ruleset;
  }
  
  //normalize string: 19 bits
  //while (ruleset.length() < 19) {
  // ruleset = "0" + ruleset;
  //}
  
 for(int k = 0; k < gen; k++)
 for(int i = 0; i < worldX; i++){
  for(int j = 0; j < worldY; j++){
    float r = random(1);
    //if(i==j && i%5==0)
    //data[i][j][k] = 1;
    if(r<0.09)
     data[i][j][k] = 1;
     else data[i][j][k] = 0;
  }
 }
   
  //data[worldX/2][worldY/2][0] = 1;

  frameRate(14);
  
  cam = new PeasyCam(this,300);
  cam.setMinimumDistance(50);
  cam.setMaximumDistance(1800);
  //cam.setDistance(d);    
  //cam.rotateX(PI/4);
  //cam.rotateZ(PI/6);
  //cam.rotateX(PI/2);
}
 
void draw(){
  background(0);
  directionalLight(0,0,255,1,0,-1);
  directionalLight(0,0,255,1,1,0);
  
  //cam.rotateX(angle);
  //cam.rotateZ(angle); 
  //cam.setDistance(d);   
  //rotateY(frameCount*PI/200);
  //rotateZ(frameCount*PI/200);
  //rotateZ(angle/4);
  //rotateX(angle/4);
  //rotateY(angle/4);
  
  //rule8(gen);
  rule(gen);
  
  translate(0,0,-200);
  
  for(int k = 0; k <gen; k++){ 
    for(int i = -worldX/2; i < worldX/2-1; i++){
      for(int j = -worldY/2; j < worldY/2-1; j++){
        
        int x = i*5;
        int y = j*5;
        int z = k*5;
        
        if(data[i+worldX/2][j+worldY/2][k] == 1 && data[i+worldX/2][j+worldY/2+1][k] == 1){
          //noStroke();
          //fill(155,155,175,155);
          //noFill();
          //stroke(255,255,255,50);  
          noFill();
          stroke(155,k,204,100);  
          pushMatrix();
          translate(x,y,z);      
          box(4);
          //noFill();
          //stroke(255,255,255,40);
          //box(10);
          popMatrix();
        }
        
        
       
        else if(data[i+worldX/2][j+worldY/2][k] == 1 && data[i+worldX/2][j+worldY/2+1][k] == 0){
        //noStroke();
        //fill(155,155,175,155); 
        //noFill();
        //ambient(50,100,165);   
        noStroke();
        fill(155,k,204,155); 
        pushMatrix();
        translate(x,y,z);      
        box(4);
        //noFill();
        //stroke(255,255,255,40);
        //box(10);
        popMatrix();
        }  
        
        else noFill();
       }
     }
   }
   
  gen++;
  
  if(gen==600){
    intRule++;
    gen=1;
    changeRule();
    }    
    
  angle+=PI/300;

 //saveFrame("images/CA-####.png"); 
 //d+=0.5;
}
 
 
void rule(int g) {  
  for(int k = 0; k < g; k++){
    for(int i = 0; i < worldX-1; i++){
      for(int j = 0; j < worldY-1; j++){
             
        int totalNeighbors = neighbors(i,j,k);
              
        if(data[i][j][k] == 0 && totalNeighbors == 0){
          data[i][j][k+1] = ruleset.charAt(9)-48;
        }
        else if(data[i][j][k] == 1 && totalNeighbors == 0 ){
          data[i][j][k+1] = ruleset.charAt(8)-48;
        }
        else if(data[i][j][k] == 0 && totalNeighbors == 1){
          data[i][j][k+1] = ruleset.charAt(7)-48;
        }
        else if(data[i][j][k] == 1 && totalNeighbors == 1 ){
          data[i][j][k+1] = ruleset.charAt(6)-48;
        }
       else if(data[i][j][k] == 0 && totalNeighbors == 2){
          data[i][j][k+1] = ruleset.charAt(5)-48;
        }
        else if(data[i][j][k] == 1 && totalNeighbors ==2 ){
          data[i][j][k+1] = ruleset.charAt(4)-48;
        }
        else if(data[i][j][k] == 0 && totalNeighbors ==3){
          data[i][j][k+1] = ruleset.charAt(3)-48;
        }
        else if(data[i][j][k] == 1 && totalNeighbors == 3 ){
          data[i][j][k+1] = ruleset.charAt(2)-48;
        }
        else if(data[i][j][k] == 0 && totalNeighbors == 4){
          data[i][j][k+1] = ruleset.charAt(1)-48;
        }
        else if(data[i][j][k] == 1 && totalNeighbors == 4 ){
          data[i][j][k+1] = ruleset.charAt(0)-48;
        }
  
      }    
     }  
   }
 
  
}
 
void rule8(int g) {
  for(int k = 0; k < g; k++){
    for(int i = 0; i < worldX-1; i++){
      for(int j = 0; j < worldY-1; j++){
             
        int totalNeighbors = neighbors8(i,j,k);
              
        if(data[i][j][k] == 0 && totalNeighbors == 0){
          data[i][j][k+1] = ruleset.charAt(17)-48;
        }
        else if(data[i][j][k] == 1 && totalNeighbors == 0 ){
          data[i][j][k+1] = ruleset.charAt(16)-48;
        }
        else if(data[i][j][k] == 0 && totalNeighbors == 1){
          data[i][j][k+1] = ruleset.charAt(15)-48;
        }
        else if(data[i][j][k] == 1 && totalNeighbors == 1 ){
          data[i][j][k+1] = ruleset.charAt(14)-48;
        }
       else if(data[i][j][k] == 0 && totalNeighbors == 2){
          data[i][j][k+1] = ruleset.charAt(13)-48;
        }
        else if(data[i][j][k] == 1 && totalNeighbors ==2 ){
          data[i][j][k+1] = ruleset.charAt(12)-48;
        }
        else if(data[i][j][k] == 0 && totalNeighbors ==3){
          data[i][j][k+1] = ruleset.charAt(11)-48;
        }
        else if(data[i][j][k] == 1 && totalNeighbors == 3 ){
          data[i][j][k+1] = ruleset.charAt(10)-48;
        }
        else if(data[i][j][k] == 0 && totalNeighbors == 4){
          data[i][j][k+1] = ruleset.charAt(9)-48;
        }
        else if(data[i][j][k] == 1 && totalNeighbors == 4 ){
          data[i][j][k+1] = ruleset.charAt(8)-48;
        }
        else if(data[i][j][k] == 1 && totalNeighbors == 5 ){
          data[i][j][k+1] = ruleset.charAt(7)-48;
        }
        else if(data[i][j][k] == 0 && totalNeighbors == 5){
          data[i][j][k+1] = ruleset.charAt(6)-48;
        }
        else if(data[i][j][k] == 1 && totalNeighbors == 6 ){
          data[i][j][k+1] = ruleset.charAt(5)-48;
        }
        else if(data[i][j][k] == 0 && totalNeighbors == 6){
          data[i][j][k+1] = ruleset.charAt(4)-48;
        }
        else if(data[i][j][k] == 1 && totalNeighbors == 7 ){
          data[i][j][k+1] = ruleset.charAt(3)-48;
        }
        else if(data[i][j][k] == 1 && totalNeighbors == 7 ){
          data[i][j][k+1] = ruleset.charAt(2)-48;
        }
        else if(data[i][j][k] == 1 && totalNeighbors == 8 ){
          data[i][j][k+1] = ruleset.charAt(1)-48;
        }
        else if(data[i][j][k] == 1 && totalNeighbors == 8 ){
          data[i][j][k+1] = ruleset.charAt(0)-48;
        }
      }    
     }  
   }
  
  
}
  
 
int neighbors(int i, int j, int k) {
  int result = 0;

  if(j > 0 && data[i][j-1][k] == 1){
    result = result + 1;
  }
  if(i > 0 && data[i-1][j][k] == 1){
    result = result + 1;
  }
  if(i < worldX -1 && data[i+1][j][k] == 1){
    result = result + 1;
  }
  if(j < worldY -1 && data[i][j+1][k] == 1){
    result = result + 1;
  }
  return result;
 
}

int neighbors8(int i, int j, int k) {
  int result = 0;

  if(j > 0 && data[i][j-1][k] == 1){
    result = result + 1;
  }
  if(i > 0 && data[i-1][j][k] == 1){
    result = result + 1;
  }
  if(i < worldX - 1 && data[i+1][j][k] == 1){
    result = result + 1;
  }
  if(j < worldY - 1 && data[i][j+1][k] == 1){
    result = result + 1;
  }
  
  if(i>0 && j>0 && data[i-1][j-1][k] == 1){
    result = result + 1;
  }
  if(i < worldX - 1 && j < worldY - 1 && data[i+1][j+1][k] == 1){
    result = result + 1;
  }
  if(i > 0 && j < worldY - 1 && data[i-1][j+1][k] == 1){
    result = result + 1;
  }
  if(i < worldX - 1 && j >0 && data[i+1][j-1][k] == 1){
    result = result + 1;
  }
  return result;
 
}

//void mousePressed()
//{
//  gen=0;
//  intRule++;
//changeRule();

//}
  
void changeRule() {
  background(0);
  gen = 1;
  ruleset = Integer.toBinaryString(intRule);
  
  //normalize string: 19 bits
  //while (ruleset.length() < 19) {
  // ruleset = "0" + ruleset;
  //}
  //iteracoes=1;
  
  //normalize string: 10 bits
  while (ruleset.length() < 10) {
   ruleset = "0" + ruleset;
  }
  
//empty array
for(int k = 0; k < gen; k++)
for(int i = 0; i < worldX; i++){
  for(int j = 0; j < worldY; j++){
    float r = random(1);
   // if(i==j && i%5==0)
    //data[i][j][k] = 1;
    if(r<0.1)
    data[i][j][k] = 1;
    else data[i][j][k] = 0;
  }
}
  
  //for(int i = 0; i < worldX; i+=10){
  //    data[i][worldY/2] = 1;
  //}
  
  //data[15][15][0]=1; 
  //data[worldX/2][worldY/2][0] = 1;
 
  }
  
void keyPressed(){
  
  if(key == CODED)
  {
 
    switch(keyCode)
    {
      case LEFT: intRule--;changeRule(); break;
      case RIGHT: intRule++;changeRule(); break;
      case DOWN: intRule-=10;changeRule(); break;
      case UP: intRule+=10;changeRule(); break;
      
    }
    println(intRule);
  }
  else
  {

    if (key >='1' || key <='9') typedRule=typedRule+ key;
     
    if (key == 10) // Enter
    {
       int rule=Integer.parseInt(typedRule.trim());
      if (rule < 10024)
      {
       intRule=rule;
       changeRule();
      }
     typedRule="";
    }
  }
}