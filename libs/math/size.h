#pragma once

#include "math/constants.h"

namespace castle {

struct Size {
    real width;
    real height;

    Size(real width, real height) : width(width), height(height) {}
};

} // namespace castle
