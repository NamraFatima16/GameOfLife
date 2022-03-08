/*=========================================
 CA #1 for Programming fundamentals I
 
 An implementation of Conway's game of Life 
 
 Author: Namra Fatima
 Created: 31/10/2020
 ===========================================*/


/* GLOBALS */

// Constants 
int GRID_SPACING = 20;
int GRID_TOP=85, GRID_LEFT=85;
int GRID_HEIGHT=900, GRID_WIDTH=1400;
// Number of columns and rows in the grid
int ncols, nrows;
// Generation counter
int ngen = 0;
// 2D array to represent the state grid i.e which cells are alive and 
// which are dead
boolean [][] currGridState, newGridState;


void setup() {
  
  size(1920, 1080);
  background(0);
  strokeWeight(2);
  stroke(255);
  frameRate(10);
  
  // Drawing text elements and buttons to screen
  textSize(30);
  fill(255, 0, 0);
  text("GAME OF LIFE:    Generation #" +nf(ngen), 550, 50);
  fill(247, 238, 127);
  textSize(20);
  text("Press r or R to reset", 1590, 150);
  text("Press the buttons to start and stop", 1535, 610);
  fill(255, 0, 0);
  ellipse(1690, 390, 100, 100);
  fill(255);
  rect(1670, 370, 40, 40);
  fill(0, 255, 0);
  ellipse(1690, 500, 100, 100);
  fill(255);
  triangle(1670, 470, 1670, 530, 1720, 500);

  // Drawing the grid to screen
  drawGrid(GRID_SPACING, GRID_TOP, GRID_LEFT, GRID_WIDTH, GRID_HEIGHT);
  // Create and initialize the grid state arrays
  currGridState = new boolean[ncols][nrows];
  newGridState  = new boolean[ncols][nrows];
  for(int i = 0; i < ncols; i++) {
    for(int j = 0; j < nrows; j++) {
      currGridState[i][j] = false;
    }
  }

  // Initial "seed" for the grid:

  // "Blinker" pattern
  currGridState[2][1]   = true;
  currGridState[2][2]   = true;
  currGridState[2][3]   = true;

  // "Toad" pattern
  currGridState[15][1]  = true;
  currGridState[16][2]  = true;
  currGridState[16][3]  = true;
  currGridState[13][2]  = true;
  currGridState[13][3]  = true;
  currGridState[14][4]  = true;

  // A "pulsar"
  currGridState[3][6]   = true;
  currGridState[4][6]   = true;
  currGridState[5][6]   = true;
  currGridState[9][6]   = true;
  currGridState[10][6]  = true;
  currGridState[11][6]  = true;
  currGridState[1][8]   = true;
  currGridState[1][9]   = true;
  currGridState[1][10]  = true;
  currGridState[6][8]   = true;
  currGridState[6][9]   = true;
  currGridState[6][10]  = true;
  currGridState[8][8]   = true;
  currGridState[8][9]   = true;
  currGridState[8][10]  = true;
  currGridState[13][8]  = true;
  currGridState[13][9]  = true;
  currGridState[13][10] = true;
  currGridState[3][11]  = true;
  currGridState[4][11]  = true;
  currGridState[5][11]  = true;
  currGridState[9][11]  = true;
  currGridState[10][11] = true;
  currGridState[11][11] = true;
  currGridState[3][13]  = true;
  currGridState[4][13]  = true;
  currGridState[5][13]  = true;
  currGridState[9][13]  = true;
  currGridState[10][13] = true;
  currGridState[11][13] = true;
  currGridState[1][14]  = true;
  currGridState[1][15]  = true;
  currGridState[1][16]  = true;
  currGridState[6][14]  = true;
  currGridState[6][15]  = true;
  currGridState[6][16]  = true;
  currGridState[8][14]  = true;
  currGridState[8][15]  = true;
  currGridState[8][16]  = true;
  currGridState[13][14] = true;
  currGridState[13][15] = true;
  currGridState[13][16] = true;
  currGridState[3][18]  = true;
  currGridState[4][18]  = true;
  currGridState[5][18]  = true;
  currGridState[9][18]  = true;
  currGridState[10][18] = true;
  currGridState[11][18] = true;

  // A "Penta-decathlon" pattern
  currGridState[4][24]  = true;
  currGridState[5][24]  = true;
  currGridState[6][24]  = true;
  currGridState[3][25]  = true;
  currGridState[3][26]  = true;
  currGridState[7][25]  = true;
  currGridState[7][26]  = true;
  currGridState[4][27]  = true;
  currGridState[5][27]  = true;
  currGridState[6][27]  = true;
  currGridState[4][32]  = true;
  currGridState[5][32]  = true;
  currGridState[6][32]  = true;
  currGridState[3][33]  = true;
  currGridState[3][34]  = true;
  currGridState[7][33]  = true;
  currGridState[7][34]  = true;
  currGridState[4][35]  = true;
  currGridState[5][35]  = true;
  currGridState[6][35]  = true;

  // A "glider"
  currGridState[21][14] = true;
  currGridState[22][15] = true;
  currGridState[23][13] = true;
  currGridState[23][14] = true;
  currGridState[23][15] = true;

  // Drawing the initial state
  drawCells();
}


void draw() {

  background(0);
  strokeWeight(2);
  stroke(255);

  // Drawing the text elements and buttons to screen
  fill(255, 0, 0);
  ellipse(1690, 390, 100, 100);
  fill(255);
  rect(1670, 370, 40, 40);
  fill(0, 255, 0);
  ellipse(1690, 500, 100, 100);
  fill(255);
  triangle(1670, 470, 1670, 530, 1720, 500);
  textSize(30);
  fill(255, 0, 0);
  text("GAME OF LIFE:    Generation #" +nf(ngen), 550, 50);
  fill(247, 238, 127);
  textSize(20);
  text("Press r or R to reset", 1590, 150);
  text("Press the buttons to start and stop", 1535, 610);

  // Incrementing the generation counter
  ngen++;

  // Updating the state and drawing the grid and cells
  update();
  drawGrid(GRID_SPACING, GRID_TOP, GRID_LEFT, GRID_WIDTH, GRID_HEIGHT);
  drawCells();

}


// Executes when a key is pressed
void keyPressed() {
  //if r or R is pressed it resets the whole game
  if (key == 'r'|| key =='R') {
    // Reset generation counter
    ngen = 0;
    setup();
  }
}

// Executes when mouse button is pressed
void mousePressed() {
  // Check if mouse position is within the circle
  // Equation of circle is (x-h)^2 + (y-k)^2 == r^2 
  if (mouseButton == LEFT && sq(mouseX - 1690) + sq(mouseY - 390) <= sq(50)) {
    // Stop the draw loop (stop button)
    noLoop();
  }
  if (mouseButton == LEFT && sq(mouseX - 1690) + sq(mouseY - 500) <= sq(50)) {
    // Start the draw loop (start button)
    loop();
  }
}

/* 
 This method draws a equally spaced grid of squares
 
 @param spacing The size of the squares in the grid
 @param x The x-coordinate starting point of the grid
 @param y The y-coordinate starting point of the grid
 @param w The width of the grid
 @param h The height of the grid
 */
void drawGrid(int spacing, int x, int y, int w, int h) {

  // sets number of rows and columns that will fit into the grid with the given
  // grid spacings
  ncols = w/spacing;
  nrows = h/spacing;

  // The end point x & y coordinate for grid is not just be x+w or y+h 
  // as this might lead to unevenly spaced squares if spacing doesn't
  // divide cleanly into w or h 
  int endX = x + ncols*spacing;
  int endY = y + nrows*spacing;

  // Draw row lines
  for (int i = 0; i <= nrows; i++) {
    //each iteration of the loop draw a horizontal line that is "spacing" away from the previous line
    line(x, y + (i*spacing), endX, y + (i*spacing));
  }
  // Draw column lines
  for (int i = 0; i <= ncols; i++) {
    //each iteration of the loop draw a vertical line that is "spacing" away from previous line
    line(x + (i*spacing), y, x + (i*spacing), endY);
  }
}



/*
  This method draws dead and alive cells on the grid
 Alive cells are drawn in green
 Dead cells are drawn in grey
 */
void drawCells() {
  // moving the rect top left coordinate by this amount so it fits into the grid properly 
  int offset = 3;
  // radius of rect corners
  float radius = 1.5;

  // Iterate through the 2D array checking every cell in the grid
  for (int i = 0; i < ncols; i++) {
    for (int j = 0; j < nrows; j++) {
      if (currGridState[i][j]) {
        // Cell is alive - draw a green rectangle
        fill(4, 232, 36);   
        rect(GRID_LEFT+offset + i*GRID_SPACING, GRID_TOP+offset + j*GRID_SPACING, GRID_SPACING-offset, GRID_SPACING-offset, radius);
      }
      else {
        // Cell is dead - draw a grey color rectangle
        fill(112, 112, 112);
        rect(GRID_LEFT+offset + i*GRID_SPACING, GRID_TOP+offset + j*GRID_SPACING, GRID_SPACING-offset, GRID_SPACING-offset, radius);
      }
    }
  }
}



/*
  This method checks the number of living neighbours to the given cell
 
 @param i The column of the cell 
 @param j The row of the cell
 @return This returns the number of alive neighbours excluding itself
 
 
 The follow box illustrates the 8 neighbours of cell (i,j)
 
 |===============================================|
 +               +               +               +
 +               +               +               +
 +   (i-1,j-1)   +   (i  ,j-1)   +   (i+1,j-1)   +
 +               +               +               +
 +               +               +               +
 |_______________|_______________|_______________|
 |               |               |               |
 +               +               +               +
 +               +   ▼▼▼▼▼▼▼▼▼   +               +
 +   (i-1,j  )   +   (i  ,j  )   +   (i+1,j  )   +
 +               +   ▲▲▲▲▲▲▲▲▲   +               +
 +               +               +               +
 |_______________|_______________|_______________|
 |               |               |               |
 +               +               +               +
 +               +               +               +
 +   (i-1,j+1)   +   (i  ,j+1)   +   (i+1,j+1)   +
 +               +               +               +
 +               +               +               +
 |===============================================|
 
 The neighbourhood of (i,j) consists of cells from -1 to 1 away from i and j
 */
int numNeigh(int i, int j) {

  // counter to count the number of alive cells
  int count = 0;


  for (int k = -1; k <= 1; k++) {
    for (int l = -1; l <= 1; l++) {
      // When i and j are either 0 or ncol/nrows - 1 
      // currGridState[i+k][j+l] will go out of bounds
      // as they can become -1 or nrows/ncols
      // The expression (i + k + ncols)%ncols will ensure that we remain in bounds
      // by wrapping the values around. (similarly for j)
      // This is from https://www.youtube.com/watch?v=FWSR_7kZuYg 
      // The coding train's video on The game of Life implemented in javascript
      if (currGridState[(i + k + ncols)%ncols][(j + l + nrows)%nrows]) {
        count++;
      }
    }
  }

  // a cell cant be neighbour to itself so removing the contribution of that cell
  // The cell will only contribute if its alive 
  if (currGridState[i][j]) {
    return count -1;
  } 
  else {
    return count;
  }
}

/*
  This method determines the next generation / next turn of the game of life
 
 It updates the state of the grid, i.e which cells are alive or dead based on 
 the certain rules. This process of updating the grid continues every draw loop
 
 newGridState contains the state of the grid for the next turn.
 This is required as we cant not change the current grid state while simultaneously 
 checking for neighbours that are alive in the current state
 
 */
void update() {

  // Iterate through the 2D array checking every cell in the grid
  for (int i = 0; i < ncols; i++) {
    for (int j = 0; j < nrows; j++) {
      // RULES OF THE GAME
      // The cell dies if there are less than 2 neigbours are alive("LONELINESS")
      if (numNeigh(i, j) < 2 ) {
        newGridState[i][j] = false;
      }
      // The cell dies if there are more then 3 neighbours are alive("ITS DIDNT FOLLOW THE SOCIAL DISTANCING"( DEAD OF COVID))
      else if (numNeigh(i, j) > 3) {
        newGridState[i][j] = false;
      }
      //The cell is "REBORN" ("IT'S ALIVE!!!!") if the number of neighbours are exactly equal to 3 and the cell is currently dead 
      else if (numNeigh(i, j) == 3 && currGridState[i][j] == false) {
        newGridState[i][j] = true;
      }
      // The cell remains alive if there are 2 or 3 neighbours which are alive ("IT LIVES!!")
      else if ( (numNeigh(i, j) == 2 || numNeigh(i, j) == 3) && currGridState[i][j] == true) {
        newGridState[i][j] = true;
      }
      // If none of the other conditions are true the we set the cell to be dead ("BOOO!!" 😭 )
      else {
        newGridState[i][j] = false;
      }
    }
  }

  // copy the new grid state into current grid state 
  for (int i = 0; i < ncols; i++) {
    for (int j = 0; j < nrows; j++) {
      currGridState[i][j] = newGridState[i][j];
    }
  }
}
