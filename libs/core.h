#pragma once

#include <string>

#include "drawing/colors.h"
#include "math/corner.h"
#include "math/size.h"
#include "math/vector2d.h"
#include "periphery/keyboardkeys.h"

namespace castle {

class Core {
public:
    virtual ~Core() = default;

    // Window
    virtual void InitWindow(Size size, const char *title) = 0;
    virtual bool WindowShouldClose() = 0;
    virtual void CloseWindow() = 0;
    virtual Size GetWindowSize() = 0;

    // Drawing
    virtual void BeginDrawing() = 0;
    // TODO: Add color as the parameter
    virtual void ClearBackground(Color color) = 0;
    // TODO: Add color as the parameter
    virtual void DrawText(std::string text, Vector2D pos, int size, Color color) = 0;
    virtual void DrawRect(Vector2D pos, Size size, Color color) = 0;
    virtual void EndDrawing() = 0;

    // Events listening
    virtual bool IsKeyPressed(KeyboardKey key) = 0;
    virtual bool IsKeyUp(KeyboardKey key) = 0;
    virtual bool IsKeyDown(KeyboardKey key) = 0;

    // Utils
    virtual int GetFPS() = 0;
    virtual void SetTargetFPS(int fps) = 0;

    void DrawFPS(const Corner &corner = Corner::TOP_LEFT);
};

} // namespace castle
