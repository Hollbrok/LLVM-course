#include <SFML/Graphics.hpp>
#include <vector>

const int CELL_SIZE = 5;
const int GRID_WIDTH = 120;
const int GRID_HEIGHT = 120;

extern sf::RenderWindow* GetWindow();

extern sf::RectangleShape CreateCell(int size_x, int size_y);



enum CellColors {
    C_BLACK = 0,
    C_GREEN = 1,
    C_RED   = 2,
    C_WHITE = 3,
    C_YELLOW = 4,
};
// 0 -- white
// 1 -- black
extern void SetCellColor(sf::RectangleShape* cell, int color);

extern void SetCellPosition(sf::RectangleShape* cell, int x, int y);

extern void Display(sf::RenderWindow* window);

