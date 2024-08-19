#include <raylib.h>

namespace raylib {

typedef Color RaylibColor;

void RaylibInitWindow(int width, int height, const char *title);
bool RaylibWindowShouldClose();
void RaylibCloseWindow();
int RaylibGetScreenWidth();
int RaylibGetScreenHeight();

void RaylibBeginDrawing();
void RaylibClearBackground(RaylibColor color);
void RaylibDrawText(const char *text, int posX, int posY, int fontSize, Color color);
void RaylibDrawRect(int posX, int posY, int width, int height, Color color);
void RaylibEndDrawing();

bool RaylibIsKeyPressed(int key);
bool RaylibIsKeyUp(int key);
bool RaylibIsKeyDown(int key);

int RaylibGetFPS();
void RaylibSetTargetFPS(int fps);

} // namespace raylib
