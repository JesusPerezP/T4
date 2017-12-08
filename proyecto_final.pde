
ArrayList <Figura> figuras;
float lado = random(20,25);
float altura = sqrt(sq(lado) - sq(lado/2f));
float apotema = lado/ 2*tan(PI/6f);
float radio = altura - apotema;
int pantalla= 0;
PImage t1;
PImage t2;
import processing.sound.*;
SoundFile file;





void setup()
{
size(900,600,P3D);
 file = new SoundFile(this, "1.mp3");
 file.play();
 t1 = loadImage("t1.png");
 t2 = loadImage("t2.png");

  
figuras = new ArrayList<Figura>();
for (float j = radio; j<=height; j+= altura){
int paso = (round((j - radio)/altura));
float offset =0;
if (paso%2 == 0){
offset = lado/2f;
}
for (float i =-offset; i<=width; i+= lado){
figuras.add(new Triangulo(i,j,lado,0));
}
for (float i =lado/2f-offset; i<=width; i+= lado){
figuras.add(new Triangulo(i,j-apotema,lado,PI));
}
}
}
void keyPressed(){

  if (key == 'a'){

    file.stop();

  }

  if (key == 's'){

    file.loop();

  }
}
void draw()
{
  switch(pantalla){
  case 0:
  inicio();
  break;
  
  case 1:
  instrucciones();
  break;
  
  case 2:
  juego();
  break;
  
  }
}

//________________________________________________________________________
void inicio(){
background(random(255),random(255),random(255));
image(t1,0,0);
if(mousePressed){
pantalla=1;
  }
}

//_________________________________________________________________________

void instrucciones(){
  background(0,80,230);
  image(t2,0,0);
  if(keyPressed){
    if(key == 'c' || key == 'C'){
pantalla=2;
  }
  }
}
  
//___________________________________________________________________________
void juego(){
  if(keyPressed){
    if((key == 'e' || key == 'E' )){
    exit();
    }
    
  }

 

background(random(10),random(150),random(200),random(255));
noStroke();
fill(0);



for (Figura f: figuras){
f.display();
}
}
interface Figura
{
float perimetro ();
float area ();
void display();
}
class Triangulo implements Figura
{
float x,y,l,rc,ri,a,a1,deltax,deltay,h,b,rota;
Triangulo (float x_,float y_,float l_, float rota_)
{
x=x_;
y=y_;
l=l_;
rc=(l*sqrt(3))/3f;
b=l;
a1=TWO_PI/3;
rota = rota_;
}
float perimetro ()
{
return l*3;
}
float area ()
{
return ((l*l)*(sqrt(3)))/4;
}
void display()
{
fill (random(0),random(255),random(232));
 rotate(frameCount / random(10,-10));
 
pushMatrix();
translate(x,y);

rotate(HALF_PI - PI/3 + rota);
beginShape();
for(float a = 0;a<TWO_PI;a+=a1)
{
deltax=cos(a)*rc;
deltay=sin(a)*rc;
vertex(deltax,deltay);
}
endShape(CLOSE);
popMatrix();
}
}