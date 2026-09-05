
import processing.video.*;
import gab.opencv.*;
import java.awt.Rectangle;

Capture cam;
OpenCV opencv;

float barrades = 0;
float origemX = -1;
float xbarra;
float suavizacao = 0.15;

int tam, tamMax, tamMin, grossura, grossura2, tpver1, tpver2, tpver3, percentagem, percentagem2, aparecerpopup;
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
float largura, x, y, tamdes1, tamdes2, tamdes_1, tamdes_2, largura2, cres, inicioFase, entrelinha, entrelinha2;


color bg, bg2;
color[] paleta1 = {#c1008f, #fbff12};
color[] paleta2 = {#3f22ec, #ff206e};

float y1, y2, y3, y4, y5, y6, y7, y8, x2, x3, x4, x6, x7, x8;

PFont ftit, ftex;

float vx1 = 0;
float vy1 = 0;
float zonaEsquerda = 40;

String titulo1="CORRUPÇÃO: 2 EM 3 PORTUGUESES";
String destaque1="2 EM 3";
String []divisao= split(titulo1, destaque1);

String titulo2="PORTUGAL: MAIS HONESTO \nDO QUE PARECE";
String destaque2="MAIS HONESTO";
String []divisao2= split(titulo2, destaque2);

String textodes1="AVALIAÇÕES OFICIAIS MOSTRAM \nQUEDA DRÁSTICA NOS INDICADORES";
String destaquedes1_1="AVALIAÇÕES OFICIAIS";
String destaquedes1_2="QUEDA DRÁSTICA";
String[] divisaotextdes1_1= split(textodes1, destaquedes1_1);
String[] divisaotextdes1_2= split(divisaotextdes1_1[1], destaquedes1_2);

String textodes2= "60% CONFESSA TER \nPAGO SUBORNOS";
String destaquedes2_1="CONFESSA TER";
String []divisaotextdes2_1= split(textodes2, destaquedes2_1);

String textover1="MANTÉM 2 CLASSIFICAÇÕES, \nMELHORA 3 E PIORA 2";
String destaquever1_1="CLASSIFICAÇÕES,";
String[] divisaotextver1_1= split (textover1, destaquever1_1);

String textover2="ACIMA \nDA MÉDIA GLOBAL, \n8 PONTOS ABAIXO DA EUROPEIA";
String destaquever2_1="\nDA";
String destaquever2_2="PONTOS";
String[] divisaotextver2_1=split(textover2, destaquever2_1);
String[] divisaotextver2_2=split(divisaotextver2_1[1], destaquever2_2);

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
  tamMax= round(width*0.082);
  tamMin=round(width*0.040);

  ftit = createFont("black.otf", tamMax);
  ftex = createFont("medium.otf", tamMax);

  percentagem=round(random(65, 87));
  percentagem2=round(random(80, 98));

  imagens[0]=loadImage("cor1.png");
  imagens[0].resize(round(width * 0.8), 0);

  imagens[1]=loadImage("cor2.png");
  imagens[1].resize(round(width * 0.9), 0);

  imagens[2]=loadImage("cor3.png");
  imagens[2].resize(round(width ), 0);

  imagens[3]=loadImage("cor4.png");
  imagens[3].resize(round(width * 0.9), 0);

  imagens[4]=loadImage("cor5.png");
  imagens[4].resize(round(width * 0.9), 0);

  imagens[5]=loadImage("cor6.png");
  imagens[5].resize(round(width ), 0);

 indiceft=int(random(0, 3));

  img = imagens[indiceft];
  img2 = imagens[indiceft + 3];

  if (indiceft==0) {
    y1 = random(height * 0.02, height * 0.04);
    y2 = random(height * 0.15, height * 0.18);
    y3 = random(height * 0.75, height * 0.76);
    y4 = random(height * 0.61, height * 0.62);

    y5 = random(height * 0.05, height * 0.13);
    y6 = random(height * 0.23, height * 0.26);
    y7 = random(height * 0.71, height * 0.74);
    y8 = random(height * 0.82, height * 0.84);

    x2=width * 0.10;
    x4=width*0.05;
    x3=width * 0.4;

    x6=width*0.2;
    x7=width*0.05;
    x8=width*0.4;
  } else if (indiceft==1) {
    y1 = random(height * 0.02, height * 0.04);
    y2 = random(height * 0.7, height * 0.71);
    y3=random(height*0.23, height*0.28);
    y4=random(height*0.54, height * 0.56);

    y5 = random(height * 0.05, height * 0.13);
    y6=random(height*0.2, height*0.27);
    y7=random(height*0.64, height*0.7);
    y8=random(height*0.8, height * 0.84);

    x2=width*0.15;
    x3=width * 0.37;
    x4= width*0.05;

    x6=width*0.2;
    x7=width * 0.05;
    x8=width*0.4;
  } else if (indiceft==2) {
    y1 = random(height * 0.02, height * 0.04);
    y2=random(height*0.2, height*0.21);
    y4=random(height*0.65, height*0.68);
    y3=random(height*0.72, height*0.74);

    y5 = random(height * 0.05, height * 0.13);
    y7= random(height*0.21, height*0.29);
    y6=random(height*0.7, height*0.73) ;
    y8=random(height*0.81, height*0.84);

    x2=width*0.1;
    x4= width*0.55;
    x3=width * 0.05;

    x6=width*0.05;
    x7=width * 0.1;
    x8=width*0.4;
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
      if (largura < textWidth("MAIS CORRUPTOS")) {
        largura += width*0.002;
        grossura = 4;
      }
    }
  }

  entrelinha=tamdes1*1.05;
  entrelinha2=tamdes2*1.05;

  pushMatrix();

  translate(width/2, height/2);
  rotate(radians(30));
  imageMode(CENTER);
  image(img, 0, 0);

  popMatrix();

  textAlign(LEFT);

  //titulo
  textFont(ftit, tam);
  fill(paleta1[1]);
  pushMatrix();
  translate(width*0.05, y1);
  rotate(radians(15));

  float xAtual=0;
  float yAtual= y1;

  text(divisao[0], xAtual, yAtual);

  xAtual+= textWidth(divisao[0]);

  noStroke();
  rect(xAtual-tam*0.1, yAtual-tam, textWidth("2 EM 3  "), tam+tam*0.2);

  fill(bg2);

  text(destaque1, xAtual, yAtual);

  xAtual=0;
  yAtual+= tam*1.05;

  fill(paleta1[1]);
  text(divisao[1], xAtual, yAtual);
  popMatrix();

  textFont(ftex, tam);

  fill(255);

  int tempoinicial = millis() - inicioCartaz;

  if (tempoinicial>=4000) {
    pushMatrix();
    translate(x2, y2);
    rotate(radians(15));

    float xx1=width*0.015;
    float yy1= 0;

    //BLOCO 1
    textSize(tamdes1);
    text(destaquedes1_1, xx1, yy1); //avaliaçoes oficiais

    xx1=0;
    yy1+=entrelinha;

    textSize(tamdes_1);

    if (tempoinicial >= 4500) {
      text(divisaotextdes1_2[0], xx1, yy1); //mostram

      xx1=textWidth(divisaotextdes1_2[0]);

      textSize(tamdes1);
    }

    if (tempoinicial >=5500) {
      text(destaquedes1_2, xx1, yy1); //queda drastica

      xx1=0;

      yy1+=entrelinha;
    }

    if (tempoinicial >=6000) {
      textSize(tamdes_1);

      text(divisaotextdes1_2[1], xx1, yy1);
    }//nos indicadores
    popMatrix();
  }

  //BLOCO 2
  if (tempoinicial>= 7000) {

    pushMatrix();
    translate(x3, y3);
    rotate(radians(15));
    textLeading(tam*1.05);

    float xx2=0;
    float yy2= 0;

    textSize(tamdes2);
    text(divisaotextdes2_1[0], xx2, yy2); //60%
    xx2+=textWidth(divisaotextdes2_1[0]);
    textSize(tamdes_2);

    if (tempoinicial>=7500) {
      text(destaquedes2_1, xx2, yy2);//confessa ter
      textSize(tamdes2);
      xx2=0;
    }

    if (tempoinicial>=8500) {
      text(divisaotextdes2_1[1], xx2, yy2); //pago subornos
    }
    popMatrix();
  }

  //BLOCO 3
  if (tempoinicial >=8500) {
    pushMatrix();
    translate(x4, y4);
    rotate(radians(15));
    textLeading(tam*1.05);
    textSize(tam);

    float xx3=0;
    float yy3=0;

    stroke(paleta1[0]);
    strokeWeight(grossura);
    line(xx3, tam*1.05+3, largura, tam*1.05+3);

    text("DOS PAÍSES", xx3, yy3);

    if (tempoinicial>=9500) {
      text("\nMAIS CORRUPTOS", xx3, yy3);
    }

    if (tempoinicial>= 10000) {
      yy3+=tam*1.05;

      text("\nDO MUNDO", xx3, yy3);
    }
    popMatrix();
  }

  pushMatrix();
  textFont(ftit, tam);
  textAlign(CENTER);
  fill(paleta1[1]);
  translate(width/2, height*0.92);
  rotate(radians(15));

  text("57% CORRUPTOS", 0, 0);
  popMatrix();

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
    tpver1 = tpver2 = tpver3= 255;
  } else {
    if (fase == 4) {
      int tempo = millis() - inicioAnimacao2;
      if (tempo >= 2000) {
        tpver1 = 0;
        fase=5;
      }
    } else if (fase == 5) {
      int tempo2 = millis() - inicioAnimacao2;

      if (tempo2 >= 4000) {
        tpver2 = 0;
      }

      if (tempo2 >= 6000) {
        tpver3 = 0;
        fase = 6;
      }
    } else if (fase == 6) {
      if (largura2 <= x8 + textWidth("APENAS 2-5%")) {
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

  float xAtual = width * 0.07;
  float yAtual=y5;

  textFont(ftit, tam);

  fill(paleta2[1]);
  text(divisao2[0], xAtual, yAtual); //portugal:
  xAtual+=textWidth(divisao[0]);
  noStroke();
  rect(xAtual- tam*0.1, yAtual- tam*0.88, textWidth(" MAIS HONESTO "), tam);
  fill(bg);
  text(destaque2, xAtual, yAtual); //mais honesto

  xAtual=width * 0.07;

  fill(paleta2[1]);
  text(divisao2[1], xAtual, yAtual); //do que parece

  textFont(ftex, tam);

  fill(0);

  float x9 = x6;
  float y9 = y6;

  // BLOCO 1

  text(divisaotextver1_1[0], x9, y9); //mantem 2
  x9+=textWidth(divisaotextver1_1[0]);
  fill(0, tpver1);
  text(destaquever1_1, x9, y9); //classificaçoes
  x9=x6;
  fill(0);
  text(divisaotextver1_1[1], x9, y9);//melhora 3 e piora 2

  //BLOCO 2
  float x10 = x7;
  float y10 = y7;

  text(divisaotextver2_1[0], x10, y10); //acima
  x10+=textWidth(divisaotextver2_1[0]);
  y10-=entrelinha*1.1;

  fill(0, tpver2);
  text(destaquever2_1, x10, y10); //da

  String[] divisaoMedia =split (divisaotextver2_2[0], "\n");

  x10+=textWidth(destaquever2_1);
  y10+=entrelinha*1.1;

  fill(0);
  text(divisaoMedia[0], x10, y10);//media global

  x10=x7;
  y10+=entrelinha;

  text(divisaoMedia[1], x10, y10); //8
  x10+=textWidth(divisaoMedia[1]);
  fill(0, tpver3);
  text(destaquever2_2, x10, y10); //pontos

  x10+=textWidth(destaquever2_2);
  fill(0);
  text(divisaotextver2_2[1], x10, y10); //abaixo da europeia

  //BLOCO 3
  text("APENAS 2-5% ADMITE \nTER PAGO SUBORNOS", x8, y8);
  
  stroke(paleta2[0]);
  strokeWeight(grossura2);
  line(x8, y8 + 3, largura2, y8 + 3);

  textAlign(CENTER);
  textFont(ftit, tam);
  fill(paleta2[1]);

  text("57% HONESTO", width / 2, height*0.94);

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
      y1 = random(height * 0.02, height * 0.04);
      y2 = random(height * 0.2, height * 0.21);
      y3 = random(height * 0.75, height * 0.76);
      y4 = random(height * 0.61, height * 0.62);

      y5 = random(height * 0.05, height * 0.13);
      y6 = random(height * 0.23, height * 0.26);
      y7 = random(height * 0.71, height * 0.74);
      y8 = random(height * 0.82, height * 0.84);

      x2=width * 0.10;
      x4=width*0.05;
      x3=width * 0.4;
      
      x6=width*0.2;
      x7=width*0.05;
      x8=width*0.4;
    } else if (indiceft==1) {
      y1 = random(height * 0.02, height * 0.04);
      y2 = random(height * 0.7, height * 0.71);
      y3=random(height*0.23, height*0.28);
      y4=random(height*0.54, height * 0.56);

      y5 = random(height * 0.05, height * 0.13);
      y6=random(height*0.2, height*0.27);
      y7=random(height*0.64, height*0.7);
      y8=random(height*0.8, height * 0.84);

      x2=width*0.15;
      x3=width * 0.37;
      x4= width*0.05;

      x6=width*0.2;
      x7=width * 0.05;
      x8=width*0.4;
    } else if (indiceft==2) {
      y1 = random(height * 0.02, height * 0.04);
      y2=random(height*0.2, height*0.21);
      y4=random(height*0.65, height*0.68);
      y3=random(height*0.72, height*0.74);
      
      y5 = random(height * 0.05, height * 0.13);
      y7= random(height*0.21, height*0.29);
      y6=random(height*0.7, height*0.73) ;
      y8=random(height*0.81, height*0.84);

      x2=width*0.1;
      x4= width*0.55;
      x3=width * 0.05;

      x6=width*0.05;
      x7=width * 0.1;
      x8=width*0.4;
    }

    largura=x3;
    largura2 = x8;
  }

  if (key == 'c' ) {
    modoDebug = !modoDebug;
  }
}
