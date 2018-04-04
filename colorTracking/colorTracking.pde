import processing.video.*;

Capture video;

color trackColor; //variable para trackear el color
float threshold = 25;

void setup() {
  size(640, 360);
  String[] cameras = Capture.list();
  printArray(cameras);
  // aquí to hago uso de la resolución nativa
  // en 640 x 360
  video = new Capture(this, cameras[3]);
  video.start();
  //de entrada ponemos cualquier color
  trackColor = color(255, 0, 0);
}

void captureEvent(Capture video) {
  video.read();
}

void draw() {
  
  video.loadPixels();
  image(video, 0, 0);
  
  //prueba un con los valores del umbral
  //threshold = map(mouseX, 0, width, 0, 100);
  threshold = 80;

  float avgX = 0;
  float avgY = 0;

  int count = 0;

  // loop en cada pixel
  for (int x = 0; x < video.width; x++ ) {
    for (int y = 0; y < video.height; y++ ) {
      // esta fórmula nos ayuda a buscar
      // por un pixel en el array
      int loc = x + y * video.width;
      // cual es el color del video en rgb
      color currentColor = video.pixels[loc];
      float r1 = red(currentColor);
      float g1 = green(currentColor);
      float b1 = blue(currentColor);
      // cual es el color que busco
      float r2 = red(trackColor);
      float g2 = green(trackColor);
      float b2 = blue(trackColor);
      // se usa la distancia para comparar los colores
      float d = dist(r1, g1, b1, r2, g2, b2); 
      //si el color actual es similar al umbral
      if (d < threshold) {
        stroke(255);
        strokeWeight(1);
        point(x, y);
        avgX += x;
        avgY += y;
        count++;
      }
    }
  }
  // sólo consideramos la distancia del color que sea menor a 10
  //  aquí puedes ajustar par tener un tracking más certero
  // 
  if (count > 0) { 
    avgX = avgX / count;
    avgY = avgY / count;
   
    fill(255);
    strokeWeight(4.0);
    stroke(0);
    ellipse(avgX, avgY, 24, 24);
  }
 
}



void mousePressed() {
  // salva el color donde hagamos click en la variable
  int loc = mouseX + mouseY*video.width;
  trackColor = video.pixels[loc];
}