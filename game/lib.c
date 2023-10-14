#include <stdlib.h>
#include <assert.h>
#include <SDL2/SDL.h>
#include <time.h>
#include "lib.h"

#define FRAME_TICKS 50

static SDL_Renderer *Renderer = NULL;
static SDL_Window *Window = NULL;
static SDL_Rect Cell;

static Uint32 Ticks = 0;

void GameInit();

extern void app();

int main() {
    GameInit();
    printf("XXXX\n");
    app();    
    return EXIT_SUCCESS;
}

void GameInit() {
    SDL_Init(SDL_INIT_VIDEO);
    SDL_CreateWindowAndRenderer(GRID_X * CELL_SIZE, GRID_Y * CELL_SIZE, 0, &Window, &Renderer);
    SDL_SetRenderDrawColor(Renderer, 0, 0, 0, 0);
    SDL_RenderClear(Renderer);

    Cell.w = CELL_SIZE;
    Cell.h = CELL_SIZE;
    srand(time(NULL));
}

int randomgen(int min, int max)
{
    return rand() % (max - min + 1) + min;
}

void Lib_DrawCell(int x, int y, int color) {
    Cell.x = x * CELL_SIZE;
    Cell.y = y * CELL_SIZE;
    if (color) {// black
        SDL_SetRenderDrawColor(Renderer, 255, 255, 255, 255);
    } else {
        SDL_SetRenderDrawColor(Renderer, 0, 0, 0, 0);
    }
    
    // Render rect
    SDL_RenderFillRect(Renderer, &Cell);
}

void Lib_Display() {
    SDL_PumpEvents();
    assert(SDL_TRUE != SDL_HasEvent(SDL_QUIT) && "User-requested quit");
    Uint32 cur_ticks = SDL_GetTicks() - Ticks;
    if (cur_ticks < FRAME_TICKS)
    {
        SDL_Delay(FRAME_TICKS - cur_ticks);
    }
    SDL_RenderPresent(Renderer);
}

int Lib_Rand(int min, int max) {
    return randomgen(min, max);
}

