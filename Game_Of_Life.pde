// CS 7492 - Simulation of Biology
// Warm-up Assignment - The Game of Life Simulator
// Author: Austin Passmore

boolean stepGenerationFlag = false;
boolean continuousFlag = false;

int cellSize = 8;    // each grid space is 6x6 pixels
int gridSizeX = 100;  // the grid will be 100x100 cells
int gridSizeY = 100;

// grid[i][j], i == y and j == x
int[][] lifeArray = new int[gridSizeY][gridSizeX];
int[][] neighborArray = new int[gridSizeY][gridSizeX];

void setup() {
  size(800, 800);
  zeroOut();
  
  background(0, 0, 0);     // set the background to black
  noStroke();
  
  //testGlider();
  testGliderGun();
  drawCells();
  //print("Calculated neighbors: " + str(neighborArray[1][1]));
}

void draw() {
  if (continuousFlag) {
    stepGenerationFlag = false;
    calcNeighbors();
    updateGeneration();
    drawCells();
    delay(750);
  }
  if (stepGenerationFlag) {
    calcNeighbors();
    updateGeneration();
    drawCells();
    stepGenerationFlag = false;
  }
}

// Toggle a cell to be alive or dead
void mousePressed() {
  int iIndex = mouseY / cellSize;
  int jIndex = mouseX / cellSize;
  lifeArray[iIndex][jIndex] = (lifeArray[iIndex][jIndex] + 1) % 2;
  calcNeighbors();
  drawCells();
}

// Controls keyboard inputs
void keyPressed() {
  if (key == 'g' || key == 'G') {  // Step through one generation
    continuousFlag = false;
    stepGenerationFlag = true;
  } else if (key == ' ') {  // Continuous simulation
    stepGenerationFlag = false;
    continuousFlag = !continuousFlag;
  } else if (key == 'c' || key == 'C') {  // Clear the screen to all black
    stepGenerationFlag = false;
    continuousFlag = false;
    zeroOut();
    drawCells();
  } else if (key == 'r' || key == 'R') {  // Randomize the screen
    stepGenerationFlag = false;
    continuousFlag = false;
    zeroOut();
    randomizeCells();
    drawCells();
  }
}

// Colors each cell white or black depending if the cell is alive (1) or dead (0) respectively
void drawCells() {
  for (int i = 0; i < gridSizeY; i++) {
    for (int j = 0; j < gridSizeX; j++) {
      int isAlive = lifeArray[i][j];
      int cellColor = isAlive * 255;
      fill(cellColor, cellColor, cellColor);
      rect(j * cellSize, i * cellSize, cellSize, cellSize); 
    }
  }
}

// Zeros out each array
void zeroOut() {
  for (int i = 0; i < gridSizeY; i++) {
    for (int j = 0; j < gridSizeX; j++) {
      lifeArray[i][j] = 0;
      lifeArray[i][j] = 0;
    }
  }
}

// Calculates how many neighbors each cell has and updates the neightborArray.
void calcNeighbors() {
  // Clear the neighborArray
  for (int i = 0; i < gridSizeY; i++) {
    for (int j = 0; j < gridSizeX; j++) {
      neighborArray[i][j] = 0;
    }
  }
  
  for (int i = 0; i < gridSizeY; i++) {
    for (int j = 0; j < gridSizeX; j++) {
      for (int xn = -1; xn <= 1; xn++) {
        for (int yn = -1; yn <= 1; yn++) {
          if (xn == 0 && yn == 0) { 
            continue;
          } else {
            int xx = (j + xn + gridSizeX) % gridSizeX;
            int yy = (i + yn + gridSizeY) % gridSizeY;
            //if (j == 1 && i == 1) { print(lifeArray[xx][yy]); }
            neighborArray[i][j] += lifeArray[yy][xx];
          }
        }
      }
    }
  }
  //print('\n');
}

// Updates the next generation of cells based on neighbors
void updateGeneration() {
  for (int i = 0; i < gridSizeY; i++) {
    for (int j = 0; j < gridSizeX; j++) {
      if (lifeArray[i][j] == 1 && (neighborArray[i][j] == 2)) {
        lifeArray[i][j] = 1;      
      } else if (lifeArray[i][j] == 1 && (neighborArray[i][j] == 3)) {
        lifeArray[i][j] = 1;  
      } else if (lifeArray[i][j] == 0 && neighborArray[i][j] == 3) {
        lifeArray[i][j] = 1;
      } else {
        lifeArray[i][j] = 0;
      }
    }
  }
}

// Randomizes the cells
void randomizeCells() {
  for (int i = 0; i < gridSizeY; i++) {
    for (int j = 0; j < gridSizeX; j++) {
      float probability = random(100);
      if (probability < 15) {
        lifeArray[i][j] = 1;
      } else {
        lifeArray[i][j] = 0;
      }
    }
  }
  calcNeighbors();
}

// test to create a single glider in top-left corner of screen
void testGlider() {
  lifeArray[0][0] = 1;
  lifeArray[0][1] = 1;
  lifeArray[0][2] = 1;
  lifeArray[1][0] = 1;
  lifeArray[2][1] = 1;
  calcNeighbors();
}

// test to create a single Gosper glider gun
void testGliderGun() {
  lifeArray[1][25] = 1;
  lifeArray[2][23] = 1;
  lifeArray[2][25] = 1;
  lifeArray[3][13] = 1;
  lifeArray[3][14] = 1;
  lifeArray[3][21] = 1;
  lifeArray[3][22] = 1;
  lifeArray[3][35] = 1;
  lifeArray[3][36] = 1;
  lifeArray[4][12] = 1;
  lifeArray[4][16] = 1;
  lifeArray[4][21] = 1;
  lifeArray[4][22] = 1;
  lifeArray[4][35] = 1;
  lifeArray[4][36] = 1;
  lifeArray[5][1] = 1;
  lifeArray[5][2] = 1;
  lifeArray[5][11] = 1;
  lifeArray[5][17] = 1;
  lifeArray[5][21] = 1;
  lifeArray[5][22] = 1;
  lifeArray[6][1] = 1;
  lifeArray[6][2] = 1;
  lifeArray[6][11] = 1;
  lifeArray[6][15] = 1;
  lifeArray[6][17] = 1;
  lifeArray[6][18] = 1;
  lifeArray[6][23] = 1;
  lifeArray[6][25] = 1;
  lifeArray[7][11] = 1;
  lifeArray[7][17] = 1;
  lifeArray[7][25] = 1;
  lifeArray[8][12] = 1;
  lifeArray[8][16] = 1;
  lifeArray[9][13] = 1;
  lifeArray[9][14] = 1;
}
