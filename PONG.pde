PFont minhaFonte; // Variável para armazenar a fonte
int larguraRaquete = 10; // Largura da raquete
int alturaRaquete = 45; // Altura da raquete
int raqueteOffset = 20; // Distância entre a raquete e a borda da tela
int raqueteSpeed = 5; // Velocidade da raquete

int diametroBola = 15; // Diâmetro da bola
float velocidadeXBola = 7; // Velocidade da bola no eixo x
float velocidadeYBola = 7; // Velocidade da bola no eixo y

int playerScore = 0; // Pontuação do jogador
int aiScore = 0; // Pontuação do computador

float bolaX, bolaY; // Posição da bola
float raquetePlayerY, raqueteAiY; // Posição das raquetes

boolean gameOver = false;

void setup() {
  size(800, 400);
  resetGame();
  // Carregar a fonte desejada
  minhaFonte = createFont("GraffitiUrban-Regular.otf", 32);
  
  textFont(minhaFonte);
}

void draw() {
  background(0);
  
  // Desenha linha central
  stroke(255);
  line(width / 2, 0, width / 2, height);
  
  
  
  // Desenha raquetes
  fill(255);
  rect(raqueteOffset, raquetePlayerY, larguraRaquete, alturaRaquete);
  rect(width - raqueteOffset - larguraRaquete, raqueteAiY, larguraRaquete, alturaRaquete);
  
  // Desenha bola com cor aleatória
  fill(random(255), random(255), random(255));
  ellipse(bolaX, bolaY, diametroBola, diametroBola);
  
  if (!gameOver) {
    // Movimenta bola
    bolaX += velocidadeXBola;
    bolaY += velocidadeYBola;
    
    // Verifica colisões com paredes
    if (bolaY <= 0 || bolaY >= height) {
      velocidadeYBola *= -1;
    }
    
    // Verifica colisões com raquetes
    if (bolaX <= raqueteOffset + larguraRaquete && bolaY > raquetePlayerY && bolaY < raquetePlayerY + alturaRaquete) {
      velocidadeXBola *= -1;
      playerScore++;
    }
    
    if (bolaX >= width - raqueteOffset - larguraRaquete && bolaY > raqueteAiY && bolaY < raqueteAiY + alturaRaquete) {
      velocidadeXBola *= -1;
      aiScore++;
    }
    
    // Move raquete do jogador com o mouse
    raquetePlayerY = constrain(mouseY - alturaRaquete / 2, 0, height - alturaRaquete);
    
    // Move raquete do computador
    raqueteAiY = constrain(bolaY - alturaRaquete / 2, 0, height - alturaRaquete);
  }
  
  // Desenha pontuação
  fill(255);
  textSize(50);
  fill(0, 255, 0);
  text(playerScore, width/4, 50);
  fill(255, 0, 0);
  text(aiScore, 3*width/4, 50);
  
  // Verifica fim de jogo
  if (playerScore >= 5 || aiScore >= 5) {
    textSize(100);
    if (playerScore >= 5) {
      fill(255, 0, 0);
      text("CPU Venceu!", width/2 - 180, height/2);
      
    } else {
      fill(0, 255, 0);
      text("Jogador Venceu!", width/2 - 250, height/2);
    }
    gameOver = true;
  }
}

void resetGame() {
  bolaX = width / 2;
  bolaY = height / 2;
  raquetePlayerY = height / 2 - alturaRaquete / 2;
  raqueteAiY = height / 2 - alturaRaquete / 2;
  velocidadeXBola *= random(1) > 0.5 ? 1 : -1;
  velocidadeYBola *= random(1) > 0.5 ? 1 : -1;
  playerScore = 0;
  aiScore = 0;
  gameOver = false;
}

void mouseClicked() {
  if (gameOver) {
    resetGame();
  }
}
