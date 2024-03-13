---@class LifeCycle: LuaClass
local lifeCycle = {
   className = "LifeCycle",
}

function lifeCycle:load()
   assert(false, "Method should be called from subclass")
end

---@param dt number
function lifeCycle:update(dt)
   assert(false, "Method should be called from subclass")
end

function lifeCycle:draw()
   assert(false, "Method should be called from subclass")
end

return lifeCycle
