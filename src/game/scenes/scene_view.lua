local UI = require("src.ui.view.base_ui")


---@class SceneView : UI
---@field scene Scene
local SceneView = {
   className = "SceneView"
}
setmetatable(SceneView, { __index = UI })

-- Init

---@param scene Scene
function SceneView:new(scene)
   ---@type SceneView
   local this = UI:new(Frame.screenSize(), SceneView.className)

   this.scene = scene

   setmetatable(this, self)

   self.__index = self

   return this
end

-- Life cycle

function SceneView:load()
   local texture = self.scene:getBackgroundTexture()

   self:updateTexture(texture)

   UI.load(self)
end


return SceneView
