#pragma once

#include <vector>

#include "math/constants.h"
#include "math/side.h"

namespace castle {

struct Vector2D {
    real x;
    real y;

    Vector2D(real x = 0, real y = 0) : x(x), y(y) {}

    Vector2D operator+=(Vector2D other) {
        return Vector2D(
            x + other.x,
            y + other.y
        );
    }

    void applyInsets(std::vector<Side> sides, real inset);
};

} // namespace castle
