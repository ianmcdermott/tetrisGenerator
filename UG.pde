class Undergrid {
  int[][][] grid;
  color[][][] displayGrid;
  int cellWidth;

  Undergrid(int cw) {
    cellWidth = cw;
    grid = new int[1][ceil(height/cellWidth)][ceil(width/cellWidth)];
    displayGrid = new int[1][ceil(height/cellWidth)][ceil(width/cellWidth)];

    println("Made new grid with the following dimensions:");
    println(grid.length+" "+ceil(width/cellWidth)+" "+ceil(height/cellWidth));
    for (int i = 0; i < grid.length; i++) {
      for (int j = 0; j < grid[i].length; j++) {
        for (int k = 0; k < grid[i][j].length; k++) {
          grid[i][j][k] = 0;
          displayGrid[i][j][k] = color(0, 0, 0);
        }
      }
    }
  }
  void display() {
    noStroke();
    for (int i = 0; i < grid.length; i++) {
      for (int j = 0; j < grid[i].length; j++) {
        for (int k = 0; k  < grid[i][j].length; k++) {
          if (grid[i][j][k] == 0) {
            fill(0);
            stroke(20);
          } else {
            fill(displayGrid[i][j][k]);
            stroke(0);
          }
          pushMatrix();
          translate(k*cellWidth, j*cellWidth);
          textAlign(CENTER);
          rect(0, 0, cellWidth, cellWidth);
          fill(0);
          popMatrix();
        }
      }
    }
  }
  void clear() {
    for (int i = 0; i < grid.length; i++) {
      for (int j = 0; j < grid[i].length; j++) {
        for (int k = grid[i][j].length-1; k >= 0; k--) {
          grid[i][j][k] = 0;
        }
      }
    }
  }
  void update(int i, int j, color val) {
    grid[0][i][j] = 255;
    displayGrid[0][i][j] = val;
  }

  int checkGrid(int i, int j, int val) {
    int total = 0;
    println("grid:" + i+": "+j+":v: "+val);

    if (val + grid[0][i][j] > 1) {
      stroke(0, 255, 0);
      noFill();
      rect(j*blockWidth, i*blockWidth, blockWidth, blockWidth);
      total++;
    }
    return total;
  }

  int checkOverlap(int i, int j, int val) {
    int total = 0;
    if ( grid[0][i][j] > 0) {
      total++;
    }
    if (val + grid[0][i][j] > 0) {
      total++;
    }
    return total;
  }
}
