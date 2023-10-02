#include "lib.hpp"


sf::RenderWindow my_window(sf::VideoMode(GRID_WIDTH * CELL_SIZE, GRID_HEIGHT * CELL_SIZE), "Cellular Automaton Game");

extern sf::RenderWindow* GetWindow() {
    printf("XXXXX\n");
    return &my_window;
}

extern sf::RectangleShape CreateCell(int size_x, int size_y) {
    return sf::RectangleShape(sf::Vector2f(CELL_SIZE, CELL_SIZE));
}

// 0 -- white
// 1 -- black
extern void SetCellColor(sf::RectangleShape* cell, bool color) {
    cell->setFillColor(color? sf::Color::Black : sf::Color::White);
}

extern void SetCellPosition(sf::RectangleShape* cell, int x, int y) {
    cell->setPosition(x, y);
}

extern void Display(sf::RenderWindow* window) {
    window->display();
}

