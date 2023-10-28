
#include "lib.h"

static int grid[GRID_X][GRID_Y];
static int grid_buffer[GRID_X][GRID_Y];

static void SwapGrid() {
    for (int x = 0; x < GRID_X; ++x) {
        for (int y = 0; y < GRID_Y; ++y) {
            grid[x][y] = grid_buffer[x][y];
        }
    }
}

static void UpdateGrid() {
    for (int x = 0; x < GRID_X; ++x) {
        for (int y = 0; y < GRID_Y; ++y) {
            int aliveNeighbors = Lib_CountAliveNeighbors(grid, x, y);
            if (grid[x][y] == 1) {
                if (aliveNeighbors < 2 || aliveNeighbors > 3) {
                    grid_buffer[x][y] = 0;
                }
            } else {
                if (aliveNeighbors == 3) {
                    grid_buffer[x][y] = 1;
                }
            }
        }
    }
}

static void DrawGrid() {
    for (int x = 0; x < GRID_X; ++x) {
        for (int y = 0; y < GRID_Y; ++y) {
            Lib_DrawCell(x, y, grid[x][y]);
        }
    }
}

static void InitGrid() {
    int cellNumber = Lib_Rand(1000, 5000);
    for (int i = 0; i < cellNumber; ++i) {
        long y = Lib_Rand(0, GRID_X - 1);
        long x = Lib_Rand(0, GRID_Y - 1);
        grid[x][y] = 1;
        grid_buffer[x][y] = 0;
    }
}

void app() {
    InitGrid();

    while (1) {
        UpdateGrid();
        SwapGrid();
        DrawGrid();
        Lib_Display();
    }
}