int tvx, tvy;
int animx, animy;
int deck1x, deck1y;
int deck2x, deck2y;

boolean deck1Playing = false;
boolean deck2Playing = false;
float rotateDeck1 = 0;
float rotateDeck2 = 0;
float currentFrame = 0;
float ratio;
int margin = width/40;
PImage [] images;
PImage [] recordPlayer;
PImage TV;
Maxim maxim;
AudioPlayer player1;
AudioPlayer player2;
float speedAdjust=1.0;


void setup() {
  size(768,1024);
  imageMode(CENTER);
  images = loadImages("Animation_data/movie", ".jpg", 134);
  recordPlayer = loadImages("black-record_", ".png", 36);
  TV = loadImage("TV.png");
  maxim = new Maxim(this);
  player1 = maxim.loadFile("beat1.wav");
  player1.setLooping(true);
  player2 = maxim.loadFile("beat2.wav");
  player2.setLooping(true);
  background(30);
}

void draw() {
  background(30); 
  imageMode(CENTER);
  //cube();
  image(images[(int)currentFrame], width/2, images[0].height/2+margin, images[0].width, images[0].height);
  image(TV, width/2, TV.height/2+margin, TV.width, TV.height);
  deck1x = (width/2)-recordPlayer[0].width/2-(margin*10);
  deck1y = TV.height+recordPlayer[0].height/2+margin;
  image(recordPlayer[(int) rotateDeck1], deck1x, deck1y, recordPlayer[0].width, recordPlayer[0].height);
  deck2x = (width/2)+recordPlayer[0].width/2+(margin*10);
  deck2y = TV.height+recordPlayer[0].height/2+margin;
  image(recordPlayer[(int) rotateDeck2], deck2x, deck2y, recordPlayer[0].width, recordPlayer[0].height);
  
  if (mouseY > height / 2) {
    ratio = (float) mouseX / (float) width;
    ratio *= 2;
  }
   //control the color for the below part (speed)
   
   fill(ratio * 200);
   //rect(0, height / 2, width, height / 2);

  if (deck1Playing || deck2Playing) {
    
    player1.speed(speedAdjust);
    player2.speed((player2.getLengthMs()/player1.getLengthMs())*speedAdjust);
    currentFrame= currentFrame+1*speedAdjust;
  }

  if (currentFrame >= images.length) {

    currentFrame = 0;
  }

  if (deck1Playing) {

    rotateDeck1 += 1*speedAdjust;

    if (rotateDeck1 >= recordPlayer.length) {

      rotateDeck1 = 0;
    }
  }

  if (deck2Playing) {

    rotateDeck2 += 1*speedAdjust;

    if (rotateDeck2 >= recordPlayer.length) {

      rotateDeck2 = 0;
    }
  }
}


void mousePressed() {

  if(dist(mouseX, mouseY, deck1x, deck1y) < recordPlayer[0].width/2){
    
    deck1Playing = !deck1Playing;
  }

  if (deck1Playing) {
    player1.play();
  } else {

    player1.stop();
  }

  if(dist(mouseX, mouseY, deck2x, deck2y) < recordPlayer[0].width/2){
  
    deck2Playing = !deck2Playing;
  }

  if (deck2Playing) {
    player2.play();
  } else {
    player2.stop();
  }
}

void mouseDragged() {
  
  float red = map(mouseX, 0, width, 0, 255);
  float blue = map(mouseY, 0, width, 0, 255);
  float green = dist(mouseX,mouseY,width/2,height/2);
  
  float speed = dist(pmouseX, pmouseY, mouseX, mouseY);
  float alpha = map(speed, 0, 20, 0, 10);
  //println(alpha);
  float lineWidth = map(speed, 0, 10, 10, 1);
  lineWidth = constrain(lineWidth, 0, 10);
  noStroke();
  fill(0, alpha);
  rect(width/2, height/2, width, height);
  
  stroke(red, green, blue, 255);
  strokeWeight(lineWidth);
  
  //rect(mouseX, mouseY, speed, speed);
  line(pmouseX, pmouseY,mouseX, mouseY);
  brush1(mouseX, mouseY,speed, speed,lineWidth);
  brush2(mouseX, mouseY,speed, speed,lineWidth);
  brush3(mouseX, mouseY,speed, speed,lineWidth);
  brush4(pmouseX, pmouseY,mouseX, mouseY,lineWidth);

  brush5(pmouseX, pmouseY,mouseX, mouseY,lineWidth);
  brush6(mouseX, mouseY,speed, speed,lineWidth);
  brush7(pmouseX, pmouseY,mouseX, mouseY,lineWidth);
  
  if (mouseY > height/2) {  
    speedAdjust = map(mouseX, 0, width, 0, 2);
   
  } 
}

/*void mouseDragged() {
   
 if (mouseY>height/2) {
  
   speedAdjust=map(mouseX,0,width,0,2);
   
 } 
}*/

