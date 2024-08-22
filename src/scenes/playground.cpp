#include "scenes/playground.h"
#include "logging.h"

namespace AB {

#pragma mark Non class declarations

std::vector<std::vector<std::string>> InitDefaultPlaygroundMap() {
    return {
        { AIR, AIR, AIR, AIR, AIR, AIR, AIR, AIR, AIR, AIR, AIR, AIR, AIR, AIR, AIR, AIR, AIR, AIR, AIR, AIR, },
        { AIR, AIR, AIR, AIR, AIR, AIR, AIR, AIR, AIR, AIR, AIR, AIR, AIR, AIR, AIR, AIR, AIR, AIR, AIR, AIR, },
        { AIR, AIR, AIR, AIR, AIR, AIR, AIR, AIR, AIR, AIR, AIR, AIR, AIR, AIR, AIR, AIR, AIR, AIR, AIR, AIR, },
        { AIR, AIR, AIR, AIR, AIR, AIR, AIR, AIR, AIR, AIR, AIR, AIR, AIR, AIR, AIR, AIR, AIR, AIR, AIR, AIR, },
        { AIR, AIR, AIR, AIR, AIR, AIR, AIR, AIR, AIR, AIR, AIR, AIR, AIR, AIR, AIR, AIR, AIR, AIR, AIR, AIR, },
        { AIR, AIR, AIR, AIR, AIR, AIR, AIR, AIR, AIR, AIR, AIR, AIR, AIR, AIR, AIR, AIR, AIR, AIR, AIR, AIR, },
        { AIR, AIR, AIR, AIR, AIR, AIR, AIR, AIR, AIR, AIR, AIR, AIR, AIR, AIR, AIR, AIR, AIR, AIR, AIR, AIR, },
        { AIR, AIR, AIR, AIR, AIR, AIR, AIR, AIR, AIR, AIR, AIR, AIR, AIR, AIR, AIR, AIR, AIR, AIR, AIR, AIR, },
        { AIR, AIR, AIR, AIR, AIR, AIR, AIR, AIR, AIR, AIR, AIR, AIR, AIR, AIR, AIR, AIR, AIR, AIR, AIR, AIR, },
        { AIR, AIR, AIR, AIR, AIR, AIR, AIR, AIR, AIR, AIR, AIR, AIR, AIR, AIR, AIR, AIR, AIR, AIR, AIR, AIR, },
        { AIR, AIR, AIR, AIR, AIR, AIR, AIR, AIR, AIR, AIR, AIR, AIR, AIR, AIR, AIR, AIR, AIR, AIR, AIR, AIR, },
        { AIR, AIR, AIR, AIR, AIR, AIR, AIR, AIR, AIR, AIR, AIR, AIR, AIR, AIR, AIR, AIR, AIR, AIR, AIR, AIR, },
        { AIR, AIR, AIR, AIR, AIR, AIR, AIR, AIR, AIR, AIR, AIR, AIR, AIR, AIR, AIR, AIR, AIR, AIR, AIR, AIR, },
        { AIR, AIR, AIR, AIR, AIR, AIR, AIR, AIR, AIR, AIR, AIR, AIR, AIR, AIR, AIR, AIR, AIR, AIR, AIR, AIR, },
        { GROUND, GROUND, GROUND, GROUND, GROUND, GROUND, GROUND, GROUND, GROUND, GROUND, GROUND, GROUND, GROUND, GROUND, GROUND, GROUND, GROUND, GROUND, GROUND, GROUND, },
    };
}

void PlaygroundScene::Draw() {
    Init();

    Update();

    // TODO: Move to superview
    for (std::shared_ptr<castle::View> subview : m_Subviews) {
        subview->Draw();
    }

    castle::Vector2D pos = m_Player->GetPosition();
    LOG("Player Position: (x: " + std::to_string(pos.x) + "; y: " + std::to_string(pos.y));
}

void PlaygroundScene::Init() {
    if (m_IsInited) {
        return;
    }

    std::vector<std::string> row;

    for (int row_i = 0; row_i < (int)m_Map.size(); row_i++) {
        row = m_Map.at(row_i);

        for (int col_i = 0; col_i < (int)row.size(); col_i++) {
            if (row.at(col_i) != GROUND) {
                continue;
            }

            castle::View ground (m_Core);

            ground.SetPosition(
                castle::Vector2D(
                    m_CellSize.width * col_i,
                    m_CellSize.height * row_i
                )
            );
            ground.SetSize(m_CellSize);
            ground.SetBackgroundColor(castle::Color::Red());

            m_Subviews.push_back(std::make_shared<castle::View>(ground));
        }
    }

    m_Subviews.push_back(m_Player);

    for (std::shared_ptr<castle::View> subview : m_Subviews) {
        subview->Init();
    }
}

void PlaygroundScene::Update() {
    for (std::shared_ptr<castle::View> subview : m_Subviews) {
        subview->Update(0);
    }

    real maxY = m_SceneSize.height - m_CellSize.height;
    castle::Vector2D playerPos = m_Player->GetPosition();
    real maxPlayerY = playerPos.y + m_Player->GetSize().height;

    if (maxPlayerY >= maxY) {
        playerPos.y = maxY;
        m_Player->SetPosition(playerPos);
    }
}

#pragma mark Private methods

} // namespace AB
