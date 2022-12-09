
//ROBOT SEGUIDOR DE PAREDES
//Elaborado por Yohanka Vargas Flores y Nayely Giles Valdez
//Matriz
int MatrizPared [][] ={
  {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
  {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1},
  {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1},
  {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1},
  {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1},
  {1, 0, 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 1},
  {1, 0, 0, 1, 1, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 1},
  {1, 0, 0, 1, 1, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 1},
  {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1},
  {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1},
  {1, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 1, 1, 1, 1},
  {1, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 1, 1, 1, 1},
  {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}
};

PImage imgE,imgO;
//Declaracion de variables
boolean estadoinicial=false;
boolean iniciar=false;
boolean ColocarRobotClick=false;

int alto=13; //El total de cuadrados que tendra la matriz pared a lo largo 
int ancho=16; //El total de cuadrados que tendra la matriz pared a lo ancho
int tam =50;//tamaño de los rectangulos, linea,elipse

int Fila;
int Columna;

int robotX;
int robotY;


void setup() {
  background(random(255),random(255), random(255));//color de inicio
  size(800,650);//tamaño de la ventana
  frameRate(5); //El tiempo de movimiento del robot
  imgE=loadImage("fantasmaeste.png");//aqui se llama la imagen y se le pone nombre
  imgO=loadImage("fantasmaoeste.png");
}


void draw() {
  background(255);//color de fondo, por donde puede avanzar

  //crea el tablero o paredes
  for (int a=0; a<alto; a++) {
    for (int b=0; b<ancho; b++) {
      if (MatrizPared[a][b]==1) {
        fill(190, random(100), 255  );//color de los obstaculos
        rect(b*tam, a*tam, tam, tam);
      }
      //Dibujando las líneas al recorrer el tablero
      stroke(0 );
      line(0, a*tam,ancho*tam, a*tam);
      line(b*tam, 0, b*tam,alto*tam);
    }
  }
 
  //aqui se llama las funciones seguir paredes
  seguirParedes();
}


void seguirParedes() {
  if (ColocarRobotClick) {
    fill(255);
    //ellipse(robotX, robotY, tam, tam);
    image(imgE,robotX-tam/2,robotY-tam/2);//ubicacion de la imagen
  }
    imgE.resize(tam,tam);//tamaño de la imagen
    imgO.resize(tam,tam);//tamaño de la imagen
  


  if (iniciar) {
    boolean s1,s2,s3,s4,s5,s6,s7,s8;
    //prueba1
    //Entradas sensoriales-Captura de Percepcion
    s1=(MatrizPared[Fila-1][Columna-1]==1);
    s2=(MatrizPared[Fila-1][Columna]==1);
    s3=(MatrizPared[Fila-1][Columna+1]==1);
    s4=(MatrizPared[Fila][Columna+1]==1);
    s5=(MatrizPared[Fila+1][Columna+1]==1);
    s6=(MatrizPared[Fila+1][Columna]==1);
    s7=(MatrizPared[Fila+1][Columna-1]==1);
    s8=(MatrizPared[Fila][Columna-1]==1);
    
    //Reglas-Caracteristicas
    boolean X1Norte = s2 == true || s3 == true;
    boolean X2Este = s4 == true || s5 == true;
    boolean X3Sur = s6 == true || s7 == true;
    boolean X4Oeste = s8 == true || s1 == true;
    
    //Prueba3
    //Mover Norte
    if(X4Oeste==true && X1Norte==false){
       Fila-=1; //se resta la fila para subir
       robotY = (Fila)*tam+(tam/2);
    }
    //Mover Este
    if(X1Norte==true && X2Este==false){
      Columna+=1; //se aumenta columna para avanzar a la derecha
      robotX = (Columna)*tam+(tam/2);
    }
    //Mover Sur
    if(X2Este==true && X3Sur==false){
      Fila+=1; //se suma la fila para bajar
      robotY = (Fila)*tam+(tam/2);
    }
    //Mover Oeste
    if(X3Sur==true && X4Oeste==false){
     image(imgO,robotX-tam/2,robotY-tam/2);
      Columna-=1; //se resta columna para ir a la izq
      robotX= (Columna)*tam+(tam/2);
    }
    //Si no esta en la pared mover al Norte
    if(!X4Oeste && !X1Norte && !X2Este && !X3Sur){
       Fila-=1; 
       robotY = (Fila)*tam+(tam/2);
     
    }
  }
}

void keyPressed() {
 if (keyCode == ENTER) {
    iniciar = true;
 }
}

void mouseReleased() {
  //Con el click izquierdo aparece el robot
  if (mouseButton==LEFT) {
    int PosMX = mouseX/tam;
    int PosMY = mouseY/tam;
 // fill(255);
    if (PosMX < 16 && PosMY < 13) {
      if (MatrizPared[PosMY][PosMX] == 0) {
        iniciar=false;
        estadoinicial=true;
        ColocarRobotClick=true;
        Columna = mouseX/tam;
        Fila =mouseY/tam;
        robotX = (Columna*tam)+tam/2;
        robotY = (Fila*tam)+tam/2;
        println("Fila_Mouse: "+PosMY+" Columna_Mouse: "+PosMX);
      }
    }
  }
  //Con el click derecho se cambia el estado de la pared
  else if (mouseButton==RIGHT) {
    int PosMX = mouseX/tam;
    int PosMY = mouseY/tam;
   
    fill(255);
    if (PosMX < 16 && PosMY < 13) {
    if (MatrizPared[PosMY][PosMX] == 0){
      MatrizPared[PosMY][PosMX] =1;
      fill(180, 255, 246);
      rect(PosMX*tam, PosMY*tam, tam, tam);
    } else {
      MatrizPared[PosMY][PosMX] = 0;
      fill(0);
      rect(PosMX*tam, PosMY*tam, tam, tam);
    }
  }
}
  
}
 
