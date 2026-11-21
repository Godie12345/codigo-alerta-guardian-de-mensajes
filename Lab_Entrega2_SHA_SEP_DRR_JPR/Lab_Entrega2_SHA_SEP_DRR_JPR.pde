/**
 * CODIGO ALERTA: GUARDIAN DE MENSAJES - Laboratorio Unico - Feria Gamer 2026
 * Algoritmia y Programacion I - Semestre 2026_30 - Entrega 2 (Java en Processing)
 * Profesora: Rocio Ramos Rodriguez
 * Integrantes: Santiago Herrera Arevalo, Samuel Eskaff Perez,
 *              Diego Rojano Retamozo, Juan Parra Roa
 */

// ====================================================================
// CONSTANTES
// ====================================================================
final int LIM_EJEMPLAR = 5;
final int LIM_RESPONSABLE = 13;
final int LIM_RIESGO = 20;
final int TOTAL_SITUACIONES = 13;

// ----- Pantalla -----
final boolean PANTALLA_COMPLETA = true;
final int ANCHO = 960;
final int ALTO = 680;
final int TOTAL_LOGROS = 5;

// ====================================================================
// VARIABLES GLOBALES
// ====================================================================

// ----- Control de pantallas y entrada de texto -----
int pantalla = 0;
int paso = 1;
String entrada = "";
String mensajeError = "";
String aviso = "";
boolean clic = false;
int cursorY = 0;
int tSalida = 0;
// ----- Sonido -----
javax.sound.sampled.Clip sonidoClic;
javax.sound.sampled.Clip musicaFondo;
boolean sonidoActivo = true;
PFont fuente;
PFont fuenteNegrita;
boolean manoCursor = false;
float escala = 1;
float margenX = 0, margenY = 0;
int mx = 0, my = 0;

// ----- Pantalla de inicio y configuracion -----
PImage imgInicio;
float escInicio = 1;
int yInicio = 0;
boolean hayPartida = false;
int pantallaGuardada = 16;
int pantallaVolver = 12;
String avisoInicio = "";
int tiempoNivel3 = 15;

// ----- Imagenes de las situaciones y del resultado -----
PImage imgSit1, imgSit2, imgSit3, imgSit4, imgSit5, imgSit6, imgSit7;
PImage imgSit8, imgSit9, imgSit10, imgSit11, imgSit12, imgSit13;
PImage imgCorrecta, imgIncorrecta;
PImage imgRegistro, imgContenido1, imgContenido2, imgLogros;
PImage imgReiniciar, imgConfig, imgDespedida, imgGuia;
PImage imgDia, imgMenuDia, imgResumen, imgMenuFinal, imgReporte, imgDesglose;
PImage imgPrologo, imgFinSecreto, imgFinBueno, imgFinRegular, imgFinMalo;
PImage imgCierre1, imgCierre2, imgCierre3, imgCierre4, imgCierre5, imgCierre6, imgCierre7;

// ----- Configuracion que se conserva al reiniciar -----
boolean recordarNombre = true;
String nombreGuardado = "";

// ----- Logros historicos -----
boolean histFake = false, histPriv = false, histTiempo = false;
boolean histBienestar = false, histRacha = false;

// ----- Datos de ingreso (Parte_1) -----
String nombre = "";
String franja = "";
int edad = 0, anio = 0, mes = 0, dia = 0;
int hora12 = 0, minuto = 0, horasUso = 0;

// ----- Calculos de fecha y hora (Parte_1) -----
int hora24 = 0, diasDelMes = 0, tValor = 0, y = 0;
int diaSemIng = 0, diaSemSal = 0;
int restoHoras = 0, sumaHoras = 0, diasExtra = 0, hora24S = 0;
int anioS = 0, mesS = 0, diaS = 0;
int yy = 0, era = 0, doe = 0, yoe = 0, doy = 0, mp = 0, z = 0;
int segIngreso = 0, segSalida = 0;
boolean esBisiesto = false;
boolean fueraHorario = false;
String msgTiempo = "";
String msgHorario = "";

// ----- Contenido consumido -----
int contenido1 = 0, contenido2 = 0, selecciones = 0;
String msgContenido = "";

// ----- Puntaje (acumuladores) y contadores -----
int puntaje = 0, ptsTiempo = 0, ptsHorario = 0, ptsContenido = 0;
int ptsDecisiones = 0, ptsFatiga = 0;
int correctas = 0, incorrectas = 0, racha = 0, mejorRacha = 0;

// ----- Semana digital -----
int diaJuego = 1, nivel = 1, numSit = 1, sitEnDia = 1, sitsDelDia = 2;
int fecAnio = 0, fecMes = 0, fecDia = 0, fecSem = 0;
int horasHoy = 0, horasTotales = 0, diasControlados = 0;
int aciertosDia = 0, ptsDia = 0, ptsPrimera = 0, ptsSegunda = 0;
int respN1 = 0, respN2 = 0, respN3 = 0, acN1 = 0, acN2 = 0, acN3 = 0;
String bitacora = "", avisoLogros = "", temaDia = "", descDia = "", msgFatiga = "";

// ----- Logros -----
boolean logroFake = false, logroPriv = false, logroTiempo = false;
boolean logroBienestar = false, logroRacha = false;

// ----- Situacion actual -----
String sL1 = "", sL2 = "";
String sOp1 = "", sOp2 = "", sOp3 = "", sOp4 = "";
String sFb1 = "", sFb2 = "", sFb3 = "", sFb4 = "";
int sP1 = 0, sP2 = 0, sP3 = 0, sP4 = 0;
int inicioSit = 0;
String ultimoFb = "";
int ultimoPts = 0;
boolean ultimaCorrecta = false;

// ----- Resultados finales -----
int tipoFinal = 0;
String clasificacion = "", diagnostico = "";
float promedioDiario = 0, diasEquivAnio = 0;
int diasCompletos = 0, horasRest = 0, nivelesSuperados = 0;
int partidas = 1, mejorPuntaje = -1;

// ====================================================================
// PROGRAMA PRINCIPAL DE PROCESSING
// ====================================================================
void settings() {
  if (PANTALLA_COMPLETA) {
    fullScreen();
  } else {
    size(ANCHO, ALTO);
  }
  smooth(4);
}

void setup() {
  surface.setTitle("Codigo Alerta: Guardian de Mensajes");
  if (!PANTALLA_COMPLETA) { surface.setResizable(true); }
  frameRate(30);
  fuente = cargarFuente("Poppins-Medium.ttf", "SansSerif");
  fuenteNegrita = cargarFuente("Poppins-Bold.ttf", "SansSerif Bold");
  textFont(fuente);
  imgInicio = buscarImagen("inicio.png");
  if (imgInicio == null) { imgInicio = buscarImagen("inicio.jpg"); }
  if (imgInicio == null) { imgInicio = buscarImagen("C_digo_Alerta__Guardi_n_Digital.png"); }
  if (imgInicio == null) { imgInicio = buscarImagen("Codigo_Alerta_Guardian_Digital.png"); }
  if (imgInicio != null) {
    escInicio = ANCHO / 1672.0;
    yInicio = (ALTO - altoImg(imgInicio)) / 2;
  }
  imgSit1 = cargarPantalla("sit01.jpg");
  imgSit2 = cargarPantalla("sit02.jpg");
  imgSit3 = cargarPantalla("sit03.jpg");
  imgSit4 = cargarPantalla("sit04.jpg");
  imgSit5 = cargarPantalla("sit05.jpg");
  imgSit6 = cargarPantalla("sit06.jpg");
  imgSit7 = cargarPantalla("sit07.jpg");
  imgSit8 = cargarPantalla("sit08.jpg");
  imgSit9 = cargarPantalla("sit09.jpg");
  imgSit10 = cargarPantalla("sit10.jpg");
  imgSit11 = cargarPantalla("sit11.jpg");
  imgSit12 = cargarPantalla("sit12.jpg");
  imgSit13 = cargarPantalla("sit13.jpg");
  imgCorrecta = cargarPantalla("correcta.jpg");
  imgIncorrecta = cargarPantalla("incorrecta.jpg");
  imgRegistro = cargarPantalla("registro.jpg");
  imgContenido1 = cargarPantalla("contenido1.jpg");
  imgContenido2 = cargarPantalla("contenido2.jpg");
  imgLogros = cargarPantalla("logros.jpg");
  imgReiniciar = cargarPantalla("reiniciar.jpg");
  imgConfig = cargarPantalla("configuracion.jpg");
  imgDespedida = cargarPantalla("despedida.jpg");
  imgGuia = cargarPantalla("guia.jpg");
  imgDia = cargarPantalla("dia.jpg");
  imgMenuDia = cargarPantalla("menudia.jpg");
  imgResumen = cargarPantalla("resumen.jpg");
  imgMenuFinal = cargarPantalla("menufinal.jpg");
  imgReporte = cargarPantalla("reporte.jpg");
  imgDesglose = cargarPantalla("desglose.jpg");
  imgCierre1 = cargarPantalla("cierre1.jpg");
  imgCierre2 = cargarPantalla("cierre2.jpg");
  imgCierre3 = cargarPantalla("cierre3.jpg");
  imgCierre4 = cargarPantalla("cierre4.jpg");
  imgCierre5 = cargarPantalla("cierre5.jpg");
  imgCierre6 = cargarPantalla("cierre6.jpg");
  imgPrologo = cargarPantalla("prologo.jpg");
  sonidoClic = cargarSonido("click.wav");
  musicaFondo = cargarSonido("musica.wav");
  iniciarMusica();
  imgFinSecreto = cargarPantalla("final_secreto.jpg");
  imgFinBueno = cargarPantalla("final_bueno.jpg");
  imgFinRegular = cargarPantalla("final_regular.jpg");
  imgFinMalo = cargarPantalla("final_malo.jpg");
  imgCierre7 = cargarPantalla("cierre7.jpg");
}

javax.sound.sampled.Clip cargarSonido(String archivo) {
  javax.sound.sampled.Clip c = null;
  try {
    File f = new File(dataPath(archivo));
    if (f.exists()) {
      javax.sound.sampled.AudioInputStream audio = javax.sound.sampled.AudioSystem.getAudioInputStream(f);
      c = javax.sound.sampled.AudioSystem.getClip();
      c.open(audio);
    }
  }
  catch (Exception ex) {
    c = null;
  }
  return c;
}

void iniciarMusica() {
  if (musicaFondo != null && sonidoActivo) {
    musicaFondo.loop(javax.sound.sampled.Clip.LOOP_CONTINUOUSLY);
  }
}

void sonarClic() {
  if (sonidoClic != null && sonidoActivo) {
    sonidoClic.stop();
    sonidoClic.setFramePosition(0);
    sonidoClic.start();
  }
}

void alternarSonido() {
  sonidoActivo = !sonidoActivo;
  if (musicaFondo != null) {
    if (sonidoActivo) { iniciarMusica(); } else { musicaFondo.stop(); }
  }
}

PFont cargarFuente(String archivo, String respaldo) {
  if (new File(dataPath(archivo)).exists()) {
    return createFont(archivo, 32, true);
  }
  return createFont(respaldo, 32, true);
}

void enCasilla(String s, float x0, float y0, float w, float h, int yI,
               float tam, int r, int g, int b, boolean centrado) {
  float e = ANCHO / 1672.0;
  textFont(fuenteNegrita);
  float t = tam;
  textSize(t);
  while (textWidth(s) > w * e - 10 && t > 7) {
    t = t - 0.5;
    textSize(t);
  }
  fill(r, g, b);
  float cy = yI + (y0 + h / 2) * e - t * 0.06;
  if (centrado) {
    textAlign(CENTER, CENTER);
    text(s, (x0 + w / 2) * e, cy);
  } else {
    textAlign(LEFT, CENTER);
    text(s, x0 * e + 6, cy);
  }
  textAlign(LEFT, TOP);
  textFont(fuente);
}

void textoContorno(String s, float cx, float cy, float tam, float maxAncho, int r, int g, int b) {
  textFont(fuenteNegrita);
  float t = tam;
  textSize(t);
  while (textWidth(s) > maxAncho && t > 8) {
    t = t - 0.5;
    textSize(t);
  }
  textAlign(CENTER, CENTER);
  fill(25, 5, 70);
  for (int dx = -2; dx <= 2; dx++) {
    for (int dy = -2; dy <= 2; dy++) {
      if (dx != 0 || dy != 0) { text(s, cx + dx, cy + dy); }
    }
  }
  fill(r, g, b);
  text(s, cx, cy);
  textAlign(LEFT, TOP);
  textFont(fuente);
}

boolean botonImg(float x0, float y0, float w, float h, String etiqueta, int yI) {
  float e = ANCHO / 1672.0;
  boolean encima = (mx >= x0 * e && mx <= (x0 + w) * e && my >= yI + y0 * e && my <= yI + (y0 + h) * e);
  int c = 255;
  if (encima) {
    fill(255, 200, 60);
    manoCursor = true;
    c = 30;
  } else {
    fill(110, 40, 200);
  }
  stroke(255);
  strokeWeight(2);
  rect(x0 * e, yI + y0 * e, w * e, h * e, 12);
  noStroke();
  enCasilla(etiqueta, x0, y0, w, h, yI, 22, c, c, c, true);
  return (encima && clic);
}

int altoImg(PImage img) {
  return round(img.height * ANCHO / (float) img.width);
}

int fondoImagen(PImage img) {
  int yImg = (ALTO - altoImg(img)) / 2;
  image(img, 0, yImg, ANCHO, altoImg(img));
  return yImg;
}

boolean zona(float x0, float y0, float w, float h, int yImg) {
  float e = ANCHO / 1672.0;
  boolean encima = (mx >= x0 * e && mx <= (x0 + w) * e
                    && my >= yImg + y0 * e && my <= yImg + (y0 + h) * e);
  if (encima) {
    manoCursor = true;
    resaltarZona(x0, y0, w, h, yImg);
  }
  return (encima && clic);
}

void cajaImg(float x0, float y0, float w, float h, int yImg, int r, int g, int b) {
  float e = ANCHO / 1672.0;
  fill(r, g, b);
  noStroke();
  rect(x0 * e, yImg + y0 * e, w * e, h * e, 8);
}

void marcoImg(float x0, float y0, float w, float h, int yImg, int r, int g, int b) {
  float e = ANCHO / 1672.0;
  noFill();
  stroke(r, g, b);
  strokeWeight(5);
  rect(x0 * e, yImg + y0 * e, w * e, h * e, 12);
  noStroke();
}

void franjas(String arriba, String abajo, int yImg) {
  textAlign(CENTER, CENTER);
  textSize(16);
  fill(255, 215, 0);
  text(arriba, ANCHO / 2, yImg / 2);
  fill(170, 215, 255);
  text(abajo, ANCHO / 2, ALTO - yImg / 2);
  textAlign(LEFT, TOP);
}

PImage cargarPantalla(String archivo) {
  return buscarImagen(archivo);
}

PImage imagenSituacion(int n) {
  PImage img = null;
  switch (n) {
    case 1:  img = imgSit1;  break;
    case 2:  img = imgSit2;  break;
    case 3:  img = imgSit3;  break;
    case 4:  img = imgSit4;  break;
    case 5:  img = imgSit5;  break;
    case 6:  img = imgSit6;  break;
    case 7:  img = imgSit7;  break;
    case 8:  img = imgSit8;  break;
    case 9:  img = imgSit9;  break;
    case 10: img = imgSit10; break;
    case 11: img = imgSit11; break;
    case 12: img = imgSit12; break;
    default: img = imgSit13;
  }
  return img;
}

boolean sobreOpcion(int i, int yImg) {
  float e = ANCHO / 1672.0;
  int col = (i - 1) % 2;
  int fila = (i - 1) / 2;
  float x0 = 70;
  if (col == 1) { x0 = 845; }
  float y0 = 612;
  if (fila == 1) { y0 = 757; }
  float bx = x0 * e;
  float by = yImg + y0 * e;
  return (mx >= bx && mx <= bx + 750 * e && my >= by && my <= by + 138 * e);
}

void resaltarZona(float x0, float y0, float w, float h, int yImg) {
  float e = ANCHO / 1672.0;
  float brillo = 70 + 50 * sin(millis() / 150.0);
  fill(255, 230, 90, brillo);
  stroke(255, 215, 0);
  strokeWeight(3);
  rect(x0 * e, yImg + y0 * e, w * e, h * e, 10);
  noStroke();
}

void textoEnCaja(String s, float x, float y, int maxCh, float salto) {
  while (s.length() > maxCh) {
    int corte = s.lastIndexOf(' ', maxCh);
    if (corte <= 0) { corte = maxCh; }
    text(s.substring(0, corte), x, y);
    y = y + salto;
    s = s.substring(corte).trim();
  }
  text(s, x, y);
}

PImage buscarImagen(String archivo) {
  PImage img = null;
  if (new File(dataPath(archivo)).exists()) {
    img = loadImage(dataPath(archivo));
  } else {
    if (new File(sketchPath(archivo)).exists()) {
      img = loadImage(sketchPath(archivo));
    }
  }
  if (img != null && img.width <= 0) { img = null; }
  return img;
}

void draw() {
  manoCursor = false;
  escala = min(width / (float) ANCHO, height / (float) ALTO);
  margenX = (width - ANCHO * escala) / 2;
  margenY = (height - ALTO * escala) / 2;
  mx = (int) ((mouseX - margenX) / escala);
  my = (int) ((mouseY - margenY) / escala);
  background(0);
  pushMatrix();
  translate(margenX, margenY);
  scale(escala);
  dibujarFondo();
  textAlign(LEFT, TOP);
  switch (pantalla) {
    case 0:  pantallaInicio();    break;
    case 16: pantallaPortada();   break;
    case 17: pantallaConfig();    break;
    case 18: pantallaReiniciar(); break;
    case 1:  pantallaRegistro();  break;
    case 2:  pantallaResumen();   break;
    case 3:  pantallaContenido(); break;
    case 4:  pantallaMenu();      break;
    case 5:  pantallaGuia();      break;
    case 6:  pantallaDia();       break;
    case 7:  pantallaSituacion(); break;
    case 9:  pantallaResultado(); break;
    case 10: pantallaCierre();    break;
    case 11: pantallaFinal();     break;
    case 12: pantallaMenuFinal(); break;
    case 13: pantallaReporte();   break;
    case 14: pantallaDesglose();  break;
    case 15: pantallaLogros();    break;
    case 20: pantallaDespedida(); break;
    default: pantalla = 0;
  }
  popMatrix();
  if (clic && manoCursor) { sonarClic(); }
  if (manoCursor) { cursor(HAND); } else { cursor(ARROW); }
  clic = false;
}

void mousePressed() {
  clic = true;
}

void keyPressed() {
  if (key == ESC) {
    key = 0;
    accionEscape();
    return;
  }
  boolean enter = (key == ENTER || key == RETURN);
  boolean escribiendo = (pantalla == 1 || (pantalla == 6 && diaJuego > 1));
  if ((key == 'm' || key == 'M') && !escribiendo) {
    alternarSonido();
    return;
  }
  if (enter) { sonarClic(); }
  switch (pantalla) {
    case 0:
      if (key >= '1' && key <= '5') { accionInicio(key - '0'); }
      break;
    case 16:
      if (enter) { pantalla = 1; }
      break;
    case 17:
      if (key >= '1' && key <= '3') { elegirTiempo(key - '0'); }
      if (key == '4') { recordarNombre = !recordarNombre; }
      if (enter) { pantalla = 0; }
      break;
    case 18:
      if (key == '1' || key == 's' || key == 'S') { confirmarReinicio(); }
      if (key == '2' || key == 'n' || key == 'N') { pantalla = 0; }
      break;
    case 1:
      if (enter) { confirmarRegistro(); } else { escribirTecla(); }
      break;
    case 2:
      if (enter) { pantalla = 3; }
      break;
    case 3:
      if (key >= '1' && key <= '8') { elegirContenido(key - '0'); }
      break;
    case 4:
      if (key >= '1' && key <= '3') { accionMenu(key - '0'); }
      break;
    case 5:
      if (enter) { empezarSemana(); }
      break;
    case 6:
      if (enter) { confirmarDia(); } else { if (diaJuego > 1) { escribirTecla(); } }
      break;
    case 7:
      if (key >= '1' && key <= '4') {
        resolver(key - '0');
      } else {
        if (key >= 'a' && key <= 'd') {
          resolver(key - 'a' + 1);
        } else {
          if (key >= 'A' && key <= 'D') { resolver(key - 'A' + 1); }
        }
      }
      break;
    case 9:
      if (enter || key == ' ') { continuarDespuesDeDecision(); }
      break;
    case 10:
      if (enter) { avanzarDesdeCierre(); }
      break;
    case 11:
      if (enter) { pantalla = 12; }
      break;
    case 12:
      if (key >= '1' && key <= '5') { accionMenuFinal(key - '0'); }
      break;
    case 13:
    case 14:
      if (enter) { pantalla = 12; }
      break;
    case 15:
      if (enter) { pantalla = pantallaVolver; }
      break;
  }
}

void accionEscape() {
  switch (pantalla) {
    case 5:
      pantalla = 4;
      break;
    case 13:
    case 14:
      pantalla = 12;
      break;
    case 15:
      pantalla = pantallaVolver;
      break;
    case 16:
    case 17:
    case 18:
      pantalla = 0;
      break;
    case 1: case 2: case 3: case 4: case 6: case 7:
    case 9: case 10: case 11: case 12:
      pantallaGuardada = pantalla;
      avisoInicio = "Partida en pausa. Presiona JUGAR para continuar.";
      pantalla = 0;
      break;
  }
}

// ====================================================================
// FUNCIONES DE DIBUJO (interfaz)
// ====================================================================

void dibujarFondo() {
  int c1 = color(14, 22, 58);
  int c2 = color(52, 16, 84);
  for (int i = 0; i < ALTO; i++) {
    stroke(lerpColor(c1, c2, i / (float) ALTO));
    line(0, i, ANCHO, i);
  }
  noStroke();
}

void encabezado(String titulo, String sub) {
  fill(255, 215, 0);
  textFont(fuenteNegrita);
  textSize(32);
  textAlign(LEFT, TOP);
  text(titulo, 40, 20);
  textFont(fuente);
  fill(170, 215, 255);
  textSize(16);
  text(sub, 42, 64);
  stroke(255, 215, 0);
  strokeWeight(2);
  line(40, 92, ANCHO - 40, 92);
  noStroke();
  cursorY = 108;
}

void pc(String s, int r, int g, int b) {
  fill(r, g, b);
  textSize(19);
  textAlign(LEFT, TOP);
  text(s, 40, cursorY);
  cursorY = cursorY + 26;
}

void p(String s) {
  pc(s, 255, 255, 255);
}

void espacio(int h) {
  cursorY = cursorY + h;
}

void pBloque(String s) {
  s = s.trim();
  int lineas = 1;
  for (int i = 0; i < s.length(); i++) {
    if (s.charAt(i) == '\n') { lineas++; }
  }
  fill(255);
  textSize(18);
  textLeading(26);
  textAlign(LEFT, TOP);
  text(s, 40, cursorY);
  cursorY = cursorY + 26 * lineas;
}

void parrafo(String s, int maxCh) {
  parrafoColor(s, maxCh, 255, 255, 255);
}

void parrafoColor(String s, int maxCh, int r, int g, int b) {
  while (s.length() > maxCh) {
    int corte = s.lastIndexOf(' ', maxCh);
    if (corte <= 0) { corte = maxCh; }
    pc(s.substring(0, corte), r, g, b);
    s = s.substring(corte).trim();
  }
  pc(s, r, g, b);
}

boolean boton(int px, int py, int w, int h, String etiqueta) {
  boolean encima = (mx >= px && mx <= px + w && my >= py && my <= py + h);
  if (encima) { fill(255, 200, 60); manoCursor = true; } else { fill(48, 120, 210); }
  stroke(255);
  strokeWeight(2);
  rect(px, py, w, h, 12);
  noStroke();
  if (encima) { fill(25); } else { fill(255); }
  textFont(fuenteNegrita);
  textSize(18);
  textAlign(CENTER, CENTER);
  text(etiqueta, px + w / 2, py + h / 2);
  textAlign(LEFT, TOP);
  textFont(fuente);
  return (encima && clic);
}

void barra(String etiqueta, int px, int py, int llenos, int total, String derecha) {
  fill(255);
  textSize(18);
  textAlign(LEFT, CENTER);
  text(etiqueta, px, py + 11);
  for (int i = 1; i <= total; i++) {
    if (i <= llenos) { fill(80, 220, 120); } else { fill(60, 72, 104); }
    stroke(255);
    strokeWeight(1);
    rect(px + 100 + (i - 1) * 30, py, 26, 22, 4);
  }
  noStroke();
  fill(255);
  text(derecha, px + 100 + total * 30 + 10, py + 11);
  textAlign(LEFT, TOP);
}

String dos(int n) {
  if (n < 10) { return "0" + n; }
  return "" + n;
}

String fechaTxt(int d, int m, int a, int sem) {
  return nombreDia(sem) + " " + d + "/" + m + "/" + a;
}

String horaTxt(int h24, int m, int s) {
  int h12 = h24;
  String f = "AM";
  if (h24 == 0) {
    h12 = 12;
  } else {
    if (h24 == 12) {
      f = "PM";
    } else {
      if (h24 > 12) {
        h12 = h24 - 12;
        f = "PM";
      }
    }
  }
  return dos(h24) + ":" + dos(m) + ":" + dos(s) + " (militar) = " + h12 + ":" + dos(m) + ":" + dos(s) + " " + f;
}

// ====================================================================
// FUNCIONES DE APOYO (calculos y textos)
// ====================================================================

boolean soloDigitos(String s) {
  if (s.length() == 0) { return false; }
  for (int i = 0; i < s.length(); i++) {
    char c = s.charAt(i);
    if (c < '0' || c > '9') { return false; }
  }
  return true;
}

boolean esBisiestoAnio(int a) {
  return ((a % 4 == 0 && a % 100 != 0) || (a % 400 == 0));
}

int diasEnMes(int m, int a) {
  int d = 30;
  switch (m) {
    case 1: case 3: case 5: case 7: case 8: case 10: case 12:
      d = 31;
      break;
    case 4: case 6: case 9: case 11:
      d = 30;
      break;
    case 2:
      if (esBisiestoAnio(a)) { d = 29; } else { d = 28; }
      break;
    default:
      d = 30;
  }
  return d;
}

String nombreDia(int d) {
  String n = "";
  switch (d) {
    case 0: n = "Domingo"; break;
    case 1: n = "Lunes"; break;
    case 2: n = "Martes"; break;
    case 3: n = "Miercoles"; break;
    case 4: n = "Jueves"; break;
    case 5: n = "Viernes"; break;
    case 6: n = "Sabado"; break;
    default: n = "";
  }
  return n;
}

String nombreNivel(int n) {
  String s = "";
  switch (n) {
    case 1: s = "Principiante Digital"; break;
    case 2: s = "Usuario Frecuente"; break;
    default: s = "Experto Digital";
  }
  return s;
}

String nombreContenido(int n) {
  String s = "";
  switch (n) {
    case 1: s = "Contenido educativo"; break;
    case 2: s = "Noticias de medios oficiales"; break;
    case 3: s = "Contenido cultural"; break;
    case 4: s = "Entretenimiento"; break;
    case 5: s = "Noticias de creadores de contenido"; break;
    case 6: s = "Cadenas o mensajes sospechosos"; break;
    case 7: s = "Noticias falsas / info enganosa"; break;
    default: s = "Publicaciones con mensajes violentos";
  }
  return s;
}

int puntosContenido(int n) {
  int pts = 0;
  switch (n) {
    case 1: case 2: case 3: pts = 0; break;
    case 4: pts = 1; break;
    case 5: pts = 2; break;
    case 6: case 7: pts = 3; break;
    case 8: pts = 4; break;
  }
  return pts;
}

int contarLogros() {
  int n = 0;
  if (logroFake) { n++; }
  if (logroPriv) { n++; }
  if (logroTiempo) { n++; }
  if (logroBienestar) { n++; }
  if (logroRacha) { n++; }
  return n;
}

// ====================================================================
// PANTALLA 0: INICIO
// ====================================================================

boolean sobreBotonInicio(int n) {
  float bx = 565 * escInicio;
  float bw = 540 * escInicio;
  float by = yInicio + (328 + (n - 1) * 96.5) * escInicio;
  float bh = 84 * escInicio;
  return (mx >= bx && mx <= bx + bw && my >= by && my <= by + bh);
}

void pantallaInicio() {
  if (imgInicio == null) {
    inicioRespaldo();
    return;
  }
  image(imgInicio, 0, yInicio, ANCHO, altoImg(imgInicio));
  int elegido = 0;
  for (int i = 1; i <= 5; i++) {
    if (sobreBotonInicio(i)) {
      manoCursor = true;
      float brillo = 70 + 50 * sin(millis() / 150.0);
      float bx = 565 * escInicio;
      float by = yInicio + (328 + (i - 1) * 96.5) * escInicio;
      fill(255, 230, 90, brillo);
      stroke(255, 215, 0);
      strokeWeight(3);
      rect(bx, by, 540 * escInicio, 84 * escInicio, 8);
      noStroke();
      if (clic) { elegido = i; }
    }
  }
  textAlign(CENTER, CENTER);
  textSize(16);
  fill(170, 215, 255);
  text("Feria Gamer 2026   |   Grupo 7   |   Usa el mouse o las teclas 1 a 5   |   M: sonido", ANCHO / 2, yInicio / 2);
  if (!avisoInicio.equals("")) {
    fill(120, 255, 140);
    text(avisoInicio, ANCHO / 2, ALTO - yInicio / 2);
  } else {
    if (partidas > 1 && mejorPuntaje >= 0) {
      fill(255, 215, 0);
      text("Partida #" + partidas + "   |   Mejor puntaje de riesgo: " + mejorPuntaje, ANCHO / 2, ALTO - yInicio / 2);
    }
  }
  textAlign(LEFT, TOP);
  if (elegido > 0) { accionInicio(elegido); }
}

void inicioRespaldo() {
  encabezado("CODIGO ALERTA: GUARDIAN DE MENSAJES", "Tus decisiones digitales construyen tu futuro   |   Feria Gamer 2026");
  if (!avisoInicio.equals("")) { pc(avisoInicio, 120, 255, 140); }
  fill(255, 190, 90);
  textSize(14);
  text("No se encontro la imagen de inicio. Debe estar en:", 40, 568);
  text(dataPath("inicio.png"), 40, 588);
  text("En Processing: menu Sketch > Agregar archivo... y elegir la imagen; luego renombrarla a inicio.png", 40, 608);
  boolean c1 = boton(260, 190, 440, 56, "1. Jugar");
  boolean c2 = boton(260, 266, 440, 56, "2. Reiniciar partida");
  boolean c3 = boton(260, 342, 440, 56, "3. Configuracion");
  boolean c4 = boton(260, 418, 440, 56, "4. Logros");
  boolean c5 = boton(260, 494, 440, 56, "5. Salir");
  if (c1) { accionInicio(1); }
  if (c2) { accionInicio(2); }
  if (c3) { accionInicio(3); }
  if (c4) { accionInicio(4); }
  if (c5) { accionInicio(5); }
}

void accionInicio(int opcion) {
  switch (opcion) {
    case 1:
      avisoInicio = "";
      if (hayPartida) {
        pantalla = pantallaGuardada;
        inicioSit = millis();
      } else {
        hayPartida = true;
        pantallaGuardada = 16;
        pantalla = 16;
        entrada = "";
        if (recordarNombre) { entrada = nombreGuardado; }
      }
      break;
    case 2:
      avisoInicio = "";
      pantalla = 18;
      break;
    case 3:
      avisoInicio = "";
      pantalla = 17;
      break;
    case 4:
      avisoInicio = "";
      pantallaVolver = 0;
      pantalla = 15;
      break;
    case 5:
      pantalla = 20;
      tSalida = millis();
      break;
  }
}

// ====================================================================
// PANTALLA 17: CONFIGURACION
// ====================================================================
void pantallaConfig() {
  if (imgConfig != null) {
    pantallaConfigImagen();
    return;
  }
  encabezado("CONFIGURACION", "Ajusta tu partida antes de jugar");
  pc("Tiempo para decidir en el Nivel 3 (Experto Digital):", 255, 215, 0);
  p("Actual: " + tiempoNivel3 + " segundos por decision.");
  boolean c1 = boton(40, 190, 280, 56, "1. Rapido (10 s)");
  boolean c2 = boton(340, 190, 280, 56, "2. Normal (15 s)");
  boolean c3 = boton(640, 190, 280, 56, "3. Relajado (20 s)");
  cursorY = 280;
  pc("CONTROLES", 255, 215, 0);
  p("- Mouse: haz clic en los botones.");
  p("- Teclas 1 a 8: eligen la opcion con ese numero.");
  p("- ENTER: confirma.   BORRAR: corrige lo que escribes.");
  p("- ESC: vuelve atras. Durante la partida, vuelve al inicio");
  p("  y la partida queda en pausa (JUGAR la continua).");
  String txtNombre = "No";
  if (recordarNombre) { txtNombre = "Si"; }
  boolean c4 = boton(40, 530, 400, 50, "4. Recordar nombre: " + txtNombre);
  boolean volver = boton(520, 530, 400, 50, "VOLVER (ESC)");
  if (c1) { elegirTiempo(1); }
  if (c2) { elegirTiempo(2); }
  if (c3) { elegirTiempo(3); }
  if (c4) { recordarNombre = !recordarNombre; }
  if (volver) { pantalla = 0; }
}

void pantallaConfigImagen() {
  int yI = fondoImagen(imgConfig);
  if (tiempoNivel3 == 10) { marcoImg(205, 502, 188, 120, yI, 80, 255, 120); }
  if (tiempoNivel3 == 15) { marcoImg(413, 502, 190, 120, yI, 80, 255, 120); }
  if (tiempoNivel3 == 20) { marcoImg(621, 502, 188, 120, yI, 80, 255, 120); }
  if (recordarNombre) {
    marcoImg(978, 448, 208, 90, yI, 80, 255, 120);
  } else {
    marcoImg(1222, 448, 206, 90, yI, 80, 255, 120);
  }
  boolean t10 = zona(205, 502, 188, 120, yI);
  boolean t15 = zona(413, 502, 190, 120, yI);
  boolean t20 = zona(621, 502, 188, 120, yI);
  boolean si = zona(978, 448, 208, 90, yI);
  boolean no = zona(1222, 448, 206, 90, yI);
  boolean cambiar = zona(160, 716, 450, 164, yI);
  boolean alternar = zona(635, 716, 430, 164, yI);
  boolean volver = zona(1090, 716, 425, 164, yI);
  String txtNombre = "No";
  if (recordarNombre) { txtNombre = "Si"; }
  franjas("Tiempo en el Nivel 3: " + tiempoNivel3 + " s   |   Recordar nombre: " + txtNombre,
          "Teclas: 1, 2, 3 = tiempo   |   4 = recordar nombre   |   ENTER o ESC = volver", yI);
  if (t10) { elegirTiempo(1); }
  if (t15) { elegirTiempo(2); }
  if (t20) { elegirTiempo(3); }
  if (si) { recordarNombre = true; }
  if (no) { recordarNombre = false; }
  if (cambiar) {
    if (tiempoNivel3 == 10) {
      tiempoNivel3 = 15;
    } else {
      if (tiempoNivel3 == 15) { tiempoNivel3 = 20; } else { tiempoNivel3 = 10; }
    }
  }
  if (alternar) { recordarNombre = !recordarNombre; }
  if (volver) { pantalla = 0; }
}

// ====================================================================
// PANTALLA 18: CONFIRMAR REINICIO
// ====================================================================
void pantallaReiniciar() {
  boolean si = false;
  boolean no = false;
  if (imgReiniciar != null) {
    int yI = fondoImagen(imgReiniciar);
    si = zona(288, 738, 534, 120, yI);
    no = zona(852, 738, 534, 120, yI);
    franjas("Partidas jugadas: " + partidas + "   |   Logros: " + contarLogrosHist() + " de " + TOTAL_LOGROS,
            "Teclas: S o 1 = Si, reiniciar   |   N, 2 o ESC = No, volver", yI);
  } else {
    encabezado("REINICIAR PARTIDA", "Estas seguro de que deseas reiniciar la partida?");
    p("Al reiniciar se borrara todo tu progreso:");
    p("logros obtenidos, mejor puntaje, partidas realizadas y estadisticas.");
    pc("La configuracion se conserva (tiempo por decision y recordar tu nombre).", 120, 255, 140);
    si = boton(140, 400, 320, 56, "1. Si, reiniciar");
    no = boton(500, 400, 320, 56, "2. No, volver");
  }
  if (si) { confirmarReinicio(); }
  if (no) { pantalla = 0; }
}

void confirmarReinicio() {
  reiniciar();
  partidas = 1;
  mejorPuntaje = -1;
  histFake = false;
  histPriv = false;
  histTiempo = false;
  histBienestar = false;
  histRacha = false;
  avisoInicio = "Progreso borrado. La configuracion se conservo. Presiona JUGAR.";
  pantalla = 0;
}

int contarLogrosHist() {
  int n = 0;
  if (logroFake || histFake) { n++; }
  if (logroPriv || histPriv) { n++; }
  if (logroTiempo || histTiempo) { n++; }
  if (logroBienestar || histBienestar) { n++; }
  if (logroRacha || histRacha) { n++; }
  return n;
}

void elegirTiempo(int op) {
  switch (op) {
    case 1: tiempoNivel3 = 10; break;
    case 2: tiempoNivel3 = 15; break;
    default: tiempoNivel3 = 20;
  }
}

// ====================================================================
// PANTALLA 16: PORTADA Y PROLOGO
// ====================================================================
void pantallaPortada() {
  if (imgPrologo != null) {
    int yI = fondoImagen(imgPrologo);
    boolean comenzar = zona(515, 782, 645, 100, yI);
    String arriba = "Feria Gamer 2026   |   Grupo 7";
    if (partidas > 1 && mejorPuntaje >= 0) {
      arriba = "Partida #" + partidas + "   |   Mejor puntaje de riesgo: " + mejorPuntaje;
    }
    franjas(arriba, "ENTER o clic en COMENZAR   |   ESC vuelve al inicio", yI);
    if (comenzar) { pantalla = 1; }
    return;
  }
  encabezado("CODIGO ALERTA: GUARDIAN DE MENSAJES", "Tus decisiones digitales construyen tu futuro   |   Feria Gamer 2026");
  pc("PROLOGO", 255, 215, 0);
  p("Eres estudiante en Ciudad Digital, una ciudad donde todo");
  p("pasa por el celular: las tareas, el grupo del curso, los");
  p("pagos, los amigos y, por desgracia, tambien los estafadores.");
  espacio(10);
  p("Hoy es un dia como cualquier otro: clases, trabajos y mucho");
  p("tiempo conectado. Pero en las sombras de las redes sociales");
  p("hay mensajes falsos, enlaces peligrosos y desconocidos que");
  p("quieren tus datos, tus claves y tu dinero.");
  espacio(10);
  p("Los profesores del plantel han elegido a un estudiante para");
  p("proteger a todo el curso: el GUARDIAN DE LOS MENSAJES.");
  p("Ese estudiante eres tu.");
  espacio(10);
  p("Cuida tu tiempo, elige bien lo que ves y piensa antes de hacer clic.");
  p("Deberas sobrevivir una SEMANA DIGITAL completa (7 dias).");
  if (partidas > 1 && mejorPuntaje >= 0) {
    pc("Partida #" + partidas + "   |   Mejor puntaje de riesgo: " + mejorPuntaje, 120, 255, 140);
  }
  if (boton(320, 610, 320, 50, "COMENZAR (ENTER)")) {
    pantalla = 1;
  }
}

// ====================================================================
// PANTALLA 1: REGISTRO DE LA SESION
// ====================================================================
void pantallaRegistro() {
  if (imgRegistro != null) {
    pantallaRegistroImagen();
    return;
  }
  encabezado("REGISTRO DE LA SESION DIGITAL", "Datos para inicio de la sesion   -   Paso " + paso + " de 9");
  String pregunta = "";
  String ayuda = "";
  switch (paso) {
    case 1: pregunta = "Ingresa tu nombre:"; ayuda = "No puede quedar vacio."; break;
    case 2: pregunta = "Ingresa tu edad:"; ayuda = "Numero entero entre 1 y 120."; break;
    case 3: pregunta = "Anio de ingreso:"; ayuda = "Numero entero entre 1 y 9999."; break;
    case 4: pregunta = "Mes de ingreso:"; ayuda = "Numero entre 1 y 12."; break;
    case 5: pregunta = "Dia de ingreso:"; ayuda = "Numero entre 1 y " + diasDelMes + " (segun el mes y el anio)."; break;
    case 6: pregunta = "Hora de ingreso (formato de 12 horas):"; ayuda = "Numero entre 1 y 12."; break;
    case 7: pregunta = "Minuto de ingreso:"; ayuda = "Numero entre 0 y 59."; break;
    case 8: pregunta = "Franja horaria:"; ayuda = "Escribe AM o PM, o usa los botones."; break;
    default: pregunta = "Cuantas horas usaras redes sociales?"; ayuda = "Numero entero de 1 o mas.";
  }
  pc(pregunta, 255, 215, 0);
  p(ayuda);
  int yCaja = cursorY + 10;
  fill(255);
  stroke(255, 215, 0);
  strokeWeight(3);
  rect(40, yCaja, 500, 50, 10);
  noStroke();
  fill(20);
  textSize(26);
  String parpadeo = "";
  if ((millis() / 500) % 2 == 0) { parpadeo = "_"; }
  text(entrada + parpadeo, 55, yCaja + 10);
  cursorY = yCaja + 70;
  if (!mensajeError.equals("")) { pc(mensajeError, 255, 100, 100); }
  if (!aviso.equals("")) { pc(aviso, 120, 255, 140); }

  fill(170, 215, 255);
  textSize(17);
  int ry = 128;
  if (paso > 1) { text("Jugador: " + nombre, 600, ry); ry = ry + 24; }
  if (paso > 2) { text("Edad: " + edad, 600, ry); ry = ry + 24; }
  if (paso > 3) { text("Anio: " + anio, 600, ry); ry = ry + 24; }
  if (paso > 4) { text("Mes: " + mes, 600, ry); ry = ry + 24; }
  if (paso > 5) { text("Dia: " + dia, 600, ry); ry = ry + 24; }
  if (paso > 6) { text("Hora: " + hora12, 600, ry); ry = ry + 24; }
  if (paso > 7) { text("Minuto: " + minuto, 600, ry); ry = ry + 24; }
  if (paso > 8) { text("Franja: " + franja.toUpperCase(), 600, ry); ry = ry + 24; }

  boolean clicAM = false;
  boolean clicPM = false;
  if (paso == 8) {
    clicAM = boton(560, yCaja, 90, 50, "AM");
    clicPM = boton(660, yCaja, 90, 50, "PM");
  }
  boolean clicOk = boton(40, 600, 240, 50, "CONFIRMAR (ENTER)");
  if (clicAM) {
    entrada = "am";
    confirmarRegistro();
  } else {
    if (clicPM) {
      entrada = "pm";
      confirmarRegistro();
    } else {
      if (clicOk) { confirmarRegistro(); }
    }
  }
}

String preguntaRegistro() {
  String s = "";
  switch (paso) {
    case 1: s = "Ingresa tu nombre:"; break;
    case 2: s = "Ingresa tu edad:"; break;
    case 3: s = "Anio de ingreso:"; break;
    case 4: s = "Mes de ingreso:"; break;
    case 5: s = "Dia de ingreso:"; break;
    case 6: s = "Hora de ingreso (formato de 12 horas):"; break;
    case 7: s = "Minuto de ingreso:"; break;
    case 8: s = "Selecciona la franja horaria de la sesion:"; break;
    default: s = "Cuantas horas usaras redes sociales?";
  }
  return s;
}

String ayudaRegistro() {
  String s = "";
  switch (paso) {
    case 1: s = "No puede quedar vacio."; break;
    case 2: s = "Numero entero entre 1 y 120."; break;
    case 3: s = "Numero entero entre 1 y 9999."; break;
    case 4: s = "Numero entre 1 y 12."; break;
    case 5: s = "Numero entre 1 y " + diasDelMes + " (segun el mes y el anio)."; break;
    case 6: s = "Numero entre 1 y 12."; break;
    case 7: s = "Numero entre 0 y 59."; break;
    case 8: s = "Elige AM (manana) o PM (tarde/noche)."; break;
    default: s = "Numero entero de 1 o mas.";
  }
  return s;
}

String corto(String s, int max) {
  if (s.length() > max) { return s.substring(0, max - 1) + "."; }
  return s;
}

String preguntaCorta() {
  String s = "";
  switch (paso) {
    case 1: s = "Ingresa tu nombre:"; break;
    case 2: s = "Ingresa tu edad:"; break;
    case 3: s = "Año de ingreso:"; break;
    case 4: s = "Mes de ingreso:"; break;
    case 5: s = "Día de ingreso:"; break;
    case 6: s = "Hora de ingreso (1 a 12):"; break;
    case 7: s = "Minuto de ingreso:"; break;
    case 8: s = "Franja horaria (AM o PM):"; break;
    default: s = "¿Cuántas horas usarás redes?";
  }
  return s;
}

void pantallaRegistroImagen() {
  int yI = fondoImagen(imgRegistro);
  float e = ANCHO / 1672.0;
  enCasilla(preguntaCorta(), 418, 285, 397, 73, yI, 19, 30, 25, 95, true);
  enCasilla(ayudaRegistro(), 352, 400, 595, 55, yI, 15, 20, 40, 100, false);
  fill(255);
  stroke(0, 190, 255);
  strokeWeight(3);
  rect(200 * e, yI + 505 * e, 560 * e, 95 * e, 12);
  noStroke();
  String parpadeo = "";
  if ((millis() / 500) % 2 == 0) { parpadeo = "_"; }
  enCasilla(entrada + parpadeo, 220, 505, 530, 95, yI, 26, 20, 20, 40, false);
  boolean clicAM = false;
  boolean clicPM = false;
  if (paso == 8) {
    clicAM = botonImg(785, 505, 115, 95, "AM", yI);
    clicPM = botonImg(915, 505, 110, 95, "PM", yI);
  }
  textFont(fuenteNegrita);
  textAlign(LEFT, TOP);
  textSize(15);
  if (!mensajeError.equals("")) {
    fill(210, 30, 50);
    textoEnCaja(mensajeError, 200 * e, yI + 630 * e, 56, 22);
  }
  if (!aviso.equals("")) {
    fill(20, 140, 70);
    textoEnCaja(aviso, 200 * e, yI + 700 * e, 56, 22);
  }
  textFont(fuente);
  if (paso > 1) { enCasilla(nombre, 1318, 298, 174, 36, yI, 14, 30, 25, 95, true); }
  if (paso > 2) { enCasilla("" + edad, 1318, 352, 174, 36, yI, 14, 30, 25, 95, true); }
  if (paso > 3) { enCasilla("" + anio, 1318, 406, 174, 36, yI, 14, 30, 25, 95, true); }
  if (paso > 4) { enCasilla("" + mes, 1318, 460, 174, 36, yI, 14, 30, 25, 95, true); }
  if (paso > 5) { enCasilla("" + dia, 1318, 514, 174, 36, yI, 14, 30, 25, 95, true); }
  if (paso > 6) { enCasilla("" + hora12, 1318, 568, 174, 36, yI, 14, 30, 25, 95, true); }
  if (paso > 7) { enCasilla("" + minuto, 1318, 622, 174, 36, yI, 14, 30, 25, 95, true); }
  if (paso > 8) { enCasilla(franja.toUpperCase(), 1318, 678, 174, 36, yI, 14, 30, 25, 95, true); }
  boolean clicOk = zona(575, 805, 510, 115, yI);
  franjas("Paso " + paso + " de 9",
          "ENTER confirma   |   BORRAR corrige   |   ESC vuelve al inicio (pausa)", yI);
  if (clicAM) {
    entrada = "am";
    confirmarRegistro();
  } else {
    if (clicPM) {
      entrada = "pm";
      confirmarRegistro();
    } else {
      if (clicOk) { confirmarRegistro(); }
    }
  }
}

void escribirTecla() {
  if (key == BACKSPACE) {
    if (entrada.length() > 0) { entrada = entrada.substring(0, entrada.length() - 1); }
    return;
  }
  if (key == CODED || key == ENTER || key == RETURN || key == TAB || key == DELETE || key == ESC) { return; }
  if (pantalla == 1 && paso == 1) {
    if (key >= 32 && entrada.length() < 20) { entrada = entrada + key; }
  } else {
    if (pantalla == 1 && paso == 8) {
      if (((key >= 'a' && key <= 'z') || (key >= 'A' && key <= 'Z')) && entrada.length() < 2) {
        entrada = entrada + key;
      }
    } else {
      int maxLen = 9;
      if (pantalla == 1 && paso == 3) { maxLen = 4; }
      if (pantalla == 1 && (paso == 2 || paso == 4 || paso == 5 || paso == 6 || paso == 7)) { maxLen = 3; }
      if (pantalla == 6) { maxLen = 2; }
      if (key >= '0' && key <= '9' && entrada.length() < maxLen) { entrada = entrada + key; }
    }
  }
}

void confirmarRegistro() {
  mensajeError = "";
  aviso = "";
  String t = entrada.trim();
  int valor = 0;
  if (paso != 1 && paso != 8) {
    if (!soloDigitos(t)) {
      mensajeError = "Escribe solo numeros enteros (sin letras ni signos).";
      return;
    }
    valor = Integer.parseInt(t);
  }
  switch (paso) {
    case 1:
      if (t.equals("")) { mensajeError = "El nombre no puede estar vacio."; return; }
      nombre = t;
      nombreGuardado = t;
      paso = 2;
      break;
    case 2:
      if (valor < 1 || valor > 120) { mensajeError = "Edad no valida (1 a 120)."; return; }
      edad = valor;
      if (edad < 14) {
        aviso = "Aviso: se recomienda jugar con acompaniamiento de un adulto.";
      } else {
        aviso = "Perfecto, " + nombre + ". Tu mision como Guardian comienza.";
      }
      paso = 3;
      break;
    case 3:
      if (valor < 1 || valor > 9999) { mensajeError = "El anio debe estar entre 1 y 9999."; return; }
      anio = valor;
      paso = 4;
      break;
    case 4:
      if (valor < 1 || valor > 12) { mensajeError = "Mes no valido (1 a 12)."; return; }
      mes = valor;
      diasDelMes = diasEnMes(mes, anio);
      paso = 5;
      break;
    case 5:
      if (valor < 1 || valor > diasDelMes) {
        mensajeError = "Ese dia no existe en ese mes/anio (1 a " + diasDelMes + ").";
        return;
      }
      dia = valor;
      paso = 6;
      break;
    case 6:
      if (valor < 1 || valor > 12) { mensajeError = "Hora no valida (formato de 12 horas: 1 a 12)."; return; }
      hora12 = valor;
      paso = 7;
      break;
    case 7:
      if (valor < 0 || valor > 59) { mensajeError = "Minuto no valido (0 a 59)."; return; }
      minuto = valor;
      paso = 8;
      break;
    case 8:
      t = t.toLowerCase();
      if (t.equals("am") || t.equals("pm")) {
        franja = t;
        paso = 9;
      } else {
        mensajeError = "Franja no valida. Debe ser AM o PM.";
        return;
      }
      break;
    case 9:
      if (valor < 1) { mensajeError = "Las horas de uso deben ser 1 o mas."; return; }
      horasUso = valor;
      calcularSesion();
      pantalla = 2;
      break;
  }
  entrada = "";
}

// ====================================================================
// CALCULOS DE LA SESION (Parte_1): fechas, horas y puntos de riesgo
// ====================================================================
void calcularSesion() {
  esBisiesto = esBisiestoAnio(anio);

  if (franja.equals("am")) {
    if (hora12 == 12) { hora24 = 0; } else { hora24 = hora12; }
  } else {
    if (hora12 == 12) { hora24 = 12; } else { hora24 = hora12 + 12; }
  }

  switch (mes) {
    case 1: tValor = 0; break;
    case 2: tValor = 3; break;
    case 3: tValor = 2; break;
    case 4: tValor = 5; break;
    case 5: tValor = 0; break;
    case 6: tValor = 3; break;
    case 7: tValor = 5; break;
    case 8: tValor = 1; break;
    case 9: tValor = 4; break;
    case 10: tValor = 6; break;
    case 11: tValor = 2; break;
    case 12: tValor = 4; break;
    default: tValor = 0;
  }
  y = anio;
  if (mes < 3) { y = y - 1; }
  diaSemIng = (y + y / 4 - y / 100 + y / 400 + tValor + dia) % 7;

  restoHoras = horasUso % 24;
  sumaHoras = hora24 + restoHoras;
  diasExtra = horasUso / 24 + sumaHoras / 24;
  hora24S = sumaHoras % 24;

  yy = anio;
  if (mes <= 2) { yy = yy - 1; }
  era = yy / 400;
  yoe = yy - era * 400;
  if (mes > 2) { mp = mes - 3; } else { mp = mes + 9; }
  doy = (153 * mp + 2) / 5 + dia - 1;
  doe = yoe * 365 + yoe / 4 - yoe / 100 + doy;
  z = era * 146097 + doe + diasExtra;
  era = z / 146097;
  doe = z - era * 146097;
  yoe = (doe - doe / 1460 + doe / 36524 - doe / 146096) / 365;
  yy = yoe + era * 400;
  doy = doe - (365 * yoe + yoe / 4 - yoe / 100);
  mp = (5 * doy + 2) / 153;
  diaS = doy - (153 * mp + 2) / 5 + 1;
  if (mp < 10) { mesS = mp + 3; } else { mesS = mp - 9; }
  if (mesS <= 2) { yy = yy + 1; }
  anioS = yy;
  diaSemSal = (diaSemIng + diasExtra) % 7;

  if (horasUso >= 8) {
    ptsTiempo = 7;
    msgTiempo = "ALERTA: 8 horas o mas conectado. Riesgo ALTO de fatiga digital. (+7)";
  } else {
    if (horasUso > 3) {
      ptsTiempo = 4;
      msgTiempo = "Ojo: tu tiempo de uso es elevado (+4 de riesgo).";
    } else {
      ptsTiempo = 0;
      msgTiempo = "Excelente: tiempo de uso controlado. (+0)";
    }
  }

  segIngreso = hora24 * 3600 + minuto * 60;
  segSalida = hora24S * 3600 + minuto * 60 + 1;
  fueraHorario = false;
  if (segIngreso < 28800 || segIngreso > 72000) { fueraHorario = true; }
  if (diasExtra >= 1 || segSalida < 28800 || segSalida > 72000) { fueraHorario = true; }
  if (fueraHorario) {
    ptsHorario = 4;
    msgHorario = "Tu sesion toca horas de descanso (+4 de riesgo).";
  } else {
    ptsHorario = 0;
    msgHorario = "Tu sesion esta dentro del horario saludable. (+0)";
  }
  puntaje = ptsTiempo + ptsHorario;
}

// ====================================================================
// PANTALLA 2: RESUMEN DE LA SESION
// ====================================================================
void pantallaResumen() {
  if (imgResumen != null) {
    pantallaResumenImagen();
    return;
  }
  encabezado("RESUMEN DE TU SESION", "Calculos de fecha, hora y riesgo");
  p("Jugador: " + nombre + "     Edad: " + edad);
  espacio(8);
  pc("Fecha de ingreso : " + fechaTxt(dia, mes, anio, diaSemIng), 170, 215, 255);
  pc("Hora de ingreso  : " + horaTxt(hora24, minuto, 0), 170, 215, 255);
  pc("Fecha de salida  : " + fechaTxt(diaS, mesS, anioS, diaSemSal), 255, 230, 150);
  pc("Hora de salida   : " + horaTxt(hora24S, minuto, 1), 255, 230, 150);
  p("Horas de uso      : " + horasUso);
  if (esBisiesto) { p("El anio " + anio + " es bisiesto (febrero tiene 29 dias)."); }
  espacio(12);
  if (ptsTiempo == 0) { pc(msgTiempo, 120, 255, 140); } else { pc(msgTiempo, 255, 190, 90); }
  if (ptsHorario == 0) { pc(msgHorario, 120, 255, 140); } else { pc(msgHorario, 255, 190, 90); }
  espacio(8);
  pc("Puntaje de riesgo hasta ahora: " + puntaje, 255, 215, 0);
  if (boton(320, 600, 320, 50, "CONTINUAR (ENTER)")) {
    pantalla = 3;
  }
}

// ====================================================================
// PANTALLA 3: CONTENIDO CONSUMIDO
// ====================================================================
void pantallaContenido() {
  PImage img = imgContenido1;
  if (selecciones == 1) { img = imgContenido2; }
  if (img != null) {
    pantallaContenidoImagen(img);
    return;
  }
  encabezado("CONTENIDO CONSUMIDO", "Tipos de contenido que viste hoy (tambien puedes presionar las teclas 1 a 8)");
  if (selecciones == 0) {
    pc("Elige el PRIMER tipo de contenido:", 255, 215, 0);
  } else {
    pc("Elige el SEGUNDO tipo de contenido:", 255, 215, 0);
    pc("Primero elegiste: " + nombreContenido(contenido1), 120, 255, 140);
  }
  int elegida = 0;
  for (int i = 1; i <= 8; i++) {
    int px = 40 + ((i - 1) % 2) * 450;
    int py = 220 + ((i - 1) / 2) * 80;
    if (boton(px, py, 430, 60, i + ". " + nombreContenido(i))) {
      elegida = i;
    }
  }
  if (elegida > 0) { elegirContenido(elegida); }
}

void pantallaContenidoImagen(PImage img) {
  int yI = fondoImagen(img);
  int elegida = 0;
  for (int i = 1; i <= 8; i++) {
    float x0 = 198;
    if ((i - 1) % 2 == 1) { x0 = 856; }
    float y0 = 270 + ((i - 1) / 2) * 150;
    if (selecciones == 1 && i == contenido1) {
      marcoImg(x0, y0, 614, 132, yI, 80, 255, 120);
    }
    if (zona(x0, y0, 614, 132, yI)) { elegida = i; }
  }
  String arriba = "Elige el PRIMER tipo de contenido que viste hoy";
  if (selecciones == 1) { arriba = "Primero elegiste: " + nombreContenido(contenido1) + "   (marcado en verde)"; }
  franjas(arriba, "Haz clic en una opcion o usa las teclas 1 a 8", yI);
  if (elegida > 0) { elegirContenido(elegida); }
}

void elegirContenido(int n) {
  if (selecciones == 0) {
    contenido1 = n;
    selecciones = 1;
  } else {
    contenido2 = n;
    selecciones = 2;
    ptsContenido = puntosContenido(contenido1) + puntosContenido(contenido2);
    puntaje = puntaje + ptsContenido;
    if (ptsContenido == 0) {
      msgContenido = "Tu dieta de contenido es sana. Sigue asi!";
    } else {
      if (ptsContenido <= 3) {
        msgContenido = "Tu contenido es aceptable, pero verifica las fuentes.";
      } else {
        msgContenido = "Tu contenido es de riesgo: puede desinformarte o afectar tu animo.";
      }
    }
    pantalla = 4;
  }
}

// ====================================================================
// PANTALLA 4: HISTORIA BASE "MI DIA DIGITAL" + MENU PRINCIPAL
// ====================================================================
void pantallaMenu() {
  if (imgMenuDia != null) {
    pantallaMenuImagen();
    return;
  }
  encabezado("MI DIA DIGITAL", "Historia y menu principal");
  p(nombre + ", hoy es " + nombreDia(diaSemIng) + " " + dia + "/" + mes + "/" + anio + ".");
  p("Tu telefono vibra sin parar: SMS, chats y enlaces llegan desde");
  p("todas partes. Algunos son de amigos... otros son TRAMPAS.");
  p("Eres el Guardian de los Mensajes: tu mision es detectar mensajes");
  p("sospechosos, enlaces peligrosos y pedidos de datos personales.");
  p("Durante 7 dias virtuales cada decision cambiara tu Puntaje Digital");
  p("y tu final.");
  espacio(8);
  pc(msgContenido, 255, 230, 150);
  if (!mensajeError.equals("")) { pc(mensajeError, 255, 100, 100); }
  boolean c1 = boton(160, 400, 640, 56, "1. Revisar bandeja de mensajes (comenzar la semana)");
  boolean c2 = boton(160, 470, 640, 56, "2. Leer la guia del Guardian y comenzar");
  boolean c3 = boton(160, 540, 640, 56, "3. Salir");
  if (c1) {
    accionMenu(1);
  } else {
    if (c2) {
      accionMenu(2);
    } else {
      if (c3) { accionMenu(3); }
    }
  }
}

void accionMenu(int opcion) {
  mensajeError = "";
  switch (opcion) {
    case 1:
      empezarSemana();
      break;
    case 2:
      pantalla = 5;
      break;
    case 3:
      pantalla = 20;
      tSalida = millis();
      break;
    default:
      mensajeError = "Opcion no valida.";
  }
}

// ====================================================================
// PANTALLA 5: GUIA DEL GUARDIAN
// ====================================================================
void pantallaGuia() {
  if (imgGuia != null) {
    int yI = fondoImagen(imgGuia);
    boolean volver = zona(425, 815, 335, 95, yI);
    boolean comenzar = zona(800, 810, 470, 105, yI);
    franjas("Nivel 3: " + tiempoNivel3 + " segundos por decision   |   5 logros por desbloquear y un final secreto",
            "Cada dia indicaras cuantas horas usaras redes (1 a 24)   |   ENTER comenzar   |   ESC volver", yI);
    if (comenzar) {
      empezarSemana();
    } else {
      if (volver) { pantalla = 4; }
    }
    return;
  }
  encabezado("GUIA DEL GUARDIAN", "Lee con calma y luego comienza tu semana digital");
  p("- Un banco jamas te pide claves ni codigos por mensaje.");
  p("- Desconfia de premios, urgencias y enlaces acortados.");
  p("- Verifica por otro canal antes de enviar dinero o datos.");
  p("- Nunca compartas codigos de verificacion.");
  p("- Antes de reenviar una noticia, busca su fuente oficial.");
  p("- Cuida tu privacidad: perfil privado y ubicacion apagada.");
  p("- Descansa: pocas horas en redes y buen horario ayudan a tu bienestar.");
  espacio(10);
  pc("REGLAS DEL JUEGO", 255, 215, 0);
  p("- Es un puntaje de RIESGO: entre menos puntos, mejor.");
  p("- Nivel 1 (dias 1-2): reglas basicas.");
  p("- Nivel 2 (dias 3-4): cada error suma +1 de riesgo extra.");
  p("- Nivel 3 (dias 5-7): cada error suma +2 y tienes " + tiempoNivel3 + " segundos por decision.");
  p("- Cada dia debes indicar cuantas horas usaras redes (1 a 24).");
  p("- Hay 5 logros por desbloquear y un final secreto.");
  boolean c1 = boton(160, 600, 300, 50, "COMENZAR (ENTER)");
  boolean c2 = boton(500, 600, 300, 50, "VOLVER (ESC)");
  if (c1) {
    empezarSemana();
  } else {
    if (c2) { pantalla = 4; }
  }
}

// ====================================================================
// SEMANA DIGITAL: inicio, dias y situaciones
// ====================================================================
void empezarSemana() {
  diaJuego = 1;
  fecAnio = anio;
  fecMes = mes;
  fecDia = dia;
  fecSem = diaSemIng;
  horasHoy = horasUso;
  horasTotales = horasUso;
  diasControlados = 0;
  if (horasUso <= 3) { diasControlados = diasControlados + 1; }
  iniciarDia();
}

void iniciarDia() {
  if (diaJuego <= 2) {
    nivel = 1;
  } else {
    if (diaJuego <= 4) { nivel = 2; } else { nivel = 3; }
  }
  switch (diaJuego) {
    case 1:
      temaDia = "Uso de redes";
      descDia = "Hoy empiezas a revisar tu bandeja: llegan mensajes de bancos y de desconocidos.";
      break;
    case 2:
      temaDia = "Noticias falsas y cadenas";
      descDia = "Hoy circulan cadenas, rumores y premios: no todo lo que brilla es verdad.";
      break;
    case 3:
      temaDia = "Privacidad";
      descDia = "Hoy lo importante es proteger tus datos: archivos, ubicacion y perfil.";
      break;
    case 4:
      temaDia = "Tiempo de pantalla";
      descDia = "Hoy luchas contra las notificaciones y el scroll infinito.";
      break;
    case 5:
      temaDia = "Mensajes sospechosos";
      descDia = "Hoy llegan mensajes muy sospechosos: amigos hackeados y becas falsas.";
      break;
    case 6:
      temaDia = "Bienestar digital";
      descDia = "Hoy cuidas tu bienestar: respeto en el chat y presion de retos virales.";
      break;
    default:
      temaDia = "Evaluacion final";
      descDia = "EVALUACION FINAL: el Gran Estafador intenta enganarte con todo a la vez.";
  }
  if (diaJuego == 7) { sitsDelDia = 1; } else { sitsDelDia = 2; }
  aciertosDia = 0;
  ptsDia = 0;
  msgFatiga = "";
  avisoLogros = "";
  entrada = "";
  mensajeError = "";
  pantalla = 6;
}

void pantallaDia() {
  if (imgDia != null) {
    pantallaDiaImagen();
    return;
  }
  encabezado("DIA " + diaJuego + " DE 7: " + temaDia.toUpperCase(),
             "Nivel " + nivel + ": " + nombreNivel(nivel) + "   |   " + fechaTxt(fecDia, fecMes, fecAnio, fecSem));
  if (diaJuego == 1 || diaJuego == 3 || diaJuego == 5) {
    pc("NUEVO NIVEL!", 255, 215, 0);
  }
  switch (nivel) {
    case 1:
      parrafoColor("NIVEL 1 - PRINCIPIANTE DIGITAL: aprendes las reglas basicas.", 78, 170, 215, 255);
      break;
    case 2:
      parrafoColor("NIVEL 2 - USUARIO FRECUENTE: las decisiones tienen consecuencias mas importantes (cada error suma +1 de riesgo extra).", 78, 255, 190, 90);
      break;
    default:
      parrafoColor("NIVEL 3 - EXPERTO DIGITAL: situaciones mas exigentes. Tienes " + tiempoNivel3 + " segundos por decision y cada error suma +2 de riesgo extra.", 78, 255, 120, 120);
  }
  espacio(6);
  parrafo(descDia, 78);
  espacio(10);
  if (diaJuego == 1) {
    p("Tus horas de uso de hoy ya fueron registradas: " + horasUso + " h.");
    if (boton(320, 600, 320, 50, "COMENZAR EL DIA (ENTER)")) {
      confirmarDia();
    }
  } else {
    pc("Cuantas horas usaras redes sociales hoy? (1 a 24)", 255, 215, 0);
    int yCaja = cursorY + 6;
    fill(255);
    stroke(255, 215, 0);
    strokeWeight(3);
    rect(40, yCaja, 200, 50, 10);
    noStroke();
    fill(20);
    textSize(26);
    String parpadeo = "";
    if ((millis() / 500) % 2 == 0) { parpadeo = "_"; }
    text(entrada + parpadeo, 55, yCaja + 10);
    cursorY = yCaja + 66;
    if (!mensajeError.equals("")) { pc(mensajeError, 255, 100, 100); }
    if (boton(320, 600, 320, 50, "CONFIRMAR (ENTER)")) {
      confirmarDia();
    }
  }
}

void confirmarDia() {
  mensajeError = "";
  if (diaJuego > 1) {
    String t = entrada.trim();
    if (!soloDigitos(t)) {
      mensajeError = "Escribe solo numeros enteros.";
      return;
    }
    int v = Integer.parseInt(t);
    if (v < 1 || v > 24) {
      mensajeError = "Las horas de uso del dia deben estar entre 1 y 24.";
      return;
    }
    horasHoy = v;
    horasTotales = horasTotales + horasHoy;
    if (horasHoy <= 3) { diasControlados = diasControlados + 1; }
    int fat = 0;
    if (horasHoy >= 8) {
      fat = 3;
    } else {
      if (horasHoy > 3) { fat = 1; }
    }
    puntaje = puntaje + fat;
    ptsFatiga = ptsFatiga + fat;
    ptsDia = ptsDia + fat;
    if (fat > 0) { msgFatiga = "Fatiga digital por " + horasHoy + " h de uso: +" + fat + " de riesgo."; }
  }
  numSit = (diaJuego - 1) * 2 + 1;
  sitEnDia = 1;
  cargarSituacion(numSit);
  inicioSit = millis();
  entrada = "";
  pantalla = 7;
}

// ====================================================================
// SITUACIONES DE DECISION
// ====================================================================

void sit(String l1, String l2,
         String o1, int q1, String f1,
         String o2, int q2, String f2,
         String o3, int q3, String f3,
         String o4, int q4, String f4) {
  sL1 = l1;  sL2 = l2;
  sOp1 = o1; sP1 = q1; sFb1 = f1;
  sOp2 = o2; sP2 = q2; sFb2 = f2;
  sOp3 = o3; sP3 = q3; sFb3 = f3;
  sOp4 = o4; sP4 = q4; sFb4 = f4;
}

void cargarSituacion(int n) {
  switch (n) {
    case 1:
      sit("Llega un SMS: 'BancoSeguro: tu cuenta sera BLOQUEADA en 1 hora.",
          "Ingresa a bit.ly/segur0-banco y confirma tu clave.'",
          "Ingreso al enlace y escribo mi clave", 5,
          "Phishing! Entregaste tu clave a un delincuente.",
          "Ignoro y elimino el mensaje", 0,
          "Bien: no caiste. Reportarlo habria sido aun mejor.",
          "Verifico en la app oficial y reporto el SMS como estafa", 0,
          "Excelente! Verificaste por un canal oficial.",
          "Lo reenvio a mis amigos para 'avisarles' sin verificar", 2,
          "Propagaste un mensaje falso sin verificar.");
      break;
    case 2:
      sit("Un desconocido te escribe: 'Hola, te llego un codigo de 6 digitos",
          "por error, me lo pasas porfa?'",
          "Se lo doy, parece amable", 6,
          "Entregaste un codigo de verificacion: pueden robarte la cuenta.",
          "Me niego y lo bloqueo", 0,
          "Correcto! Los codigos NUNCA se comparten.",
          "Le pregunto quien es antes de decidir", 2,
          "Entablar charla con un desconocido te expone a mas enganos.",
          "Me niego, lo bloqueo y lo reporto", 0,
          "Guardian ejemplar! Bloqueaste y reportaste.");
      break;
    case 3:
      sit("Llega a todos tus grupos: 'URGENTE! Manana NO habra clases por una",
          "alerta nacional. Reenvia a todos!'. No trae fuente ni enlace oficial.",
          "Lo reenvio a todos mis grupos, por si acaso", 3,
          "Difundiste una noticia falsa y causaste confusion en el curso.",
          "Busco el comunicado en la pagina oficial del colegio", 0,
          "Excelente! Contrastaste la noticia con una fuente oficial.",
          "Pregunto en el grupo si alguien sabe algo mas", 1,
          "Sin verificar en una fuente oficial, el rumor sigue vivo.",
          "Lo ignoro: sin fuente confiable no lo comparto", 0,
          "Bien! Cortaste la cadena y no ayudaste a la desinformacion.");
      break;
    case 4:
      sit("Mensaje: 'Ganaste un smartphone! Reclamalo en tinyurl.com/premio-hoy",
          "y comparte con 10 contactos.'",
          "Abro el enlace para ver de que se trata", 4,
          "El enlace abrio un formulario falso que pedia cedula, direccion y tarjeta. Abrir enlaces de premios que no pediste ya es un riesgo.",
          "Ignoro: nunca participe en ningun sorteo", 0,
          "Bien! Si no participaste, no pudiste ganar.",
          "Lo comparto con 10 contactos por si es real", 3,
          "Ayudaste a que la estafa se propague.",
          "Bloqueo al remitente y lo reporto", 0,
          "Excelente! Cortaste la cadena de la estafa.");
      break;
    case 5:
      sit("En el grupo del curso, un contacto envia: 'Notas_finales.apk'",
          "sin ningun mensaje adicional.",
          "Lo descargo e instalo de una vez", 5,
          "Un .apk desconocido puede instalar malware espia.",
          "Le pregunto por otro medio si realmente lo envio", 0,
          "Muy bien! Verificaste con el remitente por otro canal.",
          "Lo descargo, pero solo lo abro despues de escanearlo", 1,
          "Mejor que nada, pero descargarlo ya es un riesgo.",
          "No lo abro y aviso al grupo y al administrador", 0,
          "Guardian ejemplar! Protegiste a todo el grupo.");
      break;
    case 6:
      sit("Tu red social te sugiere activar 'Ubicacion en vivo' y dejar el",
          "perfil PUBLICO para ganar mas seguidores.",
          "Activo todo: mas seguidores, mas popularidad", 4,
          "Cualquiera podria saber donde estudias y a que hora sales.",
          "Perfil privado y ubicacion solo cuando la necesito", 0,
          "Excelente! Controlas quien ve tus datos.",
          "Dejo el perfil publico, pero sin ubicacion", 1,
          "Mejor, pero un perfil publico expone tus fotos y datos.",
          "Perfil privado, ubicacion apagada y reviso mis seguidores", 0,
          "Guardian de la privacidad! Tus cuentas quedan protegidas.");
      break;
    case 7:
      sit("Son las 2:00 a.m. y manana hay examen, pero tu celular no deja",
          "de vibrar con las notificaciones de un chat grupal.",
          "Reviso cada notificacion hasta que se calme", 4,
          "El sueno perdido te pasara factura en el examen.",
          "Silencio el chat y activo 'No molestar'", 0,
          "Bien! Protegiste tu descanso.",
          "Dejo el celular cargando lejos de la cama", 0,
          "Excelente habito: dormiras mejor y rendiras mas.",
          "Contesto 'solo un ratito' y sigo chateando", 3,
          "Un ratito se volvio una hora y dormiste muy poco.");
      break;
    case 8:
      sit("Estudias para el examen, pero un video te recomienda otro... y otro.",
          "Ya llevas 2 horas atrapado en el scroll infinito.",
          "Un video mas y luego estudio", 3,
          "El scroll infinito te atrapo: se fue la tarde.",
          "Temporizador de 25 minutos de estudio con el celular lejos", 0,
          "Excelente! Gestionas bien tu tiempo de pantalla.",
          "Cierro la app y estudio sin mirar el celular", 0,
          "Gran autocontrol! Recuperaste tu tiempo.",
          "Sigo viendo: manana estudio con calma", 3,
          "Aplazar el estudio por el scroll te cobrara el examen.");
      break;
    case 9:
      sit("Tu mejor amigo te escribe: 'Mi cuenta bancaria esta bloqueada,",
          "es urgente! Transfiereme $150.000 ya, te lo devuelvo hoy.'",
          "Hago la transferencia: es mi amigo", 6,
          "Transferiste dinero a un estafador que suplanto a tu amigo.",
          "Lo llamo por telefono para confirmar que sea el", 0,
          "Excelente! Verificar por otro canal es la clave.",
          "Le pido que responda una pregunta personal por el mismo chat", 1,
          "Bien pensado, pero si su cuenta fue hackeada el chat no es seguro.",
          "Lo ignoro y no le cuento a nadie", 1,
          "No caiste, pero tu amigo puede estar en peligro. Avisale.");
      break;
    case 10:
      sit("Un perfil de 'Oficina de Becas' te escribe: 'Ganaste una beca del",
          "100%! Paga $50.000 de inscripcion hoy o la pierdes.'",
          "Pago de inmediato para no perder la beca", 6,
          "Pagaste a un estafador: ninguna beca real cobra por adelantado.",
          "Busco la convocatoria en el sitio oficial de la entidad", 0,
          "Excelente! Verificaste la oferta en la fuente oficial.",
          "Le pido mas informacion por el mismo chat", 2,
          "Seguir hablando con el estafador te expone a mas enganos.",
          "Bloqueo el perfil y lo reporto como falso", 0,
          "Guardian ejemplar! Reportaste un perfil falso.");
      break;
    case 11:
      sit("En el grupo del curso se burlan de un companero con memes y le",
          "piden que se salga del grupo.",
          "Me rio y reenvio los memes", 4,
          "Participar en el acoso lastima a una persona real.",
          "No hago nada: no es mi problema", 2,
          "Callar tambien ayuda al acoso. Puedes hacer mas.",
          "Le escribo al companero para apoyarlo y reporto los memes", 0,
          "Excelente! La empatia digital cuenta.",
          "Aviso a un profesor o al coordinador con las capturas", 0,
          "Muy bien! Pediste ayuda a un adulto de confianza.");
      break;
    case 12:
      sit("Se viraliza el reto 'Aguanta 48 horas sin dormir' y todos tus",
          "contactos publican sus videos.",
          "Acepto el reto y lo subo", 4,
          "Dormir poco afecta tu salud, tu animo y tus notas.",
          "No lo hago y descanso lo necesario", 0,
          "Excelente! Tu bienestar es lo primero.",
          "Lo hago a medias para no quedar mal", 2,
          "Cedes a la presion del grupo y tu descanso se resiente.",
          "No participo y comparto por que es peligroso", 0,
          "Influencer responsable! Usaste tu voz para cuidar a otros.");
      break;
    default:
      sit("JEFE FINAL: el GRAN ESTAFADOR te escribe con tu nombre y tu colegio:",
          "'Ganaste una beca! Confirma tu codigo de verificacion en 5 minutos.'",
          "Le doy el codigo: sabe mis datos, debe ser real", 6,
          "Entregaste tu codigo de verificacion: el estafador entro a tu cuenta. Que sepa tus datos no lo hace de confianza.",
          "Bloqueo, reporto y cambio mis claves por precaucion", 0,
          "Excelente! No compartiste el codigo y cuidaste tus cuentas.",
          "Verifico con el colegio por otro canal y reporto el mensaje", 0,
          "Guardian supremo! Verificaste por un canal oficial.",
          "Le pregunto su nombre y de que area es", 2,
          "Hablar con el estafador le da tiempo para presionarte.");
  }
}

void pantallaSituacion() {
  PImage img = imagenSituacion(numSit);
  if (img != null) {
    pantallaSituacionImagen(img);
    return;
  }
  encabezado("DIA " + diaJuego + " - " + temaDia,
             "Nivel " + nivel + ": " + nombreNivel(nivel) + "   |   Situacion " + sitEnDia + " de " + sitsDelDia
             + "   |   Riesgo: " + puntaje);
  if (nivel == 3) {
    int msRestante = tiempoNivel3 * 1000 - (millis() - inicioSit);
    if (msRestante <= 0) {
      resolver(0);
      return;
    }
    int ancho = (int) (300 * (float) msRestante / (tiempoNivel3 * 1000));
    fill(255, 120, 120);
    textSize(16);
    text("Tiempo: " + (msRestante / 1000 + 1) + " s", 640, 66);
    fill(60, 72, 104);
    rect(700, 66, 220, 14, 6);
    fill(255, 120, 120);
    rect(700, 66, ancho * 220 / 300, 14, 6);
  }
  if (numSit == TOTAL_SITUACIONES) {
    pc("SITUACION " + numSit + " - JEFE FINAL", 255, 120, 120);
  } else {
    pc("SITUACION " + numSit, 255, 215, 0);
  }
  p(sL1);
  p(sL2);
  int yb = cursorY + 24;
  boolean c1 = boton(40, yb, 880, 54, "1. " + sOp1);
  boolean c2 = boton(40, yb + 66, 880, 54, "2. " + sOp2);
  boolean c3 = boton(40, yb + 132, 880, 54, "3. " + sOp3);
  boolean c4 = boton(40, yb + 198, 880, 54, "4. " + sOp4);
  fill(170, 215, 255);
  textSize(16);
  text("Tambien puedes presionar las teclas 1, 2, 3 o 4.", 40, 640);
  if (c1) {
    resolver(1);
  } else {
    if (c2) {
      resolver(2);
    } else {
      if (c3) {
        resolver(3);
      } else {
        if (c4) { resolver(4); }
      }
    }
  }
}

void pantallaSituacionImagen(PImage img) {
  int yImg = (ALTO - altoImg(img)) / 2;
  int msRestante = 0;
  if (nivel == 3) {
    msRestante = tiempoNivel3 * 1000 - (millis() - inicioSit);
    if (msRestante <= 0) {
      resolver(0);
      return;
    }
  }
  image(img, 0, yImg, ANCHO, altoImg(img));
  int elegida = 0;
  for (int i = 1; i <= 4; i++) {
    if (sobreOpcion(i, yImg)) {
      manoCursor = true;
      float x0 = 70;
      if ((i - 1) % 2 == 1) { x0 = 845; }
      float y0 = 612;
      if ((i - 1) / 2 == 1) { y0 = 757; }
      resaltarZona(x0, y0, 750, 138, yImg);
      if (clic) { elegida = i; }
    }
  }
  textAlign(LEFT, CENTER);
  textSize(17);
  if (numSit == TOTAL_SITUACIONES) { fill(255, 120, 120); } else { fill(255, 215, 0); }
  text("DIA " + diaJuego + " - " + temaDia.toUpperCase(), 20, yImg / 2 - 12);
  fill(170, 215, 255);
  textSize(15);
  String guardian = "";
  if (recordarNombre && !nombre.equals("")) { guardian = "   |   Guardian: " + nombre; }
  text("Nivel " + nivel + ": " + nombreNivel(nivel) + "   |   Situacion " + sitEnDia + " de " + sitsDelDia + guardian, 20, yImg / 2 + 12);
  textAlign(RIGHT, CENTER);
  textSize(20);
  fill(255, 215, 0);
  text("Riesgo: " + puntaje, ANCHO - 20, yImg / 2);
  float yAbajo = ALTO - yImg / 2;
  textAlign(LEFT, CENTER);
  textSize(15);
  fill(170, 215, 255);
  text("Haz clic en una opcion o usa las teclas A, B, C, D (o 1 a 4)", 20, yAbajo);
  if (nivel == 3) {
    float ancho = 260 * (float) msRestante / (tiempoNivel3 * 1000);
    fill(255, 120, 120);
    textAlign(RIGHT, CENTER);
    textSize(17);
    text("Tiempo: " + (msRestante / 1000 + 1) + " s", ANCHO - 290, yAbajo);
    fill(60, 72, 104);
    rect(ANCHO - 280, yAbajo - 8, 260, 16, 6);
    fill(255, 120, 120);
    rect(ANCHO - 280, yAbajo - 8, ancho, 16, 6);
  }
  textAlign(LEFT, TOP);
  if (elegida > 0) { resolver(elegida); }
}

void resolver(int opcion) {
  int base = 0;
  String fb = "";
  switch (opcion) {
    case 1: base = sP1; fb = sFb1; break;
    case 2: base = sP2; fb = sFb2; break;
    case 3: base = sP3; fb = sFb3; break;
    case 4: base = sP4; fb = sFb4; break;
    default:
      base = 3;
      fb = "Se acabo el tiempo: dudaste y la amenaza avanzo.";
  }
  if (numSit == 2 && opcion == 1) {
    if (edad < 18) {
      base = base + 2;
      fb = fb + " Como menor de edad, el riesgo de suplantacion es mayor (riesgo extra).";
    } else {
      if (fueraHorario) {
        base = base + 1;
        fb = fb + " El cansancio de la noche bajo tu guardia (riesgo extra).";
      }
    }
  }
  if (numSit == 9 && opcion == 1) {
    if (horasHoy >= 8) {
      base = base + 1;
      fb = fb + " Tantas horas conectado te hicieron bajar la guardia (fatiga digital).";
    }
  }
  aplicarDecision(base, fb);
}

void aplicarDecision(int base, String fb) {
  int pts = base;
  if (base > 0) { pts = base + (nivel - 1); }
  puntaje = puntaje + pts;
  ptsDecisiones = ptsDecisiones + pts;
  ptsDia = ptsDia + pts;
  ultimoPts = pts;
  ultimoFb = fb;
  if (base == 0) {
    ultimaCorrecta = true;
    correctas = correctas + 1;
    aciertosDia = aciertosDia + 1;
    racha = racha + 1;
    if (racha > mejorRacha) { mejorRacha = racha; }
  } else {
    ultimaCorrecta = false;
    incorrectas = incorrectas + 1;
    racha = 0;
  }
  switch (nivel) {
    case 1:
      respN1 = respN1 + 1;
      if (base == 0) { acN1 = acN1 + 1; }
      break;
    case 2:
      respN2 = respN2 + 1;
      if (base == 0) { acN2 = acN2 + 1; }
      break;
    default:
      respN3 = respN3 + 1;
      if (base == 0) { acN3 = acN3 + 1; }
  }
  if (mejorRacha >= 5 && !logroRacha) {
    logroRacha = true;
    avisoLogros = avisoLogros + "LOGRO DESBLOQUEADO: Racha de Hierro (5 aciertos seguidos)\n";
  }
  pantalla = 9;
}

void pantallaResultado() {
  PImage img = imgIncorrecta;
  if (ultimaCorrecta) { img = imgCorrecta; }
  if (img != null) {
    pantallaResultadoImagen(img);
    return;
  }
  encabezado("RESULTADO DE TU DECISION", "Dia " + diaJuego + " - " + temaDia + "   |   Situacion " + sitEnDia + " de " + sitsDelDia);
  if (ultimaCorrecta) {
    pc("DECISION CORRECTA", 120, 255, 140);
  } else {
    pc("DECISION INCORRECTA", 255, 100, 100);
  }
  espacio(6);
  parrafo(ultimoFb, 78);
  espacio(10);
  if (ultimaCorrecta) {
    pc("Puntos de riesgo: +0", 120, 255, 140);
  } else {
    pc("Puntos de riesgo: +" + ultimoPts + "   (nivel " + nivel + ")", 255, 190, 90);
  }
  p("Puntaje de riesgo acumulado: " + puntaje);
  p("Racha de aciertos: " + racha + "   |   Mejor racha: " + mejorRacha);
  if (!avisoLogros.equals("")) {
    espacio(8);
    pBloque(avisoLogros);
  }
  if (boton(320, 600, 320, 50, "CONTINUAR (ENTER)")) {
    continuarDespuesDeDecision();
  }
}

void pantallaResultadoImagen(PImage img) {
  int yImg = (ALTO - altoImg(img)) / 2;
  float e = ANCHO / 1672.0;
  image(img, 0, yImg, ANCHO, altoImg(img));
  fill(10, 12, 40, 200);
  stroke(120, 200, 255);
  strokeWeight(2);
  rect(480 * e, yImg + 400 * e, 1120 * e, 155 * e, 10);
  noStroke();
  fill(255);
  textAlign(LEFT, TOP);
  textSize(16);
  textoEnCaja(ultimoFb, 480 * e + 14, yImg + 400 * e + 10, 70, 22);
  boolean sobreContinuar = (mx >= 585 * e && mx <= 1225 * e
                            && my >= yImg + 575 * e && my <= yImg + 725 * e);
  if (sobreContinuar) {
    manoCursor = true;
    resaltarZona(585, 575, 640, 150, yImg);
  }
  textAlign(LEFT, CENTER);
  textSize(16);
  fill(170, 215, 255);
  text("Dia " + diaJuego + " - " + temaDia + "   |   Situacion " + sitEnDia + " de " + sitsDelDia, 20, yImg / 2 - 12);
  if (!avisoLogros.equals("")) {
    fill(120, 255, 140);
    text(avisoLogros.trim().replace("\n", "   |   "), 20, yImg / 2 + 12);
  }
  float yAbajo = ALTO - yImg / 2;
  textSize(17);
  if (ultimaCorrecta) {
    fill(120, 255, 140);
    text("Puntos de riesgo: +0", 20, yAbajo);
  } else {
    fill(255, 190, 90);
    text("Puntos de riesgo: +" + ultimoPts + " (nivel " + nivel + ")", 20, yAbajo);
  }
  fill(255, 215, 0);
  textAlign(CENTER, CENTER);
  text("Riesgo acumulado: " + puntaje, ANCHO / 2 + 40, yAbajo);
  fill(170, 215, 255);
  textAlign(RIGHT, CENTER);
  text("Racha: " + racha + "  (mejor: " + mejorRacha + ")", ANCHO - 20, yAbajo);
  textAlign(LEFT, TOP);
  if (sobreContinuar && clic) { continuarDespuesDeDecision(); }
}

void continuarDespuesDeDecision() {
  if (sitEnDia < sitsDelDia) {
    sitEnDia = sitEnDia + 1;
    numSit = numSit + 1;
    cargarSituacion(numSit);
    inicioSit = millis();
    pantalla = 7;
  } else {
    cerrarDia();
  }
}

// ====================================================================
// CIERRE DE DIA: logros, bitacora y barra de progreso
// ====================================================================
void cerrarDia() {
  switch (diaJuego) {
    case 2:
      if (aciertosDia == 2 && !logroFake) {
        logroFake = true;
        avisoLogros = avisoLogros + "LOGRO DESBLOQUEADO: Detective de Fake News\n";
      }
      break;
    case 3:
      if (aciertosDia == 2 && !logroPriv) {
        logroPriv = true;
        avisoLogros = avisoLogros + "LOGRO DESBLOQUEADO: Guardian de la Privacidad\n";
      }
      break;
    case 6:
      if (aciertosDia == 2 && !logroBienestar) {
        logroBienestar = true;
        avisoLogros = avisoLogros + "LOGRO DESBLOQUEADO: Experto en Bienestar Digital\n";
      }
      break;
    case 7:
      if (diasControlados >= 4 && !logroTiempo) {
        logroTiempo = true;
        avisoLogros = avisoLogros + "LOGRO DESBLOQUEADO: Rey del Tiempo\n";
      }
      break;
  }
  bitacora = bitacora + "Dia " + diaJuego + " - " + temaDia + ": " + aciertosDia + "/" + sitsDelDia
             + " correctas, +" + ptsDia + " pts (" + horasHoy + " h de uso)\n";
  if (diaJuego <= 3) {
    ptsPrimera = ptsPrimera + ptsDia;
  } else {
    ptsSegunda = ptsSegunda + ptsDia;
  }
  pantalla = 10;
}

void pantallaCierre() {
  if (imagenCierre() != null) {
    pantallaCierreImagen(imagenCierre());
    return;
  }
  encabezado("DIA " + diaJuego + " COMPLETADO", temaDia + "   |   " + fechaTxt(fecDia, fecMes, fecAnio, fecSem));
  p("Decisiones correctas hoy: " + aciertosDia + " de " + sitsDelDia + "     Riesgo sumado hoy: +" + ptsDia);
  p("Horas de uso hoy: " + horasHoy + "     Horas acumuladas: " + horasTotales);
  if (!msgFatiga.equals("")) { pc(msgFatiga, 255, 190, 90); }
  espacio(10);
  pc("BARRA DE PROGRESO", 255, 215, 0);
  int yb = cursorY + 4;
  barra("Nivel 1", 40, yb, (respN1 * 10) / 4, 10, respN1 + "/4");
  barra("Nivel 2", 40, yb + 34, (respN2 * 10) / 4, 10, respN2 + "/4");
  barra("Nivel 3", 40, yb + 68, (respN3 * 10) / 5, 10, respN3 + "/5");
  barra("Semana", 40, yb + 102, diaJuego, 7, "dia " + diaJuego + " de 7");
  cursorY = yb + 140;
  if (!avisoLogros.equals("")) {
    pBloque(avisoLogros);
  }
  fill(255, 215, 0);
  textSize(19);
  text("Puntaje de riesgo acumulado: " + puntaje, 40, 560);
  String etiqueta = "SIGUIENTE DIA (ENTER)";
  if (diaJuego == 7) { etiqueta = "VER MI FINAL (ENTER)"; }
  if (boton(320, 600, 320, 50, etiqueta)) {
    avanzarDesdeCierre();
  }
}

void avanzarDesdeCierre() {
  if (diaJuego < 7) {
    siguienteDia();
  } else {
    terminarSemana();
  }
}

void siguienteDia() {
  diaJuego = diaJuego + 1;
  fecDia = fecDia + 1;
  while (fecDia > diasEnMes(fecMes, fecAnio)) {
    fecDia = fecDia - diasEnMes(fecMes, fecAnio);
    fecMes = fecMes + 1;
    if (fecMes > 12) {
      fecMes = 1;
      fecAnio = fecAnio + 1;
    }
  }
  fecSem = (fecSem + 1) % 7;
  iniciarDia();
}

// ====================================================================
// FINAL DE LA SEMANA: estadisticas, clasificacion y tipo de final
// ====================================================================
void terminarSemana() {
  diasCompletos = 0;
  horasRest = horasTotales;
  do {
    if (horasRest >= 24) {
      horasRest = horasRest - 24;
      diasCompletos = diasCompletos + 1;
    }
  } while (horasRest >= 24);

  promedioDiario = horasTotales / 7.0f;
  int diasAnio = 365;
  if (esBisiesto) { diasAnio = 366; }
  diasEquivAnio = promedioDiario * diasAnio / 24.0f;

  if (puntaje < LIM_EJEMPLAR) {
    clasificacion = "Ciudadano Digital Ejemplar";
  } else {
    if (puntaje <= LIM_RESPONSABLE) {
      clasificacion = "Usuario Digital Responsable";
    } else {
      if (puntaje <= LIM_RIESGO) {
        clasificacion = "Usuario en Riesgo";
      } else {
        clasificacion = "Dependencia Digital Alta";
      }
    }
  }
  if (puntaje < 5) {
    diagnostico = "Uso saludable de redes sociales.";
  } else {
    if (puntaje <= 13) {
      diagnostico = "Debe mejorar algunos habitos digitales.";
    } else {
      diagnostico = "Uso no saludable de redes sociales.";
    }
  }
  if (correctas == TOTAL_SITUACIONES && puntaje == 0) {
    tipoFinal = 0;
  } else {
    if (puntaje < 5) {
      tipoFinal = 1;
    } else {
      if (puntaje <= 13) { tipoFinal = 2; } else { tipoFinal = 3; }
    }
  }
  nivelesSuperados = 0;
  if (acN1 * 2 >= 4) { nivelesSuperados = nivelesSuperados + 1; }
  if (acN2 * 2 >= 4) { nivelesSuperados = nivelesSuperados + 1; }
  if (acN3 * 2 >= 5) { nivelesSuperados = nivelesSuperados + 1; }
  if (mejorPuntaje < 0 || puntaje < mejorPuntaje) { mejorPuntaje = puntaje; }
  if (logroFake) { histFake = true; }
  if (logroPriv) { histPriv = true; }
  if (logroTiempo) { histTiempo = true; }
  if (logroBienestar) { histBienestar = true; }
  if (logroRacha) { histRacha = true; }
  pantalla = 11;
}

// ====================================================================
// PANTALLA 11: FINAL
// ====================================================================
void pantallaFinal() {
  PImage img = imagenFinal();
  if (img != null) {
    pantallaFinalImagen(img);
    return;
  }
  switch (tipoFinal) {
    case 0:
      encabezado("* FINAL SECRETO: GUARDIAN SUPREMO *", "Lograste lo imposible: una semana perfecta");
      parrafo("Al terminar la semana, el coordinador de tu colegio recibe un reporte: alguien detuvo, en siete dias, un falso banco, un ladron de codigos, una noticia falsa, un premio trampa, un archivo espia, un amigo suplantado, una beca falsa y hasta al GRAN ESTAFADOR.", 80);
      p("Ese alguien eres tu, " + nombre + ".");
      espacio(10);
      parrafo("Gracias a tus decisiones, nadie en tu curso cayo en las estafas. Tus companeros aprendieron a verificar antes de actuar, y las cadenas de mensajes falsos se cortaron en tu telefono.", 80);
      espacio(10);
      pc("El coordinador te entrega la medalla de EMBAJADOR DIGITAL.", 255, 215, 0);
      p("Tu mision ya no es solo protegerte: ahora ensenaras a otros.");
      espacio(10);
      pc("Tus decisiones digitales construyen tu futuro... y el de todos.", 120, 255, 140);
      break;
    case 1:
      encabezado("* FINAL BUENO: GUARDIAN LEGENDARIO *", "Diagnostico: " + diagnostico);
      parrafo("Termina la semana y, " + nombre + ", guardas el celular para alistar tus cuadernos de manana. Supiste cuando conectarte y cuando parar, y cuidaste lo que veias y lo que compartias.", 80);
      espacio(10);
      if (incorrectas == 0) {
        parrafo("Ningun banco falso, ladron de codigos, premio trampa, archivo espia o amigo suplantado logro enganarte: detectaste las 13 amenazas de la semana.", 80);
      } else {
        parrafo("Tuviste algun pequeno tropiezo, pero lo corregiste a tiempo y tus buenos habitos evitaron que el problema llegara al grupo del curso.", 80);
      }
      espacio(10);
      parrafo("Al dia siguiente, en el colegio o la universidad, tus companeros te piden ayuda para proteger sus cuentas. Hasta tu profesor te pide que expliques al curso como detectar una estafa.", 80);
      espacio(10);
      pc("El coordinador te nombra GUARDIAN LEGENDARIO del plantel.", 255, 215, 0);
      pc("Tus decisiones digitales construyen tu futuro. Sigue asi!", 120, 255, 140);
      break;
    case 2:
      encabezado("* FINAL REGULAR: GUARDIAN EN ENTRENAMIENTO *", "Diagnostico: " + diagnostico);
      parrafo("Al terminar la semana, " + nombre + ", revisas tu celular con alivio y algo de preocupacion: todavia tienes tareas pendientes y no todo salio como esperabas en las redes.", 80);
      espacio(10);
      if (correctas >= 7) {
        parrafo("Detuviste varias trampas y eso salvo a tus companeros de caer, pero algunas malas decisiones dejaron grietas en tu seguridad.", 80);
      } else {
        parrafo("Las trampas te rodearon varias veces y solo algunas fallaron. Tuviste suerte de que el dano no fuera mayor.", 80);
      }
      espacio(10);
      if (ptsSegunda * 3 < ptsPrimera * 4) {
        parrafoColor("Pero hubo mejoras: tus ultimos dias fueron mas seguros que los primeros. Estas aprendiendo!", 80, 120, 255, 140);
      } else {
        parrafoColor("Tus habitos casi no mejoraron durante la semana: repasa la guia del Guardian.", 80, 255, 190, 90);
      }
      espacio(10);
      parrafo("Al otro dia, un profesor te explica con paciencia como verificar un mensaje antes de creerlo y te recomienda dormir a buena hora: 'Todavia no estas listo, pero tienes madera de Guardian.'", 80);
      espacio(10);
      pc("Tus decisiones digitales construyen tu futuro. Aun estas a tiempo!", 255, 215, 0);
      break;
    default:
      encabezado("* FINAL MALO: PRESA DE LAS ESTAFAS *", "Diagnostico: " + diagnostico);
      parrafo("Amanece y tu celular no deja de sonar, " + nombre + ": alertas del banco, cuentas bloqueadas y companeros del curso preguntando por que les enviaste mensajes y archivos raros.", 80);
      espacio(10);
      if (incorrectas == TOTAL_SITUACIONES) {
        parrafoColor("Caiste en TODAS las trampas de la semana. Es hora de aprender y volver a intentarlo!", 80, 255, 100, 100);
      } else {
        parrafo("Varias trampas funcionaron: con poco descanso y mal contenido, tu guardia estaba demasiado baja.", 80);
      }
      espacio(10);
      parrafo("Tus cuentas fueron robadas y la estafa se propago por el grupo del curso. Te toca pedir disculpas y hablar con el coordinador.", 80);
      espacio(10);
      parrafo("Pero todo Guardian cae alguna vez: cambias tus claves, reportas las cuentas y pides ayuda a un profesor o a un adulto de confianza. Esta vez perdiste, pero ya sabes que hacer: verificar antes de actuar.", 80);
      espacio(10);
      pc("Vuelve a intentarlo, tus decisiones digitales construyen tu futuro!", 255, 215, 0);
  }
  if (boton(320, 615, 320, 50, "CONTINUAR (ENTER)")) {
    pantalla = 12;
  }
}

// ----- Finales con imagen -----
PImage imagenFinal() {
  PImage img = null;
  switch (tipoFinal) {
    case 0: img = imgFinSecreto; break;
    case 1: img = imgFinBueno; break;
    case 2: img = imgFinRegular; break;
    default: img = imgFinMalo;
  }
  return img;
}

String primerNombre() {
  String n = nombre.trim();
  int esp = n.indexOf(' ');
  if (esp > 0) { n = n.substring(0, esp); }
  return n;
}

void nombreEnImg(float x0, float y0, float w, float h, int yI, int r, int g, int b, String signo) {
  cajaImg(x0, y0, w, h, yI, r, g, b);
  enCasilla(primerNombre() + signo, x0 - 4, y0, w + 8, h, yI, 17, 95, 25, 170, false);
}

void versionElegida(float x0, float y0, float w, float h, int yI) {
  float brillo = 200 + 55 * sin(millis() / 250.0);
  marcoImg(x0, y0, w, h, yI, 40, (int) brillo, 90);
}

void versionApagada(float x0, float y0, float w, float h, int yI) {
  float e = ANCHO / 1672.0;
  fill(250, 248, 255, 200);
  noStroke();
  rect(x0 * e, yI + y0 * e, w * e, h * e, 10);
}

void pantallaFinalImagen(PImage img) {
  int yI = fondoImagen(img);
  float e = ANCHO / 1672.0;
  boolean seguir = false;
  switch (tipoFinal) {
    case 0:
      cajaImg(575, 418, 545, 54, yI, 254, 225, 140);
      enCasilla("Ese alguien eres tú, " + primerNombre() + ".", 575, 418, 545, 54, yI, 22, 70, 20, 140, true);
      seguir = zona(360, 778, 1020, 120, yI);
      break;
    case 1:
      nombreEnImg(748, 244, 134, 34, yI, 254, 253, 252, ",");
      if (incorrectas == 0) {
        versionElegida(462, 368, 746, 86, yI);
        versionApagada(462, 456, 746, 74, yI);
      } else {
        versionApagada(462, 368, 746, 86, yI);
        versionElegida(462, 456, 746, 74, yI);
      }
      seguir = zona(240, 808, 1190, 105, yI);
      break;
    case 2:
      nombreEnImg(744, 236, 130, 32, yI, 251, 249, 252, ",");
      if (correctas >= 7) {
        versionElegida(466, 328, 744, 78, yI);
        versionApagada(466, 410, 744, 80, yI);
      } else {
        versionApagada(466, 328, 744, 78, yI);
        versionElegida(466, 410, 744, 80, yI);
      }
      if (ptsSegunda * 3 < ptsPrimera * 4) {
        versionElegida(466, 505, 744, 76, yI);
        versionApagada(466, 585, 744, 55, yI);
      } else {
        versionApagada(466, 505, 744, 76, yI);
        versionElegida(466, 585, 744, 55, yI);
      }
      seguir = zona(195, 810, 1280, 105, yI);
      break;
    default:
      nombreEnImg(966, 253, 140, 34, yI, 255, 255, 254, ":");
      if (incorrectas == TOTAL_SITUACIONES) {
        cajaImg(540, 374, 700, 82, yI, 253, 240, 212);
        fill(200, 30, 50);
        textFont(fuenteNegrita);
        textSize(14);
        textAlign(LEFT, TOP);
        textoEnCaja("¡Caíste en TODAS las trampas de la semana! Es hora de aprender y volver a intentarlo.", 548 * e, yI + 384 * e, 44, 21);
        textFont(fuente);
      }
      versionElegida(448, 368, 802, 94, yI);
      seguir = zona(300, 780, 1090, 130, yI);
  }
  franjas(nombre + "   |   Puntaje de riesgo: " + puntaje + "   |   " + clasificacion,
          "ENTER o clic en el mensaje de abajo para continuar", yI);
  if (seguir) { pantalla = 12; }
}

// ====================================================================
// PANTALLA 12: MENU FINAL (Dependiendo De)
// ====================================================================
void pantallaMenuFinal() {
  if (imgMenuFinal != null) {
    pantallaMenuFinalImagen();
    return;
  }
  encabezado("MENU FINAL", "Jugador: " + nombre + "   |   Puntaje de riesgo: " + puntaje + "   |   " + clasificacion);
  p("Tu semana digital termino. Que quieres hacer?");
  boolean c1 = boton(160, 200, 640, 56, "1. Ver reporte final");
  boolean c2 = boton(160, 270, 640, 56, "2. Ver logros");
  boolean c3 = boton(160, 340, 640, 56, "3. Ver desglose del puntaje y bitacora");
  boolean c4 = boton(160, 410, 640, 56, "4. Jugar de nuevo");
  boolean c5 = boton(160, 480, 640, 56, "5. Salir");
  if (c1) {
    accionMenuFinal(1);
  } else {
    if (c2) {
      accionMenuFinal(2);
    } else {
      if (c3) {
        accionMenuFinal(3);
      } else {
        if (c4) {
          accionMenuFinal(4);
        } else {
          if (c5) { accionMenuFinal(5); }
        }
      }
    }
  }
}

void accionMenuFinal(int opcion) {
  switch (opcion) {
    case 1:
      pantalla = 13;
      break;
    case 2:
      pantallaVolver = 12;
      pantalla = 15;
      break;
    case 3:
      pantalla = 14;
      break;
    case 4:
      reiniciar();
      break;
    case 5:
      pantalla = 20;
      tSalida = millis();
      break;
    default:
      pantalla = 12;
  }
}

// ====================================================================
// PANTALLA 13: REPORTE FINAL
// ====================================================================
void pantallaReporte() {
  if (imgReporte != null) {
    pantallaReporteImagen();
    return;
  }
  encabezado("REPORTE FINAL", "Jugador: " + nombre + "   |   Edad: " + edad);
  pc("DATOS BASICOS", 255, 215, 0);
  p("Ingreso (dia 1): " + fechaTxt(dia, mes, anio, diaSemIng) + "  " + dos(hora24) + ":" + dos(minuto) + ":00");
  p("Salida (dia 1) : " + fechaTxt(diaS, mesS, anioS, diaSemSal) + "  " + dos(hora24S) + ":" + dos(minuto) + ":01");
  p("Horas acumuladas de uso: " + horasTotales + " h  (" + diasCompletos + " dias y " + horasRest + " h)");
  p("Promedio diario: " + nf(promedioDiario, 0, 1) + " h   |   Dias equivalentes por anio: " + nf(diasEquivAnio, 0, 1));
  espacio(8);
  pc("ESTADISTICAS DE JUEGO", 255, 215, 0);
  p("Decisiones correctas: " + correctas + "     Incorrectas: " + incorrectas);
  p("Nivel alcanzado: " + nivel + " (" + nombreNivel(nivel) + ")   |   Niveles superados: " + nivelesSuperados + " de 3");
  p("Logros obtenidos: " + contarLogros() + " de " + TOTAL_LOGROS + "   |   Mejor racha: " + mejorRacha);
  p("Puntaje digital acumulado: " + puntaje);
  espacio(8);
  pc("RANKING PERSONAL", 255, 215, 0);
  p("Puntaje: " + puntaje);
  pc("Clasificacion: " + clasificacion, 120, 255, 140);
  p("Diagnostico: " + diagnostico);
  p("Partida #" + partidas + "   |   Mejor puntaje de riesgo: " + mejorPuntaje);
  if (boton(320, 615, 320, 50, "VOLVER (ESC)")) {
    pantalla = 12;
  }
}

// ====================================================================
// PANTALLA 14: DESGLOSE DEL PUNTAJE Y BITACORA
// ====================================================================
void pantallaDesglose() {
  if (imgDesglose != null) {
    pantallaDesgloseImagen();
    return;
  }
  encabezado("DESGLOSE DEL PUNTAJE", "De donde salen tus puntos de riesgo");
  p("Tiempo de uso (dia 1)      : " + ptsTiempo);
  p("Horario (dia 1)            : " + ptsHorario);
  p("Contenido consumido        : " + ptsContenido);
  p("Fatiga por horas (dias 2-7): " + ptsFatiga);
  p("Decisiones                 : " + ptsDecisiones);
  pc("TOTAL                       : " + puntaje, 255, 215, 0);
  espacio(10);
  pc("BITACORA DE LA SEMANA", 255, 215, 0);
  pBloque(bitacora);
  if (boton(320, 615, 320, 50, "VOLVER (ESC)")) {
    pantalla = 12;
  }
}

// ====================================================================
// PANTALLA 15: LOGROS
// ====================================================================
void logroLinea(String nom, String desc, boolean ok) {
  if (ok) {
    pc("[DESBLOQUEADO] " + nom, 120, 255, 140);
  } else {
    pc("[bloqueado] " + nom, 150, 150, 170);
  }
  fill(200);
  textSize(16);
  text(desc, 70, cursorY - 4);
  cursorY = cursorY + 28;
}

void estadoLogro(float y0, float h, boolean ok, int yI) {
  float e = ANCHO / 1672.0;
  textAlign(CENTER, CENTER);
  textSize(17);
  if (ok) {
    cajaImg(1142, y0, 346, h, yI, 60, 185, 95);
    fill(255);
    text("DESBLOQUEADO", (1142 + 173) * e, yI + (y0 + h / 2) * e);
  } else {
    fill(235);
    text("Bloqueado", (1142 + 173) * e, yI + (y0 + h / 2) * e);
  }
  textAlign(LEFT, TOP);
}

void pantallaLogros() {
  boolean desdeInicio = (pantallaVolver == 0);
  boolean lFake = logroFake, lPriv = logroPriv, lTiempo = logroTiempo;
  boolean lBien = logroBienestar, lRacha = logroRacha;
  if (desdeInicio) {
    lFake = logroFake || histFake;
    lPriv = logroPriv || histPriv;
    lTiempo = logroTiempo || histTiempo;
    lBien = logroBienestar || histBienestar;
    lRacha = logroRacha || histRacha;
  }
  int n = 0;
  if (lFake) { n++; }
  if (lPriv) { n++; }
  if (lTiempo) { n++; }
  if (lBien) { n++; }
  if (lRacha) { n++; }
  if (imgLogros != null) {
    int yI = fondoImagen(imgLogros);
    estadoLogro(176, 74, lFake, yI);
    estadoLogro(300, 78, lPriv, yI);
    estadoLogro(422, 78, lTiempo, yI);
    estadoLogro(546, 78, lBien, yI);
    estadoLogro(674, 76, lRacha, yI);
    boolean volver = zona(612, 822, 448, 103, yI);
    String arriba = "Obtenidos en esta partida: " + n + " de " + TOTAL_LOGROS;
    if (desdeInicio) { arriba = "Desbloqueados en todas tus partidas: " + n + " de " + TOTAL_LOGROS; }
    franjas(arriba, "ENTER o ESC para volver", yI);
    if (volver) { pantalla = pantallaVolver; }
    return;
  }
  if (desdeInicio) {
    encabezado("LOGROS", "Desbloqueados en todas tus partidas: " + n + " de " + TOTAL_LOGROS);
  } else {
    encabezado("LOGROS", "Obtenidos en esta partida: " + n + " de " + TOTAL_LOGROS);
  }
  logroLinea("Detective de Fake News", "Acierta las 2 decisiones del Dia 2 (noticias falsas).", lFake);
  logroLinea("Guardian de la Privacidad", "Acierta las 2 decisiones del Dia 3 (privacidad).", lPriv);
  logroLinea("Rey del Tiempo", "Usa 3 horas o menos en al menos 4 de los 7 dias.", lTiempo);
  logroLinea("Experto en Bienestar Digital", "Acierta las 2 decisiones del Dia 6 (bienestar).", lBien);
  logroLinea("Racha de Hierro", "Encadena 5 decisiones correctas seguidas.", lRacha);
  if (boton(320, 615, 320, 50, "VOLVER (ESC)")) {
    pantalla = pantallaVolver;
  }
}

// ====================================================================
// PANTALLA 20: DESPEDIDA
// ====================================================================
void pantallaDespedida() {
  if (imgDespedida != null) {
    int yI = fondoImagen(imgDespedida);
    float e = ANCHO / 1672.0;
    String quien = "Guardian";
    if (!nombre.equals("")) { quien = nombre; }
    textAlign(CENTER, CENTER);
    textSize(34);
    fill(60, 20, 120);
    text(quien + "!", ANCHO / 2 + 2, yI + 722 * e + 2);
    fill(255);
    text(quien + "!", ANCHO / 2, yI + 722 * e);
    textAlign(LEFT, TOP);
    if (millis() - tSalida > 3500) { exit(); }
    return;
  }
  encabezado("HASTA PRONTO", "Gracias por jugar");
  espacio(60);
  if (nombre.equals("")) {
    pc("Hasta pronto, Guardian.", 255, 215, 0);
  } else {
    pc("Hasta pronto, " + nombre + ".", 255, 215, 0);
  }
  p("Tus decisiones digitales construyen tu futuro!");
  if (millis() - tSalida > 2500) {
    exit();
  }
}

// ====================================================================
// PANTALLAS CON IMAGEN
// ====================================================================

// ----- PANTALLA 2: resumen de la sesion -----
void pantallaResumenImagen() {
  int yI = fondoImagen(imgResumen);
  enCasilla(nombre, 648, 207, 230, 48, yI, 18, 30, 20, 80, true);
  enCasilla("" + edad + " años", 1270, 207, 205, 48, yI, 18, 30, 20, 80, true);
  enCasilla(fechaTxt(dia, mes, anio, diaSemIng), 800, 297, 565, 44, yI, 16, 30, 20, 80, true);
  enCasilla(horaTxt(hora24, minuto, 0), 800, 353, 565, 44, yI, 16, 30, 20, 80, true);
  enCasilla(fechaTxt(diaS, mesS, anioS, diaSemSal), 800, 410, 565, 44, yI, 16, 30, 20, 80, true);
  enCasilla(horaTxt(hora24S, minuto, 1), 800, 466, 565, 44, yI, 16, 30, 20, 80, true);
  String usoTxt = horasUso + " h";
  if (esBisiesto) { usoTxt = usoTxt + "   (el año " + anio + " es bisiesto)"; }
  enCasilla(usoTxt, 800, 522, 565, 44, yI, 16, 30, 20, 80, true);
  enCasilla("" + puntaje, 1028, 628, 244, 94, yI, 34, 40, 20, 90, true);
  boolean seguir = zona(540, 800, 590, 90, yI);
  franjas(msgTiempo, msgHorario, yI);
  if (seguir) { pantalla = 3; }
}

// ----- PANTALLA 4: mi dia digital y menu -----
void pantallaMenuImagen() {
  int yI = fondoImagen(imgMenuDia);
  enCasilla(msgContenido, 420, 515, 1060, 60, yI, 17, 110, 20, 160, false);
  boolean c1 = zona(410, 588, 1075, 80, yI);
  boolean c2 = zona(410, 683, 1075, 80, yI);
  boolean c3 = zona(410, 778, 1075, 82, yI);
  franjas(nombre + ", hoy es " + nombreDia(diaSemIng) + " " + dia + "/" + mes + "/" + anio
          + "   |   Riesgo hasta ahora: " + puntaje,
          "Haz clic en una opción o usa las teclas 1, 2 o 3", yI);
  if (c1) {
    accionMenu(1);
  } else {
    if (c2) {
      accionMenu(2);
    } else {
      if (c3) { accionMenu(3); }
    }
  }
}

// ----- PANTALLA 6: inicio de cada dia -----
void pantallaDiaImagen() {
  int yI = fondoImagen(imgDia);
  float e = ANCHO / 1672.0;
  if (diaJuego > 1) {
    cajaImg(520, 28, 812, 74, yI, 48, 4, 140);
    textoContorno("DÍA " + diaJuego + " DE 7: " + temaDia.toUpperCase(), 926 * e, yI + 63 * e, 34, 790 * e, 255, 225, 40);
    if (diaJuego != 3 && diaJuego != 5) {
      cajaImg(585, 186, 615, 120, yI, 246, 242, 252);
    }
    cajaImg(590, 475, 800, 95, yI, 244, 238, 252);
    fill(30, 25, 70);
    textFont(fuente);
    textSize(15);
    textAlign(LEFT, TOP);
    textoEnCaja(descDia, 595 * e, yI + 478 * e, 58, 22);
    cajaImg(575, 615, 425, 95, yI, 25, 3, 128);
    fill(255);
    textFont(fuenteNegrita);
    textSize(15);
    textoEnCaja("¿Cuántas horas usarás redes hoy? (1 a 24)", 585 * e, yI + 625 * e, 22, 22);
    textFont(fuente);
  }
  if (nivel != 1) {
    cajaImg(640, 104, 515, 48, yI, 0, 248, 253);
    enCasilla("Nivel " + nivel + ": " + nombreNivel(nivel), 640, 104, 515, 48, yI, 18, 20, 10, 80, true);
    cajaImg(640, 335, 770, 95, yI, 214, 226, 251);
    String t1 = "NIVEL 2 – USUARIO FRECUENTE:";
    String t2 = "cada error suma +1 de riesgo extra.";
    if (nivel == 3) {
      t1 = "NIVEL 3 – EXPERTO DIGITAL:";
      t2 = "tienes " + tiempoNivel3 + " s por decisión y cada error suma +2.";
    }
    enCasilla(t1, 640, 338, 770, 46, yI, 19, 20, 15, 80, false);
    enCasilla(t2, 640, 382, 770, 44, yI, 16, 50, 45, 100, false);
  }
  String valor = "" + horasUso;
  if (diaJuego > 1) {
    String parpadeo = "";
    if ((millis() / 500) % 2 == 0) { parpadeo = "_"; }
    valor = entrada + parpadeo;
  }
  enCasilla(valor, 1028, 625, 312, 75, yI, 26, 30, 20, 80, true);
  boolean ok = zona(490, 820, 695, 92, yI);
  String abajo = "ENTER o clic en COMENZAR EL DÍA";
  if (diaJuego > 1) { abajo = "Escribe las horas y presiona ENTER   |   BORRAR corrige"; }
  if (!mensajeError.equals("")) { abajo = mensajeError; }
  franjas(fechaTxt(fecDia, fecMes, fecAnio, fecSem) + "   |   Riesgo acumulado: " + puntaje, abajo, yI);
  if (ok) { confirmarDia(); }
}

// ----- PANTALLA 10: cierre de cada dia -----
PImage imagenCierre() {
  PImage img = null;
  switch (diaJuego) {
    case 1: img = imgCierre1; break;
    case 2: img = imgCierre2; break;
    case 3: img = imgCierre3; break;
    case 4: img = imgCierre4; break;
    case 5: img = imgCierre5; break;
    case 6: img = imgCierre6; break;
    default: img = imgCierre7;
  }
  return img;
}

void celdas(int llenos, int total, float x0, float paso, float y0, float w, float h, int yI) {
  for (int i = 0; i < total; i++) {
    if (i < llenos) { cajaImg(x0 + paso * i, y0, w, h, yI, 70, 215, 110); }
  }
}

void pantallaCierreImagen(PImage img) {
  int yI = fondoImagen(img);
  float e = ANCHO / 1672.0;
  if (diaJuego != 1) {
    cajaImg(670, 103, 390, 42, yI, 0, 238, 253);
    enCasilla(temaDia, 670, 103, 390, 42, yI, 20, 15, 10, 70, true);
  }
  enCasilla(aciertosDia + " de " + sitsDelDia, 702, 190, 126, 45, yI, 17, 30, 20, 80, true);
  enCasilla("+" + ptsDia, 1332, 190, 128, 45, yI, 17, 30, 20, 80, true);
  enCasilla(horasHoy + " h", 702, 258, 126, 45, yI, 17, 30, 20, 80, true);
  enCasilla(horasTotales + " h", 1332, 258, 128, 45, yI, 17, 30, 20, 80, true);
  celdas(respN1, 4, 690, 68, 415, 60, 45, yI);
  celdas(respN2, 4, 690, 68, 475, 60, 45, yI);
  celdas((respN3 * 4) / 5, 4, 690, 68, 535, 60, 45, yI);
  celdas(diaJuego, 7, 688, 67.5, 600, 58, 46, yI);
  enCasilla("" + respN1, 1065, 415, 115, 45, yI, 18, 30, 20, 80, true);
  enCasilla("" + respN2, 1065, 475, 115, 45, yI, 18, 30, 20, 80, true);
  enCasilla("" + respN3, 1065, 535, 115, 45, yI, 18, 30, 20, 80, true);
  cajaImg(1188, 535, 50, 45, yI, 234, 233, 249);
  enCasilla("/5", 1186, 535, 54, 45, yI, 20, 20, 15, 60, false);
  enCasilla("" + puntaje, 1122, 712, 240, 63, yI, 26, 30, 20, 80, true);
  if (diaJuego == 7) {
    cajaImg(580, 828, 485, 64, yI, 3, 235, 2);
    textoContorno("VER MI FINAL (ENTER)", 822 * e, yI + 858 * e, 24, 460 * e, 255, 255, 255);
  }
  boolean seguir = zona(510, 815, 640, 95, yI);
  String arriba = "Día " + diaJuego + " completado   |   " + fechaTxt(fecDia, fecMes, fecAnio, fecSem);
  if (!avisoLogros.equals("")) { arriba = avisoLogros.trim().replace("\n", "   |   "); }
  String abajo = "ENTER o clic para continuar";
  if (!msgFatiga.equals("")) { abajo = msgFatiga; }
  franjas(arriba, abajo, yI);
  if (seguir) { avanzarDesdeCierre(); }
}

// ----- PANTALLA 12: menu final -----
String claseCorta() {
  String c = "";
  if (puntaje < LIM_EJEMPLAR) {
    c = "Ejemplar";
  } else {
    if (puntaje <= LIM_RESPONSABLE) {
      c = "Responsable";
    } else {
      if (puntaje <= LIM_RIESGO) { c = "En riesgo"; } else { c = "Dependencia alta"; }
    }
  }
  return c;
}

void pantallaMenuFinalImagen() {
  int yI = fondoImagen(imgMenuFinal);
  enCasilla(nombre, 355, 140, 113, 43, yI, 15, 30, 20, 80, true);
  enCasilla("" + puntaje, 788, 140, 99, 43, yI, 17, 30, 20, 80, true);
  cajaImg(1005, 140, 268, 43, yI, 14, 3, 110);
  enCasilla("Clasificación:", 1005, 140, 268, 43, yI, 17, 255, 255, 255, false);
  enCasilla(claseCorta(), 1283, 140, 222, 43, yI, 15, 30, 20, 80, true);
  int elegida = 0;
  for (int i = 1; i <= 5; i++) {
    if (zona(520, 385 + 96 * (i - 1), 900, 80, yI)) { elegida = i; }
  }
  franjas(clasificacion + "   |   " + diagnostico,
          "Haz clic en una opción o usa las teclas 1 a 5", yI);
  if (elegida > 0) { accionMenuFinal(elegida); }
}

// ----- PANTALLA 13: reporte final -----
void pantallaReporteImagen() {
  int yI = fondoImagen(imgReporte);
  int c1 = 30, c2 = 20, c3 = 80;
  enCasilla(nombre, 550, 130, 285, 48, yI, 18, c1, c2, c3, true);
  enCasilla(edad + " años", 1102, 130, 223, 48, yI, 18, c1, c2, c3, true);
  enCasilla(dia + "/" + mes + "/" + anio + "  " + dos(hora24) + ":" + dos(minuto) + ":00", 635, 297, 210, 35, yI, 14, c1, c2, c3, true);
  enCasilla(diaS + "/" + mesS + "/" + anioS + "  " + dos(hora24S) + ":" + dos(minuto) + ":01", 635, 340, 210, 35, yI, 14, c1, c2, c3, true);
  enCasilla(horasTotales + " h (" + diasCompletos + " d y " + horasRest + " h)", 635, 383, 210, 35, yI, 14, c1, c2, c3, true);
  enCasilla(nf(promedioDiario, 0, 1) + " h por día", 635, 428, 210, 35, yI, 14, c1, c2, c3, true);
  enCasilla(nf(diasEquivAnio, 0, 1) + " días", 635, 474, 210, 35, yI, 14, c1, c2, c3, true);
  enCasilla("" + correctas, 1160, 300, 75, 40, yI, 16, c1, c2, c3, true);
  enCasilla("" + incorrectas, 1453, 300, 87, 40, yI, 16, c1, c2, c3, true);
  enCasilla("" + nivel, 1128, 357, 80, 40, yI, 16, c1, c2, c3, true);
  enCasilla(nivelesSuperados + "/3", 1473, 357, 67, 40, yI, 16, c1, c2, c3, true);
  enCasilla(contarLogros() + "/" + TOTAL_LOGROS, 1128, 412, 80, 38, yI, 16, c1, c2, c3, true);
  enCasilla("" + mejorRacha, 1453, 412, 87, 38, yI, 16, c1, c2, c3, true);
  enCasilla("" + puntaje, 1255, 468, 285, 42, yI, 17, c1, c2, c3, true);
  enCasilla("" + puntaje, 575, 615, 160, 33, yI, 15, c1, c2, c3, true);
  enCasilla(clasificacion, 575, 655, 558, 33, yI, 15, c1, c2, c3, true);
  enCasilla(diagnostico, 575, 697, 558, 33, yI, 15, c1, c2, c3, true);
  enCasilla("" + partidas, 558, 740, 94, 38, yI, 15, c1, c2, c3, true);
  enCasilla("" + mejorPuntaje, 1028, 740, 105, 38, yI, 15, c1, c2, c3, true);
  boolean volver = zona(575, 820, 510, 85, yI);
  franjas("Reporte final de tu semana digital", "ENTER, ESC o clic en VOLVER", yI);
  if (volver) { pantalla = 12; }
}

// ----- PANTALLA 14: desglose del puntaje y bitacora -----

String lineaBitacora(int k) {
  String s = bitacora;
  int n = 1;
  while (n < k && s.indexOf('\n') >= 0) {
    s = s.substring(s.indexOf('\n') + 1);
    n++;
  }
  if (n < k) { return ""; }
  int fin = s.indexOf('\n');
  if (fin >= 0) { s = s.substring(0, fin); }
  return s;
}

void filaBitacora(int k, float x0, float yc, int yI) {
  String s = lineaBitacora(k);
  String detalle = "-";
  String pts = "-";
  int dp = s.indexOf(": ");
  if (dp >= 0) {
    s = s.substring(dp + 2);
    int coma = s.indexOf(", +");
    int pp = s.indexOf(" pts");
    int pa = s.indexOf("(");
    int ph = s.indexOf(" de uso");
    if (coma > 0 && pp > coma && pa > 0 && ph > pa) {
      detalle = s.substring(0, coma) + " · " + s.substring(pa + 1, ph);
      pts = s.substring(coma + 2, pp);
    }
  }
  enCasilla(detalle, x0, yc - 19, 1448 - x0, 38, yI, 14, 30, 20, 80, true);
  enCasilla(pts, 1480, yc - 19, 85, 38, yI, 15, 30, 20, 80, true);
}

void pantallaDesgloseImagen() {
  int yI = fondoImagen(imgDesglose);
  enCasilla("+" + ptsTiempo, 727, 295, 98, 50, yI, 18, 30, 20, 80, true);
  enCasilla("+" + ptsHorario, 727, 357, 98, 50, yI, 18, 30, 20, 80, true);
  enCasilla("+" + ptsContenido, 727, 422, 98, 50, yI, 18, 30, 20, 80, true);
  enCasilla("+" + ptsFatiga, 727, 487, 98, 50, yI, 18, 30, 20, 80, true);
  enCasilla("+" + ptsDecisiones, 727, 552, 98, 50, yI, 18, 30, 20, 80, true);
  enCasilla("" + puntaje, 690, 638, 118, 47, yI, 20, 30, 20, 80, true);
  filaBitacora(1, 1145, 320, yI);
  filaBitacora(2, 1252, 376, yI);
  filaBitacora(3, 1132, 432, yI);
  filaBitacora(4, 1220, 488, yI);
  filaBitacora(5, 1238, 545, yI);
  filaBitacora(6, 1193, 602, yI);
  filaBitacora(7, 1190, 659, yI);
  boolean volver = zona(545, 770, 565, 95, yI);
  franjas("Total de riesgo: " + puntaje + "   |   " + clasificacion, "ENTER, ESC o clic en VOLVER", yI);
  if (volver) { pantalla = 12; }
}

// ====================================================================
// REINICIO DEL JUEGO
// ====================================================================
void reiniciar() {
  partidas = partidas + 1;
  hayPartida = false;
  pantallaGuardada = 16;
  avisoInicio = "";
  pantalla = 0;
  paso = 1;
  entrada = "";
  mensajeError = "";
  aviso = "";
  nombre = "";
  franja = "";
  edad = 0; anio = 0; mes = 0; dia = 0;
  hora12 = 0; minuto = 0; horasUso = 0;
  hora24 = 0; diasDelMes = 0; tValor = 0; y = 0;
  diaSemIng = 0; diaSemSal = 0;
  restoHoras = 0; sumaHoras = 0; diasExtra = 0; hora24S = 0;
  anioS = 0; mesS = 0; diaS = 0;
  yy = 0; era = 0; doe = 0; yoe = 0; doy = 0; mp = 0; z = 0;
  segIngreso = 0; segSalida = 0;
  esBisiesto = false;
  fueraHorario = false;
  msgTiempo = "";
  msgHorario = "";
  contenido1 = 0; contenido2 = 0; selecciones = 0;
  msgContenido = "";
  puntaje = 0; ptsTiempo = 0; ptsHorario = 0; ptsContenido = 0;
  ptsDecisiones = 0; ptsFatiga = 0;
  correctas = 0; incorrectas = 0; racha = 0; mejorRacha = 0;
  diaJuego = 1; nivel = 1; numSit = 1; sitEnDia = 1; sitsDelDia = 2;
  fecAnio = 0; fecMes = 0; fecDia = 0; fecSem = 0;
  horasHoy = 0; horasTotales = 0; diasControlados = 0;
  aciertosDia = 0; ptsDia = 0; ptsPrimera = 0; ptsSegunda = 0;
  respN1 = 0; respN2 = 0; respN3 = 0; acN1 = 0; acN2 = 0; acN3 = 0;
  bitacora = ""; avisoLogros = ""; temaDia = ""; descDia = ""; msgFatiga = "";
  logroFake = false; logroPriv = false; logroTiempo = false;
  logroBienestar = false; logroRacha = false;
  ultimoFb = ""; ultimoPts = 0; ultimaCorrecta = false;
  tipoFinal = 0;
  clasificacion = ""; diagnostico = "";
  promedioDiario = 0; diasEquivAnio = 0;
  diasCompletos = 0; horasRest = 0; nivelesSuperados = 0;
}
