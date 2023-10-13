#include "lib.hpp"

sf::RenderWindow Window;
sf::RectangleShape Cell;

void GameInit();

extern void app();

int main() {
    GameInit();
    app();
    return EXIT_SUCCESS;
}

void GameInit() {
    Window.create(sf::VideoMode(GRID_WIDTH * CELL_SIZE, GRID_HEIGHT * CELL_SIZE), "Cellular Automaton Game");
    Cell.setSize(sf::Vector2f(CELL_SIZE, CELL_SIZE));
}

inline int randomgen(int min, int max)
{
    return rand() % (max - min + 1) + min;
}

void Lib_DrawCell(int x, int y, bool color) {
    Cell.setFillColor(color ? sf::Color::Black : sf::Color::White);
    Cell.setPosition(x * CELL_SIZE, y * CELL_SIZE);
    Window.draw(Cell);
}

void Lib_Display() {
    Window.display();
}

int Lib_Rand(int min, int max) {
    return randomgen(min, max);
}

