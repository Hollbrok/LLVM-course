#include "lib.hpp"


sf::RenderWindow my_window(sf::VideoMode(GRID_WIDTH * CELL_SIZE, GRID_HEIGHT * CELL_SIZE), "Cellular Automaton Game");

extern sf::RenderWindow* GetWindow() {
    printf("XXXXX\n");
    return &my_window;
}

extern sf::RectangleShape CreateCell(int size_x, int size_y) {
    return sf::RectangleShape(sf::Vector2f(CELL_SIZE, CELL_SIZE));
}

extern void SetCellColor(sf::RectangleShape* cell, int color) {
    sf::Color set_color = sf::Color::Magenta;
    switch (CellColors(color))
    {
    case C_WHITE:
        set_color = sf::Color::White;
        break;
    case C_BLACK:
        set_color = sf::Color::Black;
        break;
    case C_RED:
        set_color = sf::Color::Red;
        break;
    case C_GREEN:
        set_color = sf::Color::Green;
        break;
    case C_YELLOW:
        set_color = sf::Color::Yellow;
        break;
    default:
        break;
    }
    cell->setFillColor(set_color);
}

extern void SetCellPosition(sf::RectangleShape* cell, int x, int y) {
    cell->setPosition(x, y);
}

extern void Display(sf::RenderWindow* window) {
    window->display();
}

