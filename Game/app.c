
#include "lib.h"

void UpdateGrid(int (*grid)[GRID_X][GRID_Y]) {
    int newGrid[GRID_X][GRID_Y];

    for (int x = 0; x < GRID_X; ++x) {
        for (int y = 0; y < GRID_Y; ++y) {
            int aliveNeighbors = Lib_CountAliveNeighbors(*grid, x, y);
            newGrid[x][y] = (aliveNeighbors == 3 || (aliveNeighbors == 2 && (*grid)[x][y]));
        }
    }

    for (int x = 0; x < GRID_X; ++x) {
        for (int y = 0; y < GRID_Y; ++y) {
            (*grid)[x][y] = newGrid[x][y];
        }
    }
}

void app() {
    int grid[GRID_X][GRID_Y] = {};
    int cellNumber = Lib_Rand(1000, 2000);
    for (int i = 0; i < cellNumber; ++i) {
        int y = Lib_Rand(0, GRID_X - 1);
        int x = Lib_Rand(0, GRID_Y - 1);
        grid[x][y] = 1;
    }

    while (1) {
        UpdateGrid(&grid);

        for (int x = 0; x < GRID_X; ++x) {
            for (int y = 0; y < GRID_Y; ++y) {
                Lib_DrawCell(x, y, grid[x][y]);
            }
        }
        Lib_Display();
    }
}