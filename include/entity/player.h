#pragma once

#include <libcastle.h>
#include <memory>

namespace AB {

// TODO: There should be something like player configuration
class PlayerView : public castle::View {
public:
    PlayerView(std::unique_ptr<castle::Core> &core) : castle::View(core) {};

    virtual ~PlayerView() = default;

    virtual void Init() override;
    virtual void Update(float dt) override;
    virtual void Draw() override;

private:
    void applyGravity();
    void move();
    void logPlayerStateAfterUpdate();

    void addPlayerYPos(real yPos);
    void addPlayerXPos(real xPos);
};

} // namespace AB
