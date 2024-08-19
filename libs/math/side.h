#pragma once

namespace castle {

#define TOP_LEFT_CORNER_SIDES     std::vector<Side>({Side::LEFT, Side::TOP})
#define TOP_RIGHT_CORNER_SIDES    std::vector<Side>({Side::RIGHT, Side::TOP})
#define BOTTOM_RIGHT_CORNER_SIDES std::vector<Side>({Side::RIGHT, Side::BOTTOM})
#define BOTTOM_LEFT_CORNER_SIDES  std::vector<Side>({Side::LEFT, Side::BOTTOM})

enum struct Side {
    LEFT,
    RIGHT,
    TOP,
    BOTTOM,
};

} // namespace castle
