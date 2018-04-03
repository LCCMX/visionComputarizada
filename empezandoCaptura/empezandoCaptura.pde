/**
 * Ejemplo incluido en la librería video de la Processing Foundation.
 * traducción para América latina por Adrian Segovia Nessen
 * Empezando con la captura.
 * 
 * Leer y mostrar una imagen desde un dispositivo de captura conectado. 
 */

import processing.video.*;

Capture cam;

void setup() {
  size(640, 480);

  String[] cameras = Capture.list();

  if (cameras == null) {
    println("Falla en recuperar la lista de camaras disponibles, probar la default...");
    cam = new Capture(this, 640, 480);
  } if (cameras.length == 0) {
    println("no hay camaras para captura.");
    exit();
  } else {
    println("camaras disponibles:");
    printArray(cameras);

    // La camara se puede inicializar por el elemento que
    // nos regresa el array list():
    cam = new Capture(this, cameras[0]);
    
    
    // Comienza a capturar imagenes desde la camara
    cam.start();
  }
}

void draw() {
  if (cam.available() == true) {
    cam.read();
  }
  image(cam, 0, 0, width, height);
  
  // Esto hace lo mismo que la linea de arriba image()
  // pero es más rápida cuando solo se dibuja la imagen sin
  // transformaciones, tamaños o tintes adicionales.

  //set(0, 0, cam);
}