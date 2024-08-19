#pragma once

#include <memory>

#include "core.h"

namespace castle {

class CoreFactory {
private:
    CoreFactory() = default;

public:
    static CoreFactory &Shared() {
        static CoreFactory instance;

        return instance;
    }

    std::unique_ptr<Core> CreateCore();
};

} // namespace castle

