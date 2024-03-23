local Colors = require("src.ui.view.colors")


---@class TextAttributes
---@field font love.Font?
---@field textColor table
local TextAttributes = {}

---@param font love.Font?
---@param textColor? table
function TextAttributes:new(font, textColor)
   ---@class TextAttributes
   local this = {
      font = font,
      textColor = textColor or Colors.BLACK,
   }

   setmetatable(this, self)

   self.__index = self

   return this
end


return TextAttributes
