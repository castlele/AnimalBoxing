#include <libcastle.h>
#include <memory>

#include "scenes/playground.h"

using namespace castle;

#define TARGET_FPS 60
#define INITIAL_WINDOW_W 800
#define INITIAL_WINDOW_H 600

#define CELL_W 40
#define CELL_H 40

int main() {
    CoreFactory coreFactory = CoreFactory::Shared();
    std::unique_ptr<castle::Core> core = coreFactory.CreateCore();
    castle::Size cellSize (CELL_W, CELL_H);
    castle::Size windowSize (INITIAL_WINDOW_W, INITIAL_WINDOW_H);

    AB::PlaygroundScene playgroundScene (
        core,
        AB::InitDefaultPlaygroundMap(),
        cellSize
    );

    playgroundScene.m_SceneSize = windowSize;

    core->InitWindow(windowSize, "Castle Engine Text");
    core->SetTargetFPS(TARGET_FPS);

    while (!core->WindowShouldClose()) {
        core->BeginDrawing();

        core->ClearBackground(Color::White());

        core->DrawFPS();

        playgroundScene.Draw();

        core->EndDrawing();
    }

    core->CloseWindow();

    return 0;
}
