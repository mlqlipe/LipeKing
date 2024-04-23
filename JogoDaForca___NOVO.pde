PFont minhaFonte; // Variável para armazenar a fonte
String[] palavras = {"VACA", "BODE", "CAVALO", "RATO", "TATU"};
String palavraSecreta;
String palavraAtual;
String[] letrasErradas = new String[6];
int tentativas = 0;
boolean fimDeJogo = false;



void setup() {
  size(400, 400);
  textAlign(CENTER, CENTER);
  novaPalavra();
  // Carregar a fonte desejada
  minhaFonte = createFont("GraffitiUrban-Regular.otf", 32);
  
  // Definir a fonte
  textFont(minhaFonte);
  }


void draw() {
 background(128);
  desenharForca();
  desenharPalavra();
  desenharLetrasErradas();
  fill(0); // Define a cor do texto como preto
  textSize(55); // Define o tamanho do texto como 32 pixels
    text("TEMA:", 300, 40); // Desenha o texto na posição (300, 60)
      fill(255, 0, 0); // Define a cor do texto como preto
  textSize(35); // Define o tamanho do texto como 32 pixels
    text("ANIMAL", 300, 85); // Desenha o texto na posição (300, 85)
 
  
  if (fimDeJogo) {
   
    textSize(45);
    fill(255, 0, 0);
    text("Fim de jogo! A palavra era:", width/2, height - 200);
    fill(0, 100, 0);
    textSize(40);
    text(" "+ palavraSecreta, width/2, height - 150);
    
    
    
  }  
  

}

void keyPressed() {
  if (!fimDeJogo) {
    char letraDigitada = key;
    if (Character.isLetter(letraDigitada)) {
      verificarLetra(letraDigitada);
    }
  }
}
void novaPalavra() {
  palavraSecreta = palavras[int(random(palavras.length))];
  palavraAtual = "";
  for (int i = 0; i < palavraSecreta.length(); i++) {
    palavraAtual += "_";
  }
}

void desenharForca() {
  stroke(0);
  strokeWeight(4);
  
  // Base
  line(50, height - 50, 250, height - 50);
  line(100, height - 50, 100, 50);
  line(100, 50, 200, 50);
  line(200, 50, 200, 100);
  
  //Cabeça
  if (tentativas >= 1) {
    fill(0);
    ellipse(200, 100, 40, 40);
}

  
  // Corpo
  if (tentativas >= 2) {
    line(200, 120, 200, 200);
  }
  
  // Braço esquerdo
  if (tentativas >= 3) {
    line(200, 140, 170, 160);
  }
  
  // Braço direito
  if (tentativas >= 4) {
    line(200, 140, 230, 160);
  }
  
  // Perna esquerda
  if (tentativas >= 5) {
    line(200, 200, 180, 230);
  }
  
  // Perna direita
  if (tentativas >= 6) {
    line(200, 200, 220, 230);
    fimDeJogo = true;
  }
}


void desenharPalavra() {
  textSize(32);
  fill(0);
  text(palavraAtual, width/2, height - 25);
}

void desenharLetrasErradas() {//Letras tentadas
  textSize(25);
  fill(0);
  for (int i = 0; i < letrasErradas.length; i++) {
    if (letrasErradas[i] != null) {
      text(letrasErradas[i], 50 + i * 30, 25);
    }
  }
}

void verificarLetra(char letra) {
  letra = Character.toUpperCase(letra);
  boolean letraEncontrada = false;
  for (int i = 0; i < palavraSecreta.length(); i++) {
    if (palavraSecreta.charAt(i) == letra) {
      palavraAtual = palavraAtual.substring(0, i) + letra + palavraAtual.substring(i + 1);
      letraEncontrada = true;
    }
  }
  
  if (!letraEncontrada) {
    letrasErradas[tentativas] = Character.toString(letra);
    tentativas++;
  }
  
  
  }
