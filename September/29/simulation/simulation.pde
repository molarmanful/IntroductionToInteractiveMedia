Env ENV;
boolean paused = false;

void setup(){
  size(500, 500);

  // initialize grid
  ENV = new Env();
  ENV.randInit();
  ENV.display();
}

// update generations in real-time
void draw(){
  if(!paused){
    ENV.next();
    ENV.display();
  }
}

void keyPressed(){
  if(key == ' ') paused = !paused; // pause

  // step one generation while paused
  if(key == 'f' && paused){
    ENV.next();
    ENV.display();
  }
}

// proper modulus for wrapping grid
// gives correct values for negative ints
int mod(int x, int y){
  return (x % y + y) % y;
}

// class that handles grid + cell creation/updates
class Env {
  public Cell[][] grid;

  Env(){
    grid = new Cell[width][height];
  }

  // randomly populate the grid with dead/live cells
  // used at program start as generation 0
  void randInit(){
    for(int x = 0; x < grid.length; x++){
      for(int y = 0; y < grid[x].length; y++){
        grid[x][y] = new Cell(this, x, y, int(random(2)));
      }
    }
  }

  // get corresponding cell at x/y coords
  Cell cell(int x, int y){
    return grid[mod(x, width)][mod(y, height)];
  }

  // advance grid to next generation
  void next(){
    // deep clone grid
    // necessary to ensure that cells read neighbors from current grid as opposed to a partially-updated grid
    Cell[][] newgrid = grid.clone();
    for(int i = 0; i < newgrid.length; i++){
      newgrid[i] = newgrid[i].clone();
    }

    // advance all cells to next generation
    for(Cell[] cells : newgrid){
      for(Cell cell : cells){
        cell.next();
      }
    }

    // overwrite grid with updated cells
    grid = newgrid;
  }

  // draw grid
  void display(){
    background(0);

    // draw each cell
    // using pixels[] is faster than using set()
    loadPixels();
    for(int x = 0; x < grid.length; x++){
      for(int y = 0; y < grid[x].length; y++){
        pixels[y * width + x] = color(grid[x][y].life * 255);
      }
    }
    updatePixels();
  }
}


// class that handles cell behavior
class Cell {
  Env env;
  int x, y;
  public int life;

  Cell(Env ENV, int X, int Y, int l){
    env = ENV;
    x = X;
    y = Y;
    life = l;
  }

  // get neighboring cells
  // accounts for grid wrapping
  Cell[] neighbors(){
    return new Cell[]{
      env.cell(x - 1, y - 1), env.cell(x - 1, y), env.cell(x - 1, y + 1),
      env.cell(x    , y - 1),                     env.cell(x    , y + 1),
      env.cell(x + 1, y - 1), env.cell(x + 1, y), env.cell(x + 1, y + 1)
    };
  }

  // advance cell to next generation
  void next(){
    // get number of living neighbors via sum
    int lives = 0;
    for(Cell neighbor : neighbors()){
      lives += neighbor.life;
    }

    // beautiful one-liner implements GoL rule
    // live cells with 2 or 3 neighbors --> live
    // dead cells with 3 neighbors --> live
    // all other cells --> dead
    life = (life == 1 && lives > 1 && lives < 4) || (life == 0 && lives == 3) ? 1 : 0;
  }
}
