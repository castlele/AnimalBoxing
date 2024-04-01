local Scene = require("src.game.scenes.scene")
local SceneView = require("src.game.scenes.scene_view")
local UI = require("src.ui.view.base_ui")


---@class Scenes : UI
---@field currentScene Scene?
---@field scenes table<Scene>
local Scenes = {
   className = "Scenes",
}
setmetatable(Scenes, { __index = UI })

-- Init

function Scenes:new()
   ---@type Scenes
   local this = UI:new()

   this.currentScene = nil
   this.scenes = {
      Scene:createDebug(),
   }

   setmetatable(this, self)

   self.__index = self

   return this
end

-- Public methods

---@return UI
function Scenes:initLevel()
   assert(self.currentScene ~= nil, "You can't initialize level without scene")

   return SceneView:new(self.currentScene)
end

-- Life cycle

function Scenes:load()
   if self.currentScene then
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
