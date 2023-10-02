#include <SFML/Graphics.hpp>
#include <vector>

const int CELL_SIZE = 5;
const int GRID_WIDTH = 120;
const int GRID_HEIGHT = 120;

extern sf::RenderWindow* GetWindow();

extern sf::RectangleShape CreateCell(int size_x, int size_y);

// 0 -- white
// 1 -- black
extern void SetCellColor(sf::RectangleShape* cell, bool color);

extern void SetCellPosition(sf::RectangleShape* cell, int x, int y);

extern void Display(sf::RenderWindow* window);

