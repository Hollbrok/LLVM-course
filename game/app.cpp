#include "lib/lib.hpp"

int grid[GRID_WIDTH][GRID_HEIGHT];

void InitGrid() {
    int cellNumber = Lib_Rand(1000, 2000);
    for (int i = 0; i < cellNumber; ++i) {
        int y = Lib_Rand(0, GRID_WIDTH - 1);
        int x = Lib_Rand(0, GRID_HEIGHT - 1);
        grid[x][y] = 1;
    }
}

int CountAliveNeighbors(int x, int y) {
    int aliveNeighbors = 0;

    int offsetsX[] = { -1, 0, 1, -1, 1, -1, 0, 1 };
    int offsetsY[] = { -1, -1, -1, 0, 0, 1, 1, 1 };

    for (int i = 0; i < 8; ++i) {
        int neighborX = x + offsetsX[i];
        int neighborY = y + offsetsY[i];

        if (neighborX >= 0 && neighborX < GRID_WIDTH && neighborY >= 0 && neighborY < GRID_HEIGHT) {
            if (grid[neighborX][neighborY] == 1) {
                aliveNeighbors++;
            }
        }
    }

    return aliveNeighbors;
}

void UpdateGrid() {
    int newGrid[GRID_WIDTH][GRID_HEIGHT];
    for (int x = 0; x < GRID_WIDTH; ++x) {
        for (int y = 0; y < GRID_HEIGHT; ++y) {
            newGrid[x][y] = grid[x][y];
        }
    }

    for (int x = 0; x < GRID_WIDTH; ++x) {
        for (int y = 0; y < GRID_HEIGHT; ++y) {
            int aliveNeighbors = CountAliveNeighbors(x, y);

            if (grid[x][y] == 1) {
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

    for (int x = 0; x < GRID_WIDTH; ++x) {
        for (int y = 0; y < GRID_HEIGHT; ++y) {
            grid[x][y] = newGrid[x][y];
        }
    }
}

void DrawGrid() {
    for (int x = 0; x < GRID_WIDTH; ++x) {
        for (int y = 0; y < GRID_HEIGHT; ++y) {
            Lib_DrawCell(x, y, grid[x][y]);
        }
    }
}

void DumpGrid() {
    for (int x = 0; x < GRID_WIDTH; ++x) {
        for (int y = 0; y < GRID_HEIGHT; ++y) {
            printf("%d ", grid[x][y]);
        }
        printf("\n");
    }
}


void app() {

    InitGrid();

    while (true) {
        UpdateGrid();
        //DumpGrid();
        DrawGrid();
        Lib_Display();
    }
}