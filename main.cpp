#include "lib/lib.hpp"

std::vector<std::vector<int>> grid(GRID_WIDTH, std::vector<int>(GRID_HEIGHT, 0));
auto* window = GetWindow();

inline int randomgen(int min, int max);
void InitializeGliderPattern();
int CountAliveNeighbors(int x, int y);
void AddRandom();
void AddArrow(int startX, int startY);
void AddGliderPatter(int startX, int startY);

// Prepare functions
inline int randomgen(int min, int max)
{
    return rand() % (max - min + 1) + min;
}

void InitializeGliderPattern() {
    AddRandom();
    AddGliderPatter(10, 10);
    AddGliderPatter(30, 30);
    AddGliderPatter(60, 20);
    AddArrow(50, 10);
}

void AddRandom() {
    int cellNumber = randomgen(100, 300);
    for (int i = 0; i < cellNumber; ++i) {
        int y = randomgen(0, GRID_WIDTH - 1);
        int x = randomgen(0, GRID_HEIGHT - 1);
        grid[x][y] = true;
    }
}

void AddArrow(int startX, int startY) {
    bool ArrowPattern[3][3] = {
        {0, 1, 0},
        {0, 1, 0},
        {0, 1, 0}
    };

    for (int x = 0; x < 3; ++x) {
        for (int y = 0; y < 3; ++y) {
            grid[startX + x][startY + y] = ArrowPattern[x][y];
        }
    }
}

void AddGliderPatter(int startX, int startY) {
    bool gliderPattern[3][3] = {
        {0, 1, 0},
        {0, 0, 1},
        {1, 1, 1}
    };

    for (int x = 0; x < 3; ++x) {
        for (int y = 0; y < 3; ++y) {
            grid[startX + x][startY + y] = gliderPattern[x][y];
        }
    }
}

// Calculation and draw logic
int CountAliveNeighbors(int x, int y) {
    int aliveNeighbors = 0;

    int offsetsX[] = { -1, 0, 1, -1, 1, -1, 0, 1 };
    int offsetsY[] = { -1, -1, -1, 0, 0, 1, 1, 1 };

    for (int i = 0; i < 8; ++i) {
        int neighborX = x + offsetsX[i];
        int neighborY = y + offsetsY[i];

        if (neighborX >= 0 && neighborX < GRID_WIDTH && neighborY >= 0 && neighborY < GRID_HEIGHT) {
            if (grid[neighborX][neighborY] != 0) {
                aliveNeighbors++;
            }
        }
    }

    return aliveNeighbors;
}

void UpdateGrid() {
    std::vector<std::vector<int>> newGrid = grid;

    for (int x = 0; x < GRID_WIDTH; ++x) {
        for (int y = 0; y < GRID_HEIGHT; ++y) {
            int aliveNeighbors = CountAliveNeighbors(x, y);

            if (grid[x][y] != C_BLACK) {
                if (aliveNeighbors == 2)
                    newGrid[x][y] = C_YELLOW;
                else if (aliveNeighbors == 3)
                    newGrid[x][y] = C_RED;
                else if (aliveNeighbors < 2 || aliveNeighbors > 3) {
                    newGrid[x][y] = C_BLACK;
                }
            } else {
                if (aliveNeighbors == 3) {
                    newGrid[x][y] = C_GREEN;
                }
            }
        }
    }

    grid = newGrid;
}

void DrawGrid() {
    auto cell = CreateCell(CELL_SIZE, CELL_SIZE);

    for (int x = 0; x < GRID_WIDTH; ++x) {
        for (int y = 0; y < GRID_HEIGHT; ++y) {
            SetCellColor(&cell, grid[x][y]);
            SetCellPosition(&cell, x * CELL_SIZE, y * CELL_SIZE);
            window->draw(cell);
        }
    }
}
//

int main() {
    InitializeGliderPattern();
    while (true) {
        UpdateGrid();

        DrawGrid();
        Display(window);
    }

    return 0;
}