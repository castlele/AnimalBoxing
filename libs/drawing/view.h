#pragma once

#include "core.h"

namespace castle {

class View {
protected:
    std::unique_ptr<castle::Core> &m_Core;

private:
    Vector2D m_Position;
    Size m_Size;
    Color m_BackgroundColor = Color::White();

public:
    View(std::unique_ptr<castle::Core> &core) : m_Core(core) {};
    virtual ~View() = default;

    Vector2D GetPosition() const;
    void SetPosition(Vector2D pos);
    Size GetSize() const;
    void SetSize(Size size);
    Color GetBackgroundColor() const;
    void SetBackgroundColor(Color color);

    virtual void Draw();
    virtual void Init();
    virtual void Update(float dt);
};

} // namespace castle
