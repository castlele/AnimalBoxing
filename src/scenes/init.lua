require("src.utils.math_types")
require("src.scenes.scene")

---@class Scenes
---@field currentScene Scene?
local scenes = {
   currentScene = Scene:createDebug()
}

---@param type string
---| "left"
---| "right"
---@return Vector2D
function scenes:getPlayerPos(type)
   local index

   if type == "left" then
      index = 1
   else
      index = 2
   end

   return self.currentScene:getPlayerPos(index)
end

function scenes:load()
   if self.currentScene ~= nil then
      self.currentScene:load()
   end
end

function scenes:update(dt)
   if self.currentScene ~= nil then
      self.currentScene:update(dt)
   end
end

function scenes:draw()
   if self.currentScene ~= nil then
      self.currentScene:draw()
   end
end

return scenes
