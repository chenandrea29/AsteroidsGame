//your variable declarations here
SpaceShip ship;
boolean up = false;
boolean down = false;
boolean left = false;
boolean right = false;
Star[] stars = new Star[200];
Asteroid[] asteroids = new Asteroid[15];

public void setup() 
{
  //your code here
  size(500, 500);
  ship = new SpaceShip();
  for (int i = 0; i < stars.length; i++) {
    stars[i] = new Star();
  }
  for (int i = 0; i < asteroids.length; i++) {
    asteroids[i] = new Asteroid();
  }
}
public void draw() 
{
  //your code here
  background(0);
  for (int i = 0; i < stars.length; i++) {
    stars[i].show();
  }
  ship.show();
  ship.move();
  for (int i = 0; i < asteroids.length; i++) {
    asteroids[i].show();
    asteroids[i].move();
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
      ship.setX((int)(Math.random()*501));
      ship.setY((int)(Math.random()*501));
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
}

class Asteroid extends Floater
{
  private int RotationSpeed;
  public Asteroid() {
    corners = 9;
    xCorners = new int[corners];
    yCorners = new int[corners];
    xCorners[0] = 0;
    yCorners[0] = 21;
    xCorners[1] = 15;
    yCorners[1] = 18;
    xCorners[2] = 21;
    yCorners[2] = 6;
    xCorners[3] = 15;
    yCorners[3] = -9;
    xCorners[4] = 3;
    yCorners[4] = -18;
    xCorners[5] = -3;
    yCorners[5] = -12;
    xCorners[6] = -15;
    yCorners[6] = -9;
    xCorners[7] = -18;
    yCorners[7] = 6;
    xCorners[8] = -6;
    yCorners[8] = 12;
    myColor = color(127);
    myCenterX = (int)(Math.random()*500);
    myCenterY = (int)(Math.random()*500);
    myDirectionX = (int)(Math.random()*7)-3;
    myDirectionY = (int)(Math.random()*7)-3;
    myPointDirection = (int)(Math.random()*360);
    myColor = color(127);
    RotationSpeed = (int)(Math.random()*11)-5;
  }
  public void move() {
    rotate(RotationSpeed);
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
      myCenterX = 250;
      myCenterY = 250;
      myDirectionX = 0;
      myDirectionY = 0;
      myPointDirection = 0;
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

class Star 
{
  private int myX, myY;
  Star() {
    myX = (int)(Math.random()*501);
    myY = (int)(Math.random()*501);
  }
  public void show() {
    fill(255);
    noStroke();
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
    stroke(myColor);    
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

