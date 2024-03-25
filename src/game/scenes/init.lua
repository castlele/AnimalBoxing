local LifeCycle = require("src.ui.interface.life_cycle")
local Scene = require("src.game.scenes.scene")


---@class Scenes : LifeCycle
---@field currentScene Scene?
---@field scenes table<Scene>
local Scenes = {
   className = "Scenes",
}
setmetatable(Scenes, { __index = LifeCycle })

-- Init

function Scenes:new()
   ---@type Scenes
   local this = {
      currentScene = nil,
      scenes = {
         Scene:createDebug(),
      },
   }

   setmetatable(this, self)

   self.__index = self

   return this
end

-- Life cycle

function Scenes:load()
   if self.currentScene ~= nil then
      self.currentScene:load()
   end
end

function Scenes:update(dt)
   if self.currentScene ~= nil then
      self.currentScene:update(dt)
   end
end

function Scenes:draw()
   if self.currentScene ~= nil then
      self.currentScene:draw()
   end
end


return Scenes
