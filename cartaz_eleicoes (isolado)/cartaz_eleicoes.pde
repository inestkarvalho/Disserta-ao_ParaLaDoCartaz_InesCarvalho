import processing.video.*;
import gab.opencv.*;
import java.awt.Rectangle;

Capture cam;
OpenCV opencv;

float barrades = 0;
float origemX = -1;
float xbarra;
float suavizacao = 0.15;

int tam, tamMax, tamMin, grossura, grossura2, tpver1, tpver2, tpver3, tpver4, tpver5, percentagem, aparecerpopup;
int inicioAnimacao = 0;
int inicioAnimacao2 = 0;
int inicioCartaz = 0;
int inicioCartaz2 = 0;
int fase = 0;

PImage [] imagens= new PImage[6];
PImage img, img2,popup;
PImage frameCamadaSuperior;
int indiceft;

PVector p1, p2, p3;

color bg,bg2;

float largura, x, y, tamdes1, tamdes2, tamdes_1, tamdes_2, largura2, cres, inicioFase, entrelinha, entrelinha2;

color[] paleta1 = {#ffff00, #3f22ec}; // verde, roxo
color[] paleta2 = {#EB4213, #03e29d}; // laranja, azul 

float y1, y2, y3, y4, y5, y6, y7, y8, x2, x3, x4, x5, x6, x7, x8;

PFont ftit, ftex;

float vx1 = 0;
float vy1 = 0;

float zonaEsquerda = 40;

String titulo1 = "SE  NADA MUDA \nPORQUÊ O ESFORÇO?";
String destaque1 = "NADA MUDA";
String[] divisao1 = split(titulo1, destaque1);

String titulo2 = "A AUSÊNCIA \nTAMBÉM DECIDE";
String destaque2 = "DECIDE";
String[] divisao2 = split(titulo2, destaque2);

String textodes1 = "JOVENS NÃO \nSE INTERESSAM POR POLÍTICA";
String destaquedes1_1 = "NÃO \nSE INTERESSAM";
String destaquedes1_2 = "POLÍTICA";
String[] divisaotextdes1_1 = split(textodes1, destaquedes1_1);
String[] divisaotextdes1_2 = split(divisaotextdes1_1[1], destaquedes1_2);

String textdes2 = "DOMINGO É PARA \nA FAMÍLIA,\nNÃO PARA A URNA";
String destaquedes2_1 = "É";
String destaquedes2_2 = "\nA";
String destaquedes2_3 = "PARA A";
String[] divisaotextdes2_1 = split(textdes2, destaquedes2_1);
String[] divisaotextdes2_2 = split(divisaotextdes2_1[1], destaquedes2_2);
String[] divisaotextdes2_3 = split(divisaotextdes2_2[1], destaquedes2_3);

String textver1 = "1% DE VOTOS DISTRITAIS \nDECIDIU A MAIORIA \nABSOLUTA EM 2022";
String destaquever1_1 = "1%";
String destaquever1_2 = "DISTRITAIS";
String[] divisaotextver1_1 = split(textver1, destaquever1_1);
String[] divisaotextver1_2 = split(divisaotextver1_1[1], destaquever1_2);

String textver2 = "FALTA DE \nCOMPARÊNCIA \nNÃO DÁ DIREITO \nA CRITICAR";
String destaquever2_1 = "DE";
String destaquever2_2 = "DÁ";
String destaquever2_3 = "\nA";
String[] divisaotextver2_1 = split(textver2, destaquever2_1);
String[] divisaotextver2_2 = split(divisaotextver2_1[1], destaquever2_2);
String[] divisaotextver2_3 = split(divisaotextver2_2[1], destaquever2_3);

boolean animado = false;
boolean animado2 = false;
boolean alvo = false;

boolean overlayAtivo = true;
float limiteRemocao;
boolean popupAtivado = false;
boolean modoDebug = false;

void setup() {
  size(360, 640, P2D);
  //size(1080, 1920, P2D);
  bg = color(#f4f4f4);
  bg2=color(#141414);
  textureMode(IMAGE);

  limiteRemocao = height - height * 0.005;

  tam = round(width * 0.055);
  tamMax= round(width*0.082);
  tamMin=round(width*0.040);
  ftit = createFont("black.otf", tamMax);
  ftex = createFont("medium.otf", tamMax);

  imagens[0]=loadImage("ele1.png");
  imagens[0].resize(round(width * 0.8), 0);

  imagens[1]=loadImage("ele2.png");
  imagens[1].resize(round(width * 0.9), 0);

  imagens[2]=loadImage("ele3.png");
  imagens[2].resize(round(width * 0.8), 0);

  imagens[3]=loadImage("ele4.png");
  imagens[3].resize(round(width * 0.9), 0);

  imagens[4]=loadImage("ele5.png");
  imagens[4].resize(round(width * 0.8), 0);

  imagens[5]=loadImage("ele6.png");
  imagens[5].resize(round(width * 0.9), 0);

 indiceft=int(random(0,3));
  img = imagens[indiceft];
  img2 = imagens[indiceft + 3];

  if (indiceft==0) {
    y1 = random(height * 0.05, height * 0.09);
    y2 = random(height * 0.2, height * 0.3);
    y3 = random(height * 0.57, height * 0.6);
    y4 = random(height * 0.72, height * 0.76);

    y5 = random(height * 0.05, height * 0.13);
    y8 = random(height * 0.2, height * 0.35);
    y7 = random(height * 0.5, height * 0.6);
    y6 = random(height * 0.78, height * 0.82);

    x2=width * 0.05;
    x3=width*0.5;
    x4=width * 0.25;

    x8=width*0.55;
    x7=width*0.05;
    x6=width*0.4;
  } else if (indiceft==1) {
    y1 = random(height * 0.05, height * 0.09);
    y2 = random(height * 0.75, height * 0.76);
    y4=random(height*0.16, height*0.18);
    y3=random(height*0.58, height * 0.65);

    y5 = random(height * 0.05, height * 0.13);
    y6=random(height*0.2, height*0.27);
    y7=random(height*0.6, height*0.7);
    y8=random(height*0.75, height * 0.82);

    x2=width*0.25;
    x4= width*0.05;
    x3=width * 0.55;

    x6=width*0.07;
    x7=width * 0.55;
    x8=width*0.15;
  } else if (indiceft==2) {
    y1 = random(height * 0.05, height * 0.09);
    y2=random(height*0.2, height*0.21);
    y4=random(height*0.75, height*0.77);
    y3=random(height*0.65, height*0.67);

    y5 = random(height * 0.05, height * 0.13);
    y6= random(height*0.21, height*0.25);
    y7=random(height*0.72, height*0.75) ;
    y8=random(height*0.77, height*0.8);
    x2=width*0.35;
    x3= width*0.05;
    x4=width * 0.4;

    x6=width*0.35;
    x7=width * 0.07;
    x8=width*0.6;
  }
  popup= loadImage("popup.png");
  popup.resize(width, 0);
  p1 = new PVector(width, 0);
  p2 = new PVector(width, 0);
  p3 = new PVector(width, 0);

  percentagem=round(random(5, 15));

  cam = new Capture(this, 640, 480);
  cam.start();

  opencv = new OpenCV(this, 640, 480);
  opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);

  inicioCartaz = millis();
}

void draw(){
if (cam.available()) {
    cam.read();
    opencv.loadImage(cam);
  }

  Rectangle[] faces = opencv.detect();

  image(cam, 0, 0, width, height);

  int tamMinimoDistancia = 40;
  if (faces != null && faces.length > 0) {
    Rectangle caraAlvo = null;

    if (origemX != -1) {
      float menorDistancia = 999999;
      for (int i = 0; i < faces.length; i++) {
        if (faces[i].width >= (tamMinimoDistancia - 20)) { 
          float xCaraAtual = width - map(faces[i].x + faces[i].width / 2.0, 0, cam.width, 0, width);
          float d = abs(xCaraAtual - origemX);
          if (d < menorDistancia) {
            menorDistancia = d;
            caraAlvo = faces[i];
          }
        }
      }
    } else {
      for (int i = 0; i < faces.length; i++) {
        if (faces[i].width >= tamMinimoDistancia) {
          caraAlvo = faces[i];
          break; 
        }
      }
    }

    if (caraAlvo != null) {
      float xCara = caraAlvo.x + caraAlvo.width / 2.0;
      xCara = map(xCara, 0, cam.width, 0, width);
      xCara = width - xCara; 

      if (origemX == -1) {
        origemX = xCara;
        if (origemX < width / 2) {
          xbarra = width * 0.05;
          inicioFase = width * 0.16;
        } else {
          xbarra = width - width * 0.05;
          inicioFase = width * 0.16;
        }
      }

      if (alvo == false) {
        if (origemX < width / 2) {
          float pontaBarra = constrain(xCara, xbarra, width / 2);
          barrades = lerp(barrades, pontaBarra - xbarra, suavizacao);
          if (xbarra + barrades >= width / 2 - 2) {
            barrades = width / 2 - xbarra;
            alvo = true;
          }
        } else {
          float pontaBarra = constrain(xCara, width / 2, xbarra);
          barrades = lerp(barrades, pontaBarra - xbarra, suavizacao);
          if (xbarra + barrades <= width / 2 + 2) {
            barrades = width / 2 - xbarra;
            alvo = true;
          }
        }
      }
    }
  }
  if (overlayAtivo) {
    background(bg);
    camadadesinformacao();

    frameCamadaSuperior = get(0, 0, width, height);

    background(bg);
    camadaveridica();

    if (alvo == true) {
      if (p2.x >= width * 0.05) {
        p2.x -= width * 0.01;
      }
      p2.y += width * 0.02;
    }

    p3.x = width;
    p3.y = p2.y;

    vx1 = 0;
    vy1 = 0;

    if (p2.x < zonaEsquerda) {
      float t = map(p2.x, zonaEsquerda, 0, 0, 1);
      t = constrain(t, 0, 1);

      p1.x = 0;
      p1.y = lerp(0, p2.y, t);
    } else {
      p1.x = p2.x;
      p1.y = 0;
    }

    if (overlayAtivo && p2.y > limiteRemocao) {
      overlayAtivo = false;
      inicioCartaz2 = millis();
    }

    noStroke();

    beginShape();
    texture(frameCamadaSuperior);

    vertex(vx1, vy1, 0, 0);
    vertex(p1.x, p1.y, p1.x, p1.y);

    vertex(p3.x, p3.y, p3.x, p3.y);
    vertex(p2.x, p2.y, p2.x, p2.y);

    vertex(p1.x, p1.y, p1.x, p1.y);
    vertex(p3.x, p3.y, p3.x, p3.y);

    vertex(width, height, width, height);
    vertex(0, height, 0, height);

    endShape(CLOSE);

    if (p2.x < width - width * 0.01 && p2.y > width * 0.01) {
      noStroke();
      fill(100, 50);
      triangle(p1.x, p1.y, p2.x-width*0.02, p2.y+width*0.02, p3.x, p3.y);
      fill(235);
      triangle(p1.x, p1.y, p2.x, p2.y, p3.x, p3.y);
    }
  } else {
    background(bg);
    camadaveridica();
    
    if (popupAtivado) {
      popup();
    }
  }

  if (modoDebug) {
    // Força o desenho da câmara à frente do cartaz 
    image(cam, 0, 0, width, height); 
    //retangulos verdes de deteçao 
    noFill();
    stroke(0, 255, 0);
    strokeWeight(3);
    for (int i = 0; i < faces.length; i++) {
      float fx = map(faces[i].x, 0, cam.width, 0, width);
      float fy = map(faces[i].y, 0, cam.height, 0, height);
      float fw = map(faces[i].width, 0, cam.width, 0, width);
      float fh = map(faces[i].height, 0, cam.height, 0, height);
      rect(fx, fy, fw, fh);
    }
    
    fill(0, 255, 0);
    textSize(16);
    textAlign(LEFT, TOP);
    text("MODO DEBUG ATIVO (Faces: " + faces.length + ")", 10, 10);
  }
}



void camadadesinformacao() {
  textLeading(tam*1.05);
background(bg2);
  if (animado == false) {
    textFont(ftex);
    textSize(tam);
    largura = 0;
    tamdes1 = tamdes2 = tamdes_1 =tamdes_2=tam;
    grossura = 0;
  } else {
    if (fase == 1) {
      if (tamdes1<tamMax) {
        tamdes1+=0.1;
      };

      if (tamdes_1 >tamMin) {
        tamdes_1 -= width*0.0005;
      }

      if (tamdes_1 <= tamMin && tamdes1 >= tamMax ) {
        fase = 2;
      }
    } else if (fase == 2) {
      if (tamdes2<tamMax) {
        tamdes2+=0.1;
      }

      if (tamdes_2 > tamMin) {
        tamdes_2 -= width*0.0005;
      }
      if (tamdes_2 <= tamMin && tamdes2 >= tamMax) {
        fase = 3;
      }
    } else if (fase == 3) {
      if (largura < textWidth("1 VOTO É POUCO")) {
        largura += width*0.002;
        grossura = 4;
      }
    }
  }
  entrelinha=tamdes1*1.05;
  entrelinha2=tamdes2*1.05;

  textFont(ftit);
  textSize(tam);
  textAlign(LEFT);

  int tempoinicial = millis() - inicioCartaz;

  pushMatrix();
  translate(width * 0.05, y1);
  rotate(radians(10));

  float xAtual = 0;
  float yAtual=0;

  fill(paleta1[1]);

  text(divisao1[0], xAtual, 0);

  xAtual += textWidth(divisao1[0]);

  noStroke();
  rect(xAtual-tam*0.1, yAtual-tam+tam*0.01, textWidth("NADA MUDA "), tam+tam*0.2);

  fill(bg2);
  text(destaque1, xAtual, 0);

  xAtual += textWidth(destaque1);

  fill(paleta1[1]);
  text(divisao1[1], 0, 0);

  popMatrix();

  textFont(ftex);
  fill(255);
  textSize(tam);

  // BLOCO 1
  if (tempoinicial >= 4000) {
    pushMatrix();
    translate(x2, y2);
    rotate(radians(10));

    float x = 0;
    float y = 0;
    String[] linesDestaque1 = split(destaquedes1_1, "\n");

    textSize(tamdes_1);
    text(divisaotextdes1_1[0], x, y);
    x += textWidth(divisaotextdes1_1[0]); //jovens


    if (tempoinicial >= 4500) {

      textSize(tamdes1);
      text(linesDestaque1[0], x, y); //não
    }

    x = 0;
    y += entrelinha;

    if (tempoinicial >= 5500) {

      textSize(tamdes1);
      text(linesDestaque1[1], x, y); // se interessam
    }

    if (tempoinicial >= 6000) {
      textSize(tamdes_1);
      String[] textoPor = split(divisaotextdes1_2[0], "\n");
      x=-width*0.008;
      y += entrelinha;
      text(textoPor[0], x, y); //por
      x+=textWidth(textoPor[0]);
    }

    if (tempoinicial >= 6500) {
      textSize(tamdes1);
      text(destaquedes1_2, x, y); //politica
    }

    popMatrix();
  }


  // BLOCO 2
  if (tempoinicial >= 7500) {
    pushMatrix();
    translate(x3, y3);
    rotate(radians(10));
    textLeading(0);
    stroke(paleta1[0]);
    strokeWeight(grossura);
    line(0, 3, largura, 3);

    textSize(tam);

    text("1 VOTO É POUCO", 0, 0);


    if (tempoinicial >= 8000) {
      text("PARA FAZER", 0, tam*1.05);
    }

    if (tempoinicial >= 9000) {
      text("A MUDANÇA", 0, (tam*1.05) * 2);
    }

    popMatrix();
  }

  // BLOCO 3
  if (tempoinicial >= 10000) {
    pushMatrix();
    translate(x4, y4);
    rotate(radians(10));

    float x1 = 0;
    float yy1 = 0;

    textSize(tamdes2);
    text(divisaotextdes2_1[0], x1, yy1); //domingo
    x1 += textWidth(divisaotextdes2_1[0]);


    if (tempoinicial >= 10500) {
      textSize(tamdes_2);
      text(destaquedes2_1, x1, yy1); //é
      x1 += textWidth(destaquedes2_1);
    }


    if (tempoinicial >= 11000) {
      x1 = -width*0.008;
      yy1 += entrelinha2;
      textSize(tamdes2);
      text(divisaotextdes2_2[0], x1, yy1); //para
    }

    if (tempoinicial >= 11500) {
      x1 += textWidth(divisaotextdes2_2[0]);
      textSize(tamdes_2);
      String letraA = destaquedes2_2.replace("\n", "");
      text(letraA, x1, yy1); //a
      x1 += textWidth(letraA);
    }


    if (tempoinicial >= 12500) {
      textSize(tamdes2);
      String[] divisaoNao = split(divisaotextdes2_3[0], "\n");
      text(divisaoNao[0], x1, yy1); //familia
      x1 = 0;
      yy1 += entrelinha2;
      text(divisaoNao[1], x1, yy1); //não
      x1+=textWidth(divisaoNao[1]);
    }


    if (tempoinicial >= 13000) {
      textSize(tamdes_2);
      text(destaquedes2_3, x1, yy1); //para a
      x1 += textWidth(destaquedes2_3);
    }

    if (tempoinicial >= 13500) {
      textSize(tamdes2);
      text(divisaotextdes2_3[1], x1, yy1); //urna
    }

    popMatrix();
  }

  textAlign(CENTER);
  textFont(ftit);
  textSize(tam);
  fill(paleta1[1]);

  pushMatrix();
  translate(width / 2, height * 0.92);
  rotate(radians(10));
  text(percentagem+"% ABSTENÇÃO", 0, 0);
  popMatrix();

  imageMode(CENTER);
  image(img, width / 2, height / 2);

  fill(paleta1[0]);
  rectMode(CORNER);
  noStroke();

  float fimBarra = xbarra + barrades;
  rect(min(xbarra, fimBarra), height - height * 0.03, abs(barrades), height / 200);

  if (origemX != -1 && abs(barrades) >= inicioFase && animado == false) {
    animado = true;
    fase = 1;
  }

  stroke(paleta1[0]);
  strokeWeight(2);
  line(width / 2, height - height * 0.03, width / 2, height - height * 0.01);
}

void camadaveridica() {
  textLeading(tam*1.05);
  entrelinha=tam*1.05;
  background(bg);
  textAlign(LEFT);

  if (overlayAtivo == false && animado2 == false) {
    int tempoInicial2 = millis() - inicioCartaz2;

    if (tempoInicial2 >= 4000) {
      animado2 = true;
      fase = 4;
      inicioAnimacao2 = millis();
    }
  }

  if (animado2 == false) {

    textFont(ftex, tam);
    largura2 = x8;
    grossura2 = 0;
    tpver1 = tpver2 = tpver3 =tpver4=tpver5= 255;
  } else {
    if (fase == 4) {
      int tempo = millis() - inicioAnimacao2;
      if (tempo >= 2000) {
        tpver1 = 0;
      }

      if (tempo >= 4000) {
        tpver2 = 0;
      }

      if (tempo >= 6000) {
        tpver3 = 0;
        fase = 5;
      }
    } else if (fase == 5) {
      int tempo2 = millis() - inicioAnimacao2;

      if (tempo2 >= 10000) {
        tpver4 = 0;
      }

      if (tempo2 >= 12000) {
        tpver5 = 0;
        fase = 6;
      }
    } else if (fase == 6) {
      if (largura2 <= x8 + textWidth("9 EM CADA 10")) {
        largura2 += width*0.002;
        grossura2 = round(width*0.01);;
      }else{
       aparecerpopup = millis();
        fase = 7; }
      
    } else if (fase == 7) {
      int tempo3 = millis() - aparecerpopup;
      if (tempo3 >= 5000) {
        popupAtivado = true; 
      }
    
    }
    }
  

  float xAtual = width * 0.05;
  textFont(ftit, tam);

  fill(paleta2[1]);

  text(divisao2[0], xAtual, y5);

  String[] linhas = split(divisao2[0], "\n");
  String ultimaLinha = linhas[linhas.length - 1];

  float xDecide = xAtual + textWidth(ultimaLinha+ " ");
  float yDecide = y5 +(round(width * 0.055)*1.1);

  noStroke();
  rect(xDecide - tam*0.1, yDecide - tam*0.88, textWidth("DECIDE "), tam);

  fill(bg);
  text(destaque2, xDecide, yDecide);

  textFont(ftex, tam);
  fill(0);

  float x9 = x6;
  float y9 = y6;

  //BLOCO 1
  text(destaquever1_1, x9, y9);// 1 %

  x9 += textWidth(destaquever1_1);
  fill(0, tpver4);
  text(divisaotextver1_2[0], x9, y9); //de votos

  x9 += textWidth(divisaotextver1_2[0]);

  fill(0, tpver5);
  text(destaquever1_2, x9, y9); //distritais

  fill(0);
  x9 = x6;

  text(divisaotextver1_2[1], x9, y9); //decidiu a maioria absoluta em 2022

  // BLOCO 2
  float x10 = x7;
  float y10 = y7;

  text(divisaotextver2_1[0], x10, y10); //falta

  x10 += textWidth(divisaotextver2_1[0]);

  fill(0, tpver1);
  text(destaquever2_1, x10, y10); //de

  x10 = x7;

  fill(0);
  text(divisaotextver2_2[0], x10, y10); // comparencia nao

  x10 += textWidth("NÃO ");
  y10 += 2.15*entrelinha;

  fill(0, tpver2);
  text(destaquever2_2, x10, y10); //dá

  x10 += textWidth(destaquever2_2);

  fill(0);
  text(divisaotextver2_3[0], x10, y10); //direito

  x10 = x7;
  fill(0, tpver3);
  text(destaquever2_3, x10, y10); // a

  x10 += textWidth(destaquever2_3);

  y10+=1.05*entrelinha;

  fill(0);
  text(divisaotextver2_3[1], x10, y10); //criticar

  //BLOCO 3

  text("9 EM CADA 10 \nJOVENS JÁ \nVOTARAM", x8, y8);

  stroke(paleta2[0]);
  strokeWeight(grossura2);
  line(x8, y8 + width*0.01, largura2, y8 + width*0.01);

  textAlign(CENTER);
  textFont(ftit, tam);
  fill(paleta2[1]);

  text("40% ABSTENÇÃO", width / 2, height*0.94);

  imageMode(CENTER);
  image(img2, width / 2, height / 2);
}


void popup() {
  imageMode(CENTER);
  image(popup, width/2, height/2);
  fill(0);
  textAlign(CENTER);
  textSize(round(width*0.055)*1.2);
  text("CUIDADO:\nA DESINFORMAÇÃO \nPODE SER SUBTÍL", width/2, height/2-height*0.03);
}



void grelha() {
  stroke(0);
  strokeWeight(2);
  line(width * 0.05, 0, width * 0.05, height);
  line(width - (width * 0.05), 0, width - (width * 0.05), height);

  line(0, width * 0.05, width, width * 0.05);
  line(0, width * 0.3, width, width * 0.3);

  line(0, width * 1.56, width, width * 1.56);
  line(0, width * 1.68, width, width * 1.68);
}


void keyPressed() {
  if (key == 's') {
    saveFrame("######.png");
  }

  if (key == 'r') {
    overlayAtivo = true;
    animado = false;
    animado2 = false;
    fase = 0;

    inicioCartaz = millis();
    inicioCartaz2 = 0;
    inicioAnimacao = 0;
    inicioAnimacao2 = 0;

    p1 = new PVector(width, 0);
    p2 = new PVector(width, 0);
    p3 = new PVector(width, 0);

    barrades = 0;
    cres = 0;
    origemX = -1;
    alvo = false;
  }

  if (key=='t') {
    percentagem=round(random(5, 15));
    /*indiceft=int(random(0, 2));
     
     img = imagens[indiceft];
     img2 = imagens[indiceft + 3]; */

    if (indiceft==0) {
      y1 = random(height * 0.05, height * 0.09);
    y2 = random(height * 0.2, height * 0.3);
    y3 = random(height * 0.57, height * 0.6);
    y4 = random(height * 0.72, height * 0.76);

    y5 = random(height * 0.05, height * 0.13);
    y8 = random(height * 0.2, height * 0.35);
    y7 = random(height * 0.5, height * 0.6);
    y6 = random(height * 0.78, height * 0.82);

    x2=width * 0.05;
    x3=width*0.5;
    x4=width * 0.25;

    x8=width*0.55;
    x7=width*0.05;
    x6=width*0.4;
    } else if (indiceft==1) {
      y1 = random(height * 0.05, height * 0.09);
      y2 = random(height * 0.75, height * 0.76);
      y4=random(height*0.16, height*0.18);
      y3=random(height*0.58, height * 0.65);

      y5 = random(height * 0.05, height * 0.13);
      y6=random(height*0.2, height*0.27);
      y7=random(height*0.6, height*0.7);
      y8=random(height*0.75, height * 0.82);

      x2=width*0.25;
      x4= width*0.05;
      x3=width * 0.55;

      x6=width*0.07;
      x7=width * 0.55;
      x8=width*0.15;
    } else if (indiceft==2) {
      y1 = random(height * 0.05, height * 0.09);
      y2=random(height*0.2, height*0.21);
      y4=random(height*0.75, height*0.77);
      y3=random(height*0.65, height*0.67);

      y5 = random(height * 0.05, height * 0.13);
      y6= random(height*0.21, height*0.25);
      y7=random(height*0.72, height*0.75) ;
      y8=random(height*0.77, height*0.8);
      x2=width*0.35;
      x3= width*0.05;
      x4=width * 0.4;

      x6=width*0.35;
      x7=width * 0.07;
      x8=width*0.6;
    }
    largura=x3;
    largura2 = x8;
  }
    if (key == 'c' ) {
    modoDebug = !modoDebug; 
  }
}
