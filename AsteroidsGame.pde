//your variable declarations here
SpaceShip ship;
boolean up = false;
boolean down = false;
boolean left = false;
boolean right = false;
Star[] stars = new Star[300];
double dist1;
double dist2;
ArrayList <Asteroid> asteroids = new ArrayList <Asteroid>();
ArrayList <Bullet> bullets = new ArrayList <Bullet>();
boolean gameOver = false;
boolean check = true;
boolean win = false;
int lives = 3;
int score = 0;
int countDown = 0;

public void setup() 
{
  //your code here
  size(700, 700);
  ship = new SpaceShip();
  for (int i = 0; i < stars.length; i++) {
    stars[i] = new Star();
  }
  for (int i = 0; i < 20; i++) {
    asteroids.add(new Asteroid());
  }
}

public void draw() 
{
  //your code here
  background(0);
  noStroke();
  for (int i = 0; i < stars.length; i++) {
    stars[i].show();
  }
  ship.show();
  ship.move();
  stroke(0);
  for (Asteroid ast : asteroids) {
    ast.show();
    ast.move();
    dist2 = dist(ast.getX(), ast.getY(), ship.getX(), ship.getY());
    if (dist2 < 25 && check == true) {
      lives--;
      check = false;
      countDown = 120;
    }
  }
  for (Bullet bull : bullets) {
    bull.show();
    bull.move();
  }
   for (int i = 0; i < asteroids.size(); i++) {
    for (int j = 0; j < bullets.size(); j++) {
      dist1 = dist(asteroids.get(i).getX(), asteroids.get(i).getY(), bullets.get(j).getX(), bullets.get(j).getY());
      if (dist1 < 25) {
        asteroids.remove(i);
        bullets.remove(j);
        score++;
        break;
      }
    }
  }
  fill(255);
  textSize(30);
  text("Lives: " + lives, 25, 50);
  text("Score: " + score, 25, 100);
  if (countDown > 0) {
    countDown--;
    ship.setColor(color(255, 0, 0));
  } else {
    check = true;
    ship.setColor(color(153, 255, 255));
  }
  if (lives == 0) {
    gameOver = true;
  }
  if (score == 20) {
    win = true;
  }
  if (gameOver == true) {
    fill(0);
    rect(0, 0, 700, 700);
    textAlign(CENTER);
    fill(255);
    text("GAME OVER", 350, 350);
  }
  if (win == true) {
    fill(0);
    rect(0, 0, 700, 700);
    textAlign(CENTER);
    fill(255);
    text("YOU WIN!", 350, 350);
  }
}

public void keyPressed() {
  if (key == CODED) {
    if (keyCode == RIGHT) {
      right = true;
    } 
    if (keyCode == LEFT) {
      left = true;
    } 
    if (keyCode == UP) {
      up = true;
    }
    if (keyCode == DOWN) {
      down = true;
    }
  } 
  if (key == 'h') {
      ship.setX((int)(Math.random()*701));
      ship.setY((int)(Math.random()*701));
      ship.setDirectionX(0);
      ship.setDirectionY(0);
      ship.setPointDirection((int)(Math.random()*360));
  }
  if (up == true) {
    ship.accelerate(1);
  }
  if (down == true) {
    ship.accelerate(-1);
  }
  if (right == true) {
    ship.setPointDirection((int)ship.myPointDirection + 10);
  }
  if (left == true) {
    ship.setPointDirection((int)ship.myPointDirection - 10);
  }
  if (key == ' ' && frameCount%3 == 0) {
      bullets.add(new Bullet(ship));
  }
}

public void keyReleased() {
  if (key == CODED) {
    if (keyCode == RIGHT) {
      right = false;
    } 
    if (keyCode == LEFT) {
      left = false;
    } 
    if (keyCode == UP) {
      up = false;
    }
    if (keyCode == DOWN) {
      down = false;
    }
  }
  if (key == ' ') {
      bullets.add(new Bullet(ship));
  }
}

class Bullet extends Floater {
  public Bullet(SpaceShip theShip) {
    myCenterX = theShip.getX();
    myCenterY = theShip.getY();
    double dRadians = theShip.getPointDirection()*(Math.PI/180);
    myPointDirection = dRadians;
    myDirectionX = 5 * Math.cos(dRadians) + theShip.getDirectionX();
    myDirectionY = 5 * Math.sin(dRadians) + theShip.getDirectionY();
  }
  public void show() {
    fill(20, 160, 137);
    ellipse((int)myCenterX, (int)myCenterY, 7, 7);
  }
  public void move() {
    myCenterX += myDirectionX;    
    myCenterY += myDirectionY; 
  }
  public void setX(int x) {myCenterX = x;}
  public int getX() {return (int)myCenterX;}   
  public void setY(int y) {myCenterY = y;}   
  public int getY() {return (int)myCenterY;}
  public void setDirectionX(double x) {myDirectionX = x;}   
  public double getDirectionX() {return myDirectionX;}
  public void setDirectionY(double y) {myDirectionY = y;}
  public double getDirectionY() {return myDirectionY;}
  public void setPointDirection(int degrees) {myPointDirection = degrees;}
  public double getPointDirection() {return myPointDirection;}
}

class Asteroid extends Floater
{
  private int myRotationSpeed;
  public Asteroid() {
    corners = 9;
    xCorners = new int[corners];
    yCorners = new int[corners];
    xCorners[0] = 0;
    yCorners[0] = 28;
    xCorners[1] = 20;
    yCorners[1] = 24;
    xCorners[2] = 28;
    yCorners[2] = 8;
    xCorners[3] = 20;
    yCorners[3] = -12;
    xCorners[4] = 4;
    yCorners[4] = -24;
    xCorners[5] = -4;
    yCorners[5] = -16;
    xCorners[6] = -20;
    yCorners[6] = -12;
    xCorners[7] = -24;
    yCorners[7] = 8;
    xCorners[8] = -8;
    yCorners[8] = 16;
    myColor = color(127);
    myCenterX = (int)(Math.random()*701);
    myCenterY = (int)(Math.random()*701);
    myDirectionX = (int)(Math.random()*5)-2;
    if (myDirectionX == 0) {
      myDirectionX = (int)(Math.random()*5)-2;
    }
    myDirectionY = (int)(Math.random()*5)-2;
    if (myDirectionY == 0) {
      myDirectionY = (int)(Math.random()*5)-2;
    }
    myPointDirection = (int)(Math.random()*360);
    myColor = color(127);
    myRotationSpeed = (int)(Math.random()*11)-5;
    if (myRotationSpeed == 0) {
      myRotationSpeed = (int)(Math.random()*11)-5;      
    }
  }
  public void move() {
    rotate(myRotationSpeed);
    super.move();
  }
  public void setX(int x) {myCenterX = x;}
  public int getX() {return (int)myCenterX;}   
  public void setY(int y) {myCenterY = y;}   
  public int getY() {return (int)myCenterY;}
  public void setDirectionX(double x) {myDirectionX = x;}   
  public double getDirectionX() {return myDirectionX;}
  public void setDirectionY(double y) {myDirectionY = y;}
  public double getDirectionY() {return myDirectionY;}
  public void setPointDirection(int degrees) {myPointDirection = degrees;}
  public double getPointDirection() {return myPointDirection;}
  public void setRotationSpeed(int rot) {myRotationSpeed = rot;}
  public int getRotationSpeed() {return myRotationSpeed;}
}

class SpaceShip extends Floater  
{   
    //your code here
    public SpaceShip() {
      corners = 4;
      xCorners = new int[corners];
      yCorners = new int[corners];
      xCorners[0] = -15;
      yCorners[0] = 10;
      xCorners[1] = -8;
      yCorners[1] = 0;
      xCorners[2] = -15;
      yCorners[2] = -10;
      xCorners[3] = 15;
      yCorners[3] = 0;
      myColor = color(153, 255, 255);
      myCenterX = 350;
      myCenterY = 350;
      myDirectionX = 0;
      myDirectionY = 0;
      myPointDirection = 270;
    }
    public void setX(int x) {myCenterX = x;}
    public int getX() {return (int)myCenterX;}   
    public void setY(int y) {myCenterY = y;}   
    public int getY() {return (int)myCenterY;}
    public void setDirectionX(double x) {myDirectionX = x;}   
    public double getDirectionX() {return myDirectionX;}
    public void setDirectionY(double y) {myDirectionY = y;}
    public double getDirectionY() {return myDirectionY;}
    public void setPointDirection(int degrees) {myPointDirection = degrees;}
    public double getPointDirection() {return myPointDirection;}
    public void setColor(int c) {myColor = c;}
    public int getColor() {return (int)myColor;}
}

class Star 
{
  private int myX, myY;
  Star() {
    myX = (int)(Math.random()*701);
    myY = (int)(Math.random()*701);
  }
  public void show() {
    fill(255);
    ellipse(myX, myY, 4, 4);
  }
}

abstract class Floater //Do NOT modify the Floater class! Make changes in the SpaceShip class 
{   
  protected int corners;  //the number of corners, a triangular floater has 3   
  protected int[] xCorners;   
  protected int[] yCorners;   
  protected int myColor;   
  protected double myCenterX, myCenterY; //holds center coordinates   
  protected double myDirectionX, myDirectionY; //holds x and y coordinates of the vector for direction of travel   
  protected double myPointDirection; //holds current direction the ship is pointing in degrees    
  abstract public void setX(int x);  
  abstract public int getX();   
  abstract public void setY(int y);   
  abstract public int getY();   
  abstract public void setDirectionX(double x);   
  abstract public double getDirectionX();   
  abstract public void setDirectionY(double y);   
  abstract public double getDirectionY();   
  abstract public void setPointDirection(int degrees);   
  abstract public double getPointDirection(); 

  //Accelerates the floater in the direction it is pointing (myPointDirection)   
  public void accelerate (double dAmount)   
  {          
    //convert the current direction the floater is pointing to radians    
    double dRadians = myPointDirection*(Math.PI/180);     
    //change coordinates of direction of travel    
    myDirectionX += ((dAmount) * Math.cos(dRadians));    
    myDirectionY += ((dAmount) * Math.sin(dRadians));       
  }   
  public void rotate (int nDegreesOfRotation)   
  {     
    //rotates the floater by a given number of degrees    
    myPointDirection+=nDegreesOfRotation;   
  }   
  public void move ()   //move the floater in the current direction of travel
  {      
    //change the x and y coordinates by myDirectionX and myDirectionY       
    myCenterX += myDirectionX;    
    myCenterY += myDirectionY;     

    //wrap around screen    
    if(myCenterX > width)
    {     
      myCenterX = 0;    
    }    
    else if (myCenterX<0)
    {     
      myCenterX = width;    
    }    
    if(myCenterY > height)
    {    
      myCenterY = 0;    
    }   
    else if (myCenterY < 0)
    {     
      myCenterY = height;    
    }   
  }   
  public void show ()  //Draws the floater at the current position  
  {             
    fill(myColor);    
    //convert degrees to radians for sin and cos         
    double dRadians = myPointDirection*(Math.PI/180);                 
    int xRotatedTranslated, yRotatedTranslated;    
    beginShape();         
    for(int nI = 0; nI < corners; nI++)    
    {     
      //rotate and translate the coordinates of the floater using current direction 
      xRotatedTranslated = (int)((xCorners[nI]* Math.cos(dRadians)) - (yCorners[nI] * Math.sin(dRadians))+myCenterX);     
      yRotatedTranslated = (int)((xCorners[nI]* Math.sin(dRadians)) + (yCorners[nI] * Math.cos(dRadians))+myCenterY);      
      vertex(xRotatedTranslated,yRotatedTranslated);    
    }   
    endShape(CLOSE);  
  }   
} 

