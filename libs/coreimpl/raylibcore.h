#pragma once

#include "core.h"
#include "coreimpl/raylibbindings.h"

namespace castle {

class RaylibCore : public Core {
public:
    virtual ~RaylibCore() = default;

    // Window
    virtual void InitWindow(Size size, const char *title);
    virtual bool WindowShouldClose();
    virtual void CloseWindow();
    virtual Size GetWindowSize();

    // Drawing
    virtual void BeginDrawing();
    // TODO: Add color as the parameter
    virtual void ClearBackground(Color color);
    // TODO: Add color as the parameter
    virtual void DrawText(std::string text, Vector2D pos, int size, Color color);
    virtual void DrawRect(Vector2D pos, Size size, Color color);
    virtual void EndDrawing();

    // Events listening
    virtual bool IsKeyPressed(KeyboardKey key);
    virtual bool IsKeyUp(KeyboardKey key);
    virtual bool IsKeyDown(KeyboardKey key);

    // Utils
    virtual int GetFPS();
    virtual void SetTargetFPS(int fps);
};

} // namespace castle
