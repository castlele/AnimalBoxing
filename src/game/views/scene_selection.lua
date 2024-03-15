local UI = require("src.ui.view.base_ui")


---@class SceneSelection : UI
local SceneSelection = {
   className = "SceneSelection"
}
setmetatable(SceneSelection, { __index = UI })

-- Init

function SceneSelection:new(frame)
   ---@type SceneSelection
   local this = UI:new(frame, SceneSelection.className)

   setmetatable(this, self)

   self.__index = self

   return this
end


return SceneSelection
