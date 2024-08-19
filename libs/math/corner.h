#pragma once

#include "math/vector2d.h"
#include "math/size.h"

namespace castle {

enum struct Corner {
    TOP_LEFT,
    TOP_RIGHT,
    BOTTOM_RIGHT,
    BOTTOM_LEFT,
};

Vector2D CornerToVector(const Corner corner, const Size windowSize);

} // namespace castle
