#include "lib/lib.h"

//int grid[GRID_X][GRID_Y];

void InitGrid(int grid[][GRID_X]) {
    int cellNumber = Lib_Rand(1000, 2000);
    for (int i = 0; i < cellNumber; ++i) {
        int y = Lib_Rand(0, GRID_X - 1);
        int x = Lib_Rand(0, GRID_Y - 1);
        grid[x][y] = 1;
    }
}

int CountAliveNeighbors(int grid[][GRID_X], int x, int y) {
    int aliveNeighbors = 0;

    int offsetsX[] = { -1, 0, 1, -1, 1, -1, 0, 1 };
    int offsetsY[] = { -1, -1, -1, 0, 0, 1, 1, 1 };

    for (int i = 0; i < 8; ++i) {
        int neighborX = x + offsetsX[i];
        int neighborY = y + offsetsY[i];

        if (neighborX >= 0 && neighborX < GRID_X && neighborY >= 0 && neighborY < GRID_Y) {
            if (grid[neighborX][neighborY] == 1) {
                aliveNeighbors++;
            }
        }
    }

    return aliveNeighbors;
}

void UpdateGrid(int (*grid)[GRID_X][GRID_X]) {
    int newGrid[GRID_X][GRID_X];
    for (int x = 0; x < GRID_X; ++x) {
        for (int y = 0; y < GRID_Y; ++y) {
            newGrid[x][y] = (*grid)[x][y];
        }
    }

    for (int x = 0; x < GRID_X; ++x) {
        for (int y = 0; y < GRID_Y; ++y) {
            int aliveNeighbors = CountAliveNeighbors((*grid), x, y);

            if ((*grid)[x][y] == 1) {
                if (aliveNeighbors < 2 || aliveNeighbors > 3) {
                    newGrid[x][y] = 0;
                }
            } else {
                if (aliveNeighbors == 3) {
                    newGrid[x][y] = 1;
                }
            }
        }
    }

    for (int x = 0; x < GRID_X; ++x) {
        for (int y = 0; y < GRID_Y; ++y) {
            (*grid)[x][y] = newGrid[x][y];
        }
    }
}

void DrawGrid(int grid[][GRID_X]) {
    for (int x = 0; x < GRID_X; ++x) {
        for (int y = 0; y < GRID_Y; ++y) {
            Lib_DrawCell(x, y, grid[x][y]);
        }
    }
}

void app() {
    int grid[GRID_X][GRID_Y] = {};
    InitGrid(grid);

    while (true) {
        UpdateGrid(&grid);
        DrawGrid(grid);
        Lib_Display();
    }
}