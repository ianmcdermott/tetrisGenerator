class Undergrid {
  int[][][] grid;
  int cellWidth;

  Undergrid(int cw) {
    cellWidth = cw;
    grid = new int[1][ceil(width/cellWidth)][ceil(height/cellWidth)];
    println("Made new grid with the following dimensions:");
    println(grid.length+" "+ceil(width/cellWidth)+" "+ceil(height/cellWidth));
    for (int i = 0; i < grid.length; i++) {
      for (int j = 0; j < grid[i].length; j++) {
        for (int k = 0; k < grid[i][j].length; k++) {
          grid[i][j][k] = 0;
        }
      }
    }
    //grid[0][0][floor(height/cellWidth)-1] = 1;
  }
  void display() {
    noStroke();
    for (int i = 0; i < grid.length; i++) {
      for (int j = 0; j < grid[i].length; j++) {
        for (int k = 0; k  < grid[i][j].length; k++) {
          if (grid[i][j][k] == 0) {
            //println("///////");
            //println(grid[i][j][k]);
            //println("_______");
            fill(0);
            stroke(20);
          } else {
            fill(grid[i][j][k]);
            stroke(0);
          }
          pushMatrix();
          translate(k*cellWidth, j*cellWidth);
          textAlign(CENTER);
          rect(0, 0, cellWidth, cellWidth);
          fill(0);
          popMatrix();

          //text((grid[i].length-j-1)-(grid[i][j].length-k), k, j);
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
  void update(int i, int j, int val) {
    println("UPDATING Grid: ["+i+"]["+j+"]");
    grid[0][i][j] = val;
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
