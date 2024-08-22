#pragma once

#include "math/constants.h"

namespace castle {

struct Size {
    real width;
    real height;

    Size(real width = 0, real height = 0) : width(width), height(height) {}
};

} // namespace castle
