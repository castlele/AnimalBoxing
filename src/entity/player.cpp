#include "entity/player.h"
#include "logging.h"
#include <string>

namespace AB {

void PlayerView::Init() {
    castle::View::Init();

    SetBackgroundColor(castle::Color::Blue());
    SetSize(castle::Size(40, 40));
}

void PlayerView::Update(float dt) {
    castle::View::Update(dt);

    move();
    applyGravity();

    // logPlayerStateAfterUpdate();
}

void PlayerView::Draw() {
    castle::View::Draw();
}

#pragma mark Private methods

void PlayerView::applyGravity() {
    addPlayerYPos(5);
}

void PlayerView::move() {
    if (m_Core->IsKeyDown(castle::KEY_D)) {
        addPlayerXPos(0.05);
    } else if (m_Core->IsKeyDown(castle::KEY_A)) {
        addPlayerXPos(-0.05);
    }

    if (m_Core->IsKeyPressed(castle::KEY_SPACE)) {
        addPlayerYPos(-6);
    }
}

void PlayerView::logPlayerStateAfterUpdate() {
    castle::Vector2D pos = GetPosition();
    castle::Size size = GetSize();

    LOG("Player Position: (x: " + std::to_string(pos.x) + "; y: " + std::to_string(pos.y));
    LOG("Player Size: (width: " + std::to_string(size.width) + "; height: " + std::to_string(size.height));
}

void PlayerView::addPlayerYPos(real yPos) {
    castle::Vector2D newPos = GetPosition();
    newPos.y += yPos;

    SetPosition(newPos);
}

void PlayerView::addPlayerXPos(real xPos) {
    castle::Vector2D newPos = GetPosition();
    newPos.x += xPos;

    SetPosition(newPos);
}

} // namespace AB
