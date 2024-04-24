# LipeKing
// Variáveis para o tabuleiro
char[][] board;
int boardSize = 3;
int cellSize = 100;

// Variáveis para os jogadores
char currentPlayer = 'X';
boolean gameOver = false;
String winner = null;
boolean againstComputer = false; // Variável para determinar se o jogo é contra a máquina
boolean computerTurn = false; // Variável para controlar a vez da máquina jogar

Button computerButton;
boolean buttonClicked = false;

void setup() {
  size(300,300);
  board = new char[boardSize][boardSize];
  
  for (int i = 0; i < boardSize; i++) {
    for (int j = 0; j < boardSize; j++) {
      board[i][j] = ' ';
    }
  }
  
  // Inicializar o botão para escolher jogar contra a máquina
  computerButton = new Button(width/2 - 100, height - 40, 200, 30, "Play Against Computer");
}

void draw() {
  background(255);
  drawBoard();
  checkWinner();
  if (!buttonClicked) { // Mostrar o botão se ele não foi clicado ainda
    computerButton.display();
  }
  
  if (gameOver) {
    drawGameOver();
  }
}

void drawBoard() {
  strokeWeight(4);
  for (int i = 1; i < boardSize; i++) {
    line(i * cellSize, 0, i * cellSize, height);
    line(0, i * cellSize, width, i * cellSize);
  }
  for (int i = 0; i < boardSize; i++) {
    for (int j = 0; j < boardSize; j++) {
      char val = board[i][j];
      if (val == 'X') {
        drawX(i, j);
      } else if (val == 'O') {
        drawO(i, j);
      }
    }
  }
}

void drawX(int i, int j) {
  float x = i * cellSize + cellSize/4;
  float y = j * cellSize + cellSize/4;
  float w = cellSize/2;
  stroke(0, 255, 0); // verde
  line(x, y, x+w, y+w);
  line(x+w, y, x, y+w);
}

void drawO(int i, int j) {
  float x = i * cellSize + cellSize/4;
  float y = j * cellSize + cellSize/4;
  float w = cellSize/2;
  stroke(128, 0, 128); // roxo
  ellipseMode(CORNER);
  ellipse(x, y, w, w);
}

void drawGameOver() {
  fill(0);
  textSize(32);
  textAlign(CENTER, CENTER);
  text("Você perdeu, otário!", width/2, height/2);
  text("Click to restart", width/2, height/2 + 50);
}

void mouseClicked() {
  if (gameOver) {
    resetGame();
    return;
  }
  
  // Verificar se o jogador clicou no botão para jogar contra a máquina
  if (computerButton.isMouseInside(mouseX, mouseY)) {
    againstComputer = true;
    buttonClicked = true; // Marcar o botão como clicado
    return;
  }
  
  if (!againstComputer || currentPlayer == 'X') {
    int i = mouseX / cellSize;
    int j = mouseY / cellSize;
    if (board[i][j] == ' ') {
      board[i][j] = currentPlayer;
      if (currentPlayer == 'X') {
        currentPlayer = 'O';
        if (againstComputer) {
          computerTurn = true; // É a vez da máquina jogar
        }
      } else {
        currentPlayer = 'X';
      }
    }
  }
  
  if (againstComputer && currentPlayer == 'O' && computerTurn && !gameOver) {
    makeComputerMove();
    computerTurn = false; // Resetar a variável para a próxima jogada
  }
}

void resetGame() {
  gameOver = false;
  winner = null;
  currentPlayer = 'X';
  againstComputer = false; // Resetar a opção de jogar contra a máquina
  buttonClicked = false; // Resetar o botão para não clicado
  
  for (int i = 0; i < boardSize; i++) {
    for (int j = 0; j < boardSize; j++) {
      board[i][j] = ' ';
    }
  }
}

void makeComputerMove() {
  // Implementar lógica para que o computador faça uma jogada
  // Neste exemplo, o computador fará uma jogada aleatória
  int i, j;
  do {
    i = int(random(boardSize));
    j = int(random(boardSize));
  } while (board[i][j] != ' ');
  
  board[i][j] = currentPlayer;
  if (currentPlayer == 'X') {
    currentPlayer = 'O';
  } else {
    currentPlayer = 'X';
  }
}

void checkWinner() {
  for (int i = 0; i < boardSize; i++) {
    if (board[i][0] == board[i][1] && board[i][1] == board[i][2] && board[i][0] != ' ') {
      winner = "" + board[i][0];
      gameOver = true;
    }
    if (board[0][i] == board[1][i] && board[1][i] == board[2][i] && board[0][i] != ' ') {
      winner = "" + board[0][i];
      gameOver = true;
    }
  }
  if (board[0][0] == board[1][1] && board[1][1] == board[2][2] && board[0][0] != ' ') {
    winner = "" + board[0][0];
    gameOver = true;
  }
  if (board[0][2] == board[1][1] && board[1][1] == board[2][0] && board[0][2] != ' ') {
    winner = "" + board[0][2];
    gameOver = true;
  }
  
  // Verificar empate
  if (!gameOver && isBoardFull()) {
    gameOver = true;
    winner = "Empate";
  }
  
  if (winner != null) {
    println("Winner: " + winner);
  }
}

boolean isBoardFull() {
  for (int i = 0; i < boardSize; i++) {
    for (int j = 0; j < boardSize; j++) {
      if (board[i][j] == ' ') {
        return false;
      }
    }
  }
  return true;
}

class Button {
  float x, y, w, h;
  String label;
  
  Button(float x, float y, float w, float h, String label) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.label = label;
  }
  
  void display() {
    stroke(0);
    fill(200);
    rect(x, y, w, h);
    fill(0);
    textAlign(CENTER, CENTER);
    textSize(14);
    text(label, x + w/2, y + h/2);
  }
  
  boolean isMouseInside(float mx, float my) {
    return mx > x && mx < x + w && my > y && my < y + h;
  }
}