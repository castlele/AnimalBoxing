#include <libcastle.h>
#include <memory>

using namespace castle;

#define FONT_SIZE 60.0

int main() {
    CoreFactory coreFactory = CoreFactory::Shared();
    std::unique_ptr<castle::Core> core = coreFactory.CreateCore();

    core->InitWindow(Size(800, 600), "Castle Engine Text");
    core->SetTargetFPS(60);

    Size windowSize = core->GetWindowSize();
    Vector2D textPos = Vector2D(
        windowSize.width/2 - FONT_SIZE/2,
        windowSize.height/2 - FONT_SIZE/2
    );

    while (!core->WindowShouldClose()) {
        core->BeginDrawing();

        core->ClearBackground(Color::White());

        drawPressedKey(core, textPos);
        core->DrawFPS();

        core->EndDrawing();
    }

    core->CloseWindow();

    return 0;
}
