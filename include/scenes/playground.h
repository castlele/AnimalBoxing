#pragma once

#include <libcastle.h>
#include <memory>
#include <string>
#include <vector>

#include "entity/player.h"

typedef std::unique_ptr<castle::Core> CoreType;

#define AIR std::string("")
#define GROUND std::string("X")

namespace AB {

class PlaygroundScene {
public:
    castle::Size m_SceneSize;

private:
    CoreType &m_Core;
    std::vector<std::vector<std::string>> m_Map;
    std::vector<std::shared_ptr<castle::View>> m_Subviews;
    std::shared_ptr<castle::View> m_Player;
    castle::Size m_CellSize;

    bool m_IsInited = false;

public:
    PlaygroundScene(
        CoreType &core,
        std::vector<std::vector<std::string>> map,
        castle::Size cellSize
    ) :
        m_Core(core)
        , m_Map(map)
        , m_Player(std::make_shared<PlayerView>(core))
        , m_CellSize(cellSize)
    {};

    void Draw();
    void Init();
    void Update();
};

std::vector<std::vector<std::string>> InitDefaultPlaygroundMap();

} // namespace AB
