
#define CELL_SIZE 5
#define GRID_X 120
#define GRID_Y 120

int Lib_Rand(int min, int max);
void Lib_DrawCell(int x, int y, int color);
void Lib_Display();
int Lib_CountAliveNeighbors(int grid[GRID_Y][GRID_X], int x, int y);
