
import processing.video.*;
import gab.opencv.*;
import java.awt.Rectangle;

Capture cam;
OpenCV opencv;

float barrades = 0;
float origemX = -1;
float xbarra;
float suavizacao = 0.15;

int tam, tamMax, tamMin, grossura, grossura2, tpver1, tpver2, percentagem, percentagem2, aparecerpopup;
int inicioAnimacao = 0;
int inicioAnimacao2 = 0;
int inicioCartaz = 0;
int inicioCartaz2 = 0;
int fase = 0;

PImage [] imagens= new PImage[6];
PImage img, img2, popup;
PImage frameCamadaSuperior;
int indiceft;
int[] persetor={41, 23, 31};
PVector p1, p2, p3;

color bg, bg2;

float largura, x, y, tamdes1, tamdes2, tamdes_1, tamdes_2, largura2, cres, inicioFase, entrelinha, entrelinha2;

color[] paleta1 = {#03e29d, #c1008f};
color[] paleta2 = {#ff206e, #eb4213};

float y1, y2, y3, y4, y5, y6, y7, y8, x2, x3, x4, x6, x7, x8;

PFont ftit, ftex;

float vx1 = 0;
float vy1 = 0;

float zonaEsquerda = 40;

String titulo1="AS CONTAS OCULTAS \nQUE TU PAGAS";
String destaque1="TU PAGAS";
String []divisao1= split(titulo1, destaque1);

String titulo2="+1 600 000  QUE \nELES TRAZEM";
String destaque2="+1 600 000";
String []divisao2= split(titulo2, destaque2);

String textodes1="IMIGRAÇÃO SUSTENTADA \nPELOS IMPOSTOS \nDOS PORTUGUESES";
String destaquedes1_1="IMPOSTOS \nDOS";
String []divisaotextdes1_1= split(textodes1, destaquedes1_1);

String textodes2="IMIGRANTES TÊM PRIORIDADE NA SAÚDE E EDUCAÇÃO";
String destaquedes2_1="IMIGRANTES";
String destaquedes2_2="NA";
String[] divisaotextdes2_1= split(textodes2, destaquedes2_1);
String[] divisaotextdes2_2= split(divisaotextdes2_1[1], destaquedes2_2);

String textver1="CONTRIBUEM 5X MAIS \nDO QUE RECEBEM";
String destaquever1_1="CONTRIBUEM 5X MAIS";
String[] divisaotextver1_1= split (textver1, destaquever1_1);

String textover2="APENAS 4% DOS BENEFICIÁRIOS DO RSI SÃO ESTRANGEIROS";
String destaquever2_1="DOS BENEFICIÁRIOS";
String[] divisaotextver2_1=split(textover2, destaquever2_1);

String []setor={"AGRICULTURA \nE PESCA", "CONSTRUÇÃO \nCIVIL", "TURISMO"};
boolean animado = false;
boolean animado2 = false;

boolean alvo=false;

boolean overlayAtivo = true;
float limiteRemocao;
boolean popupAtivado = false;
boolean modoDebug = false;

void setup() {
  size(360, 640, P3D);
  textureMode(IMAGE);

  limiteRemocao = height - height * 0.005;

  bg = color(#f4f4f4);
  bg2=color(#141414);

  tam=round(width*0.055);
  tamMax=round(width*0.082);
  tamMin=round(width*0.040);

  ftit = createFont("black.otf", tamMax);
  ftex = createFont("medium.otf", tamMax);

  percentagem=round(random(65, 87));
  percentagem2=round(random(80, 98));

  imagens[0]=loadImage("imi1.png");
  imagens[0].resize(round(width * 0.8), 0);

  imagens[1]=loadImage("imi2.png");
  imagens[1].resize(round(width * 0.9), 0);

  imagens[2]=loadImage("imi3.png");
  imagens[2].resize(round(width ), 0);

  imagens[3]=loadImage("imi4.png");
  imagens[3].resize(round(width * 0.9), 0);

  imagens[4]=loadImage("imi5.png");
  imagens[4].resize(round(width * 0.9), 0);

  imagens[5]=loadImage("imi6.png");
  imagens[5].resize(round(width ), 0);

 //indiceft=int(random(0, 3));
 indiceft=2;
  img = imagens[indiceft];
  img2 = imagens[indiceft + 3];

  if (indiceft==0) {
    y1 = random(height * 0.05, height * 0.07);
    y2=random(height*0.78, height*0.81);
    y3=height*0.22;
    y4=height*0.33;
    y3=random(height*0.21, height*0.22);
    y4=random(height*0.31, height*0.32);

    y5 = random(height * 0.05, height * 0.13);
    y6=random(height*0.2, height*0.24);
    y7=random(height*0.8, height*0.82);
    y8=random(height*0.71, height*0.72);

    x2=width*0.05;
    x3=width*0.05;
    x4=width*0.6;

    x6=width*0.1;
    x7=width*0.05;
    x8=width*0.6;
  } else if ( indiceft==1) {
    y1 = random(height * 0.05, height * 0.07);
    y2=random(height*0.78, height*0.82);
    y3=random(height*0.21, height*0.25);
    y4=random(height*0.35, height*0.38);

    y5 = random(height * 0.05, height * 0.13);
    y6=random(height*0.2, height*0.22);

    y7=random(height*0.72, height*0.8);
    y8=random(height*0.4, height*0.5);

    x2=width*0.07;
    x3=width*0.12;
    x4=width*0.55;

    x6=width*0.15;
    x7=width*0.3;
    x8=width*0.05;
  } else if ( indiceft==2) {
    y1 = random(height * 0.05, height * 0.07);
    y2=random(height*0.79, height*0.82);
    y4=random(height*0.15, height*0.18);
    y3=random(height*0.3, height*0.31);

    y5 = random(height * 0.05, height * 0.13);
    y6=random(height*0.24, height*0.3);
    y7=random(height*0.72, height*0.8);
    y8=random(height*0.65, height*0.7);

    x2=width*0.05;
    x4=width*0.6;
    x3=width*0.12;

    x6=width*0.15;
    x7=width*0.05;
    x8=width*0.7;
  }


  popup= loadImage("popup.png");
  popup.resize(width, 0);

  p1 = new PVector(width, 0);
  p2 = new PVector(width, 0);
  p3 = new PVector(width, 0);

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

  if (animado==false) {
    textFont(ftex);
    textSize(tam);
    largura = textWidth("SÃO ");
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
    } else if (fase==3) {
      if (largura < textWidth("SÃO " + percentagem2 + "% ")) {
        largura += width*0.002;
        grossura = 4;
      }
    }
  }

  background(bg2);
  imageMode(CENTER);
  image(img, width/2, height/2);

  textAlign(LEFT);

  // Título
  textFont(ftit);
  textSize(tam);

  int tempoinicial = millis() - inicioCartaz;

  pushMatrix();
  translate(width*0.05, y1);
  rotate(radians(-10));
  fill(paleta1[1]);

  float xAtual = 0;
  float yAtual = y1;
  text(divisao1[0], xAtual, yAtual);

  xAtual += textWidth("QUE ");
  yAtual += tam*1.05;

  noStroke();
  rect(xAtual-tam*0.1, yAtual-tam, textWidth("TU PAGAS ")+2, tam+tam*0.2);
  fill(bg2);
  text(destaque1, xAtual, yAtual); //tu pagas
  popMatrix();

  textFont(ftex);
  fill(255);

  entrelinha=tamdes1*1.05;
  entrelinha2=tamdes2*1.05;

  // BLOCO 1

  if (tempoinicial >= 3000) {
    pushMatrix();
    translate(x2, y2);
    rotate(radians(-10));
    float xx1 = 0;
    float yy1 = 0;
    String[] linhaDepoisDos = split(destaquedes1_1, "\n");
    textSize(tamdes1);
    text(divisaotextdes1_1[0], xx1, yy1); //imigração sustentada pelos


    if (tempoinicial >= 5000) {

      xx1 += textWidth("PELOS ");
      yy1 += entrelinha+width*0.004;
      textSize(tamdes_1);
      text(linhaDepoisDos[0], xx1, yy1); //impostos
      xx1=0;
      yy1 += entrelinha;
      text(linhaDepoisDos[1], xx1, yy1); //dos
    }

    if (tempoinicial >= 6000) {
      xx1 = textWidth(linhaDepoisDos[1]);
      textSize(tamdes1);
      text(divisaotextdes1_1[1], xx1, yy1); //portugueses
    }
    popMatrix();
  }



  // BLOCO 2

  if (tempoinicial >= 6500) {
    pushMatrix();
    translate(x4, y4);
    rotate(radians(-10));
    textLeading(0);
    textSize(tam);


    text("SÃO " + percentagem2 + "%", 0, 0); //sao xx%

    if (tempoinicial >= 7500) {
      text("DO SETOR", 0, tam*1.05); //do setor
    }

    if (tempoinicial >= 9000) {
      text(setor[indiceft], 0, (tam*1.05)*2); // xxxxxxxxxx
    }

    stroke(paleta1[0]);
    strokeWeight(grossura);
    line(textWidth("SÃO "), 3, largura, 3);
    popMatrix();
  }


  // BLOCO 3

  if (tempoinicial >= 9500) {
    pushMatrix();
    translate(x3, y3);
    rotate(radians(-10));
    float x = 0;
    float y = 0;

    textSize(tamdes_2);
    text(destaquedes2_1, x, y); //imigrantes


    if (tempoinicial >= 10000) {
      x = -width*0.01;
      y += entrelinha2;
      textSize(tamdes2);
      text(divisaotextdes2_2[0], x, y); //tem prioridade
    }


    if (tempoinicial >= 11000) {
      x += width*0.01;
      y += entrelinha2;
      textSize(tamdes_2);
      text(destaquedes2_2, x, y); // na
    }

    if (tempoinicial >= 12000) {
      x += textWidth(destaquedes2_2);

      textSize(tamdes2);
      text(divisaotextdes2_2[1], x, y); //saude e educação
    }
    popMatrix();
  }

  pushMatrix();
  textFont(ftit, tam);
  textAlign(CENTER);
  fill(paleta1[1]);
  translate(width/2, height*0.92);
  rotate(radians(-10));
  text(percentagem+"% IMIGRANTES", 0, 0);
  popMatrix();

  fill(paleta1[0]);
  rectMode(CORNER);
  noStroke();

  float fimBarra = xbarra + barrades;
  rect(min(xbarra, fimBarra), height - height * 0.03, abs(barrades), height / 200);

  if (origemX != -1 && abs(barrades) >= inicioFase && animado == false) {
    animado = true;
    fase = 1;
    inicioAnimacao = millis();
  }

  stroke(paleta1[0]);
  strokeWeight(2);
  line(width / 2, height - height * 0.03, width / 2, height - height * 0.01);
}




void camadaveridica() {
  background(bg);
  textLeading(tam*1.05);
  entrelinha=tam*1.05;
  background(bg);
  imageMode(CENTER);
  image(img2, width/2, height/2);

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

    largura2 = x8 + textWidth("SÃO ");
    grossura2 = 0;
    tpver1 = tpver2 = 255;
  } else {
    if (fase == 4) {
      int tempo = millis() - inicioAnimacao2;
      if (tempo >= 2000) {
        tpver1 = 0;

        fase = 5;
      }
    } else if (fase == 5) {
      int tempo2 = millis() - inicioAnimacao2;

      if (tempo2 >= 10000) {
        tpver2 = 0;

        fase = 6;
      }
    } else if (fase==6) {
      if (largura2 <= x8 + textWidth("SÃO " + persetor[indiceft] + "% ")) {
        largura2 += width*0.002;
        grossura2 = 4;
      } else {
        aparecerpopup = millis();
        fase = 7;
      }
    } else if (fase == 7) {
      int tempo3 = millis() - aparecerpopup;
      if (tempo3 >= 5000) {
        popupAtivado = true;
      }
    }
  }

  float xAtual2 = width * 0.05;
  float yAtual2 = y5;
  textFont(ftit, tam);


  fill(paleta2[1]);
  noStroke();
  rect(xAtual2-tam*0.1, yAtual2-tam*0.88, textWidth("+1 600 000  "), tam);

  fill(bg);
  text(destaque2, xAtual2, yAtual2);
  xAtual2 += textWidth(destaque2+" ");
  fill(paleta2[1]);
  String[] linhaDepoisQue = split(divisao2[1], "\n");

  text(linhaDepoisQue[0], xAtual2, yAtual2);
  xAtual2 = width*0.05;
  yAtual2 += entrelinha;
  text(linhaDepoisQue[1], xAtual2, yAtual2);


  textFont(ftex, tam);
  fill(0);
  float x9 = x6;
  float y9 = y6;


  text(destaquever1_1, x9, y9); //contribuem 5x mais

  fill(0, tpver1);
  text(divisaotextver1_1[1], x9, y9); //do que recebem

  float x10 = x7;
  float y10 = y7;

  fill(0);
  text(divisaotextver2_1[0], x10, y10);  //apenas 4%
  x10=x7;
  y10+= entrelinha;
  fill(0, tpver2);
  text(destaquever2_1, x10, y10); // dos beneficiários

  fill(0);

  x10=x7-width*0.008;
  y10+= entrelinha;

  text(divisaotextver2_1[1], x10, y10); //do RSI são estrangeiros



  stroke(paleta2[0]);
  strokeWeight(grossura2);
  textSize(tam);

  line(x8 + textWidth("SÃO "), y8 + 3, largura2, y8 + 3);
  text("SÃO "+persetor[indiceft]+"% \nDO SETOR \n"+setor[indiceft], x8, y8);

  textAlign(CENTER);
  textFont(ftit);
  fill(paleta2[1]);
  textSize(tam);
  text("ENTRE 16% E 18% IMIGRANTES", width/2, height*0.94);
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
  if (key=='s') {
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
  }

  if (key=='t') {
    /*indiceft=int(random(0, 2));
     
     img = imagens[indiceft];
     img2 = imagens[indiceft + 3]; */


    if (indiceft==0) {
      y1 = random(height * 0.05, height * 0.07);
      y2=random(height*0.78, height*0.81);
      y3=height*0.22;
      y4=height*0.33;
      y3=random(height*0.21, height*0.22);
      y4=random(height*0.31, height*0.32);

      y5 = random(height * 0.05, height * 0.13);
      y6=random(height*0.2, height*0.24);
      y7=random(height*0.8, height*0.82);
      y8=random(height*0.71, height*0.72);

      x2=width*0.05;
      x3=width*0.05;
      x4=width*0.6;

      x6=width*0.1;
      x7=width*0.05;
      x8=width*0.6;
    } else if ( indiceft==1) {
      y1 = random(height * 0.05, height * 0.07);
      y2=random(height*0.78, height*0.82);
      y3=random(height*0.21, height*0.25);
      y4=random(height*0.35, height*0.38);

      y5 = random(height * 0.05, height * 0.13);
      y6=random(height*0.2, height*0.22);

      y7=random(height*0.72, height*0.8);
      y8=random(height*0.4, height*0.5);

      x2=width*0.07;
      x3=width*0.12;
      x4=width*0.55;

      x6=width*0.15;
      x7=width*0.3;
      x8=width*0.05;
    } else if ( indiceft==2) {
      y1 = random(height * 0.05, height * 0.07);
      y2=random(height*0.79, height*0.82);
      y4=random(height*0.15, height*0.18);
      y3=random(height*0.3, height*0.31);

      y5 = random(height * 0.05, height * 0.13);
      y6=random(height*0.24, height*0.3);
      y7=random(height*0.72, height*0.8);
      y8=random(height*0.65, height*0.7);

      x2=width*0.05;
      x4=width*0.6;
      x3=width*0.12;

      x6=width*0.15;
      x7=width*0.05;
      x8=width*0.7;
    }
    largura2 = x8+textWidth("SÃO ");
    largura= textWidth("SÃO ");
  }
  if (key == 'c' ) {
    modoDebug = !modoDebug;
  }
}
