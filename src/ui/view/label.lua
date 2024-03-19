local UI = require("src.ui.view.base_ui")
local Colors = require("src.ui.view.colors")

---@class Label: UI
---@field text string?
---@field textColor table
---@field align love.AlignMode
local label = {
   className = "Label",
}
setmetatable(label, { __index = UI })

---@param frame? Frame
---@param className? string
function label:new(frame, className)
   if className ~= nil then
      label.className = className
   end

   ---@type Label
   local _label = UI:new(frame, label.className)

   _label.text = nil
   _label.textColor = Colors.BLACK
   _label.align = "left"
   _label.backgroundColor = Colors.CLEAR
   _label.isInteractionsEnables = false

   setmetatable(_label, self)

   self.__index = self

   return _label
end

function label:draw()
   UI.draw(self)

   if self.text == nil then return end

   -- TODO: make font configuration
   local font = love.graphics.newFont("res/fonts/base.ttf", 16)

   love.graphics.setColor(self.textColor)

   love.graphics.setFont(font)
   love.graphics.printf(
      self.text,
      self.frame.origin.x,
      self.frame.origin.y,
      self.frame.size.width,
      self.align
   )
end


return label
