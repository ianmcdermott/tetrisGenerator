// Start with a shape at bottom, left/
// Check two spaces over, can we add a shape?
//is there more than one space? 
// if not, rule out all shapes two-blocked and above bottom shapes
// is there more than two spaces?
// if not, rule out all shapes three-blocked and above
int tetrominoW = 4;
int tetrominoH = 4;
int lb = 0;
boolean backstep = false;
int p;
int pieceCount = 0;
PVector scanner = new PVector(0, 0);
PVector scannerMin = new PVector(4, 4);
boolean next = false;
int[][][] tetromino = {

  { // O Matter What Direction
    {1, 1, 0, 0}, 
    {1, 1, 0, 0}, 
    {0, 0, 0, 0}, 
    {0, 0, 0, 0}
  }, 
  { // I Horiz
    {1, 1, 1, 1}, 
    {0, 0, 0, 0}, 
    {0, 0, 0, 0}, 
    {0, 0, 0, 0}
  }, 
  { // I Vert
    {1, 0, 0, 0}, 
    {1, 0, 0, 0}, 
    {1, 0, 0, 0}, 
    {1, 0, 0, 0}
  }, 
  { // Z Vert
    {1, 0, 0, 0}, 
    {1, 1, 0, 0}, 
    {0, 1, 0, 0}, 
    {0, 0, 0, 0}
  }, 
  { // Z Horiz
    {0, 1, 1, 0}, 
    {1, 1, 0, 0}, 
    {0, 0, 0, 0}, 
    {0, 0, 0, 0}
  }, 
  { // S Vert - 5
    {0, 1, 0, 0}, 
    {1, 1, 0, 0}, 
    {1, 0, 0, 0}, 
    {0, 0, 0, 0}
  }, 
  { // S Horiz - 6
    {1, 1, 0, 0}, 
    {0, 1, 1, 0}, 
    {0, 0, 0, 0}, 
    {0, 0, 0, 0}
  }, 
  { // L 0 - 7
    {1, 1, 0, 0}, 
    {1, 0, 0, 0}, 
    {1, 0, 0, 0}, 
    {0, 0, 0, 0}
  }, 
  { // L 90 - 8
    {1, 1, 1, 0}, 
    {0, 0, 1, 0}, 
    {0, 0, 0, 0}, 
    {0, 0, 0, 0}
  }, 
  { // L 180 - 9
    {0, 1, 0, 0}, 
    {0, 1, 0, 0}, 
    {1, 1, 0, 0}, 
    {0, 0, 0, 0}
  }, 
  { // L 270 - 10
    {1, 0, 0, 0}, 
    {1, 1, 1, 0}, 
    {0, 0, 0, 0}, 
    {0, 0, 0, 0}
  }, 
  { // J 0 - 11
    {1, 1, 0, 0}, 
    {0, 1, 0, 0}, 
    {0, 1, 0, 0}, 
    {0, 0, 0, 0}
  }, 
  { // J 90 - 12
    {1, 1, 1, 0}, 
    {1, 0, 0, 0}, 
    {0, 0, 0, 0}, 
    {0, 0, 0, 0}
  }, 
  { // J 180 - 13
    {1, 0, 0, 0}, 
    {1, 0, 0, 0}, 
    {1, 1, 0, 0}, 
    {0, 0, 0, 0}
  }, 
  { // J 270 - 14
    {0, 0, 1, 0}, 
    {1, 1, 1, 0}, 
    {0, 0, 0, 0}, 
    {0, 0, 0, 0}
  }
};

int piece = 0;//int(random(tetromino.length));
int xAdd = 0;
int yAdd = 0;
int blockWidth = 40;
Undergrid ug;
int count = 0;
int tetrominoSum = 0;
int overLayTotal = 0;
int rectX = 0;
int rectY = 0;
int firstBlock = 0;
int lastBlock = 3;

void setup() {
  size(800, 800);
  //create a grid where pixel i*blockwidth is false
  ug = new Undergrid(blockWidth);
  frameRate(20);
  addBlock();
  checkArea();
}

void draw() {  
  background(255);
  ug.display();
  if (next) {
    checkArea();

    if (overLayTotal <= 0) {
      pasteTetromino();
      count = 0;
      scanner.x+= lastBlock+1-firstBlock;
    }
    tetrominoSum = 0;
    overLayTotal = 0;
    //piece = int(random(tetromino.length));
    addBlock();
    next = false;
  }
  if (scanner.x >= 16) {
    scanner.x = scannerMin.x;
    scanner.y++;
  }
  if (piece >= tetromino.length) piece = 0;

  if (scanner.y >= 16) {
    scanner.y = scannerMin.y;
  }

  pushMatrix();
  translate(scanner.x*blockWidth, scanner.y*blockWidth);
  displayTetromino();
  displayLast();
  displayFirst();
  popMatrix();
  
  //next = true;
}

void addBlock() {
  //choose a random block
  lastBlock = 3;
  firstBlock = 0;
  piece++;// int(random(tetromino.length));
  count++;
  if (count > tetromino.length-1){
    scanner.x+=1;
    count = 0;
  }
  if (piece > tetromino.length-1) piece = 0;
  while (tetromino[piece][firstBlock][0] < 1) {
    firstBlock++;
    backstep = true;
  }

  while (tetromino[piece][lastBlock][0] < 1) {
    lastBlock--;
  }
}

void displayPredict() {
  for (int u = 0; u < 4; u++) {
    for (int v = 0; v < 4; v++) {
      if (tetromino[piece][u][v]  > 0) {
        strokeWeight(2);
        stroke(0, 255, 255);
        pushMatrix();
        //translate(-firstBlock*blockWidth, 0);
        rect((u)*blockWidth, v*blockWidth, blockWidth, blockWidth);
        popMatrix();
      }
    }
  }
}

void displayFirst() {
  noFill();
  stroke(0, 255, 100);
  ellipseMode(CORNER);
  ellipse(blockWidth*firstBlock-firstBlock*blockWidth, 0, blockWidth, blockWidth);
}

void displayLast() {
  noFill();
  stroke(255, 100, 100);
  ellipseMode(CORNER);
  ellipse(blockWidth*(lastBlock+1)-firstBlock*blockWidth, 0, blockWidth, blockWidth);
}

void displayScanner() {
}

void keyPressed() {
  if (key == 'a') {
    next = true;
  }
}

void checkArea() {
  getTetrominoSum();
  overLayTotal = 0;
  for (int i = 0; i < tetrominoW; i++) {
    for (int j = 0; j < tetrominoH; j++) {
      fill(0, 255, 0, 100);
      if( tetromino[piece][j][i] > 0) overLayTotal += ug.checkGrid(int(scanner.y+i), int((scanner.x+j)), 1);
    }
  }
  println("T: " + tetrominoSum);
  println("O: "+ overLayTotal);
}

void getTetrominoSum() {
  for (int i = 0; i < 4; i++) {
    for (int j = 0; j < tetrominoH; j++) {
      if (tetromino[piece][i][j] > 0) {
        tetrominoSum++;//
      }
    }
  }
}

void pasteTetromino() {
  int rando = int(random(50, 255));
  for (int i = 0; i < tetrominoW; i++) {
    for (int j = 0; j < tetrominoH; j++) {
      if (tetromino[piece][i][j] > 0) {
        ug.update(int(scanner.y+j), int((scanner.x+i-firstBlock)), rando);
      }
    }
  }
}

void displayTetromino() {
  for (int i = 0; i < tetrominoW; i++) {
    for (int j = 0; j < tetrominoH; j++) {
      if (tetromino[piece][i][j] > 0) fill(255, 0, 0);
      else noFill();
      noStroke();
      rect(int(scanner.x+i*blockWidth)-firstBlock*blockWidth, int(scanner.y+j*blockWidth), blockWidth, blockWidth);
      fill(255);
    }
  }
}
