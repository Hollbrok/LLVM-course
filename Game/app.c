
#include "lib.h"

static void UpdateGrid(int (*cur)[GRID_X][GRID_Y], int (*next)[GRID_X][GRID_Y]) {
    for (int x = 0; x < GRID_X; ++x) {
        for (int y = 0; y < GRID_Y; ++y) {
            int aliveNeighbors = Lib_CountAliveNeighbors(cur, x, y);
            if ((*cur)[x][y] == 1) {
                (*next)[x][y] = !(aliveNeighbors < 2 || aliveNeighbors > 3);
            } else {
                (*next)[x][y] = (aliveNeighbors == 3);
            }
        }
    }
}

static void DrawGrid(int (*cur_grid)[GRID_X][GRID_Y]) {
    for (int x = 0; x < GRID_X; ++x) {
        for (int y = 0; y < GRID_Y; ++y) {
            Lib_DrawCell(x, y, (*cur_grid)[x][y]);
        }
    }
}

static void InitGrid(int (*grid)[GRID_X][GRID_Y], int (*grid_buffer)[GRID_X][GRID_Y]) {
    int cellNumber = Lib_Rand(1000, 5000);
    for (int i = 0; i < cellNumber; ++i) {
        long y = Lib_Rand(0, GRID_X - 1);
        long x = Lib_Rand(0, GRID_Y - 1);
        (*grid)[x][y] = 1;
        (*grid_buffer)[x][y] = 0;
    }
}

static void SwapPointers(int **ptr1, int **ptr2) {
    int *temp = *ptr1;  
    *ptr1 = *ptr2;      
    *ptr2 = temp; 
}

void app() {
    int grid1[GRID_X][GRID_Y];
    int grid2[GRID_X][GRID_Y];
    int *cur = grid1;
    int *next = grid2;
    InitGrid(cur, next);

    while (1) {
        UpdateGrid(cur, next);
        DrawGrid(next);
        Lib_Display();
        SwapPointers(&cur, &next);
        
    }
}