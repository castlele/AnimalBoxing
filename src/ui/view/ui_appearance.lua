require("src.ui.view.texture")
require("src.ui.view.text_attributes")


-- Appearance

---@class Appearance : LuaClass
---@field backgroundColor table
local Appearance = {}
setmetatable(Appearance, {
   __call = function (t, backgroundColor)
      return t:new(backgroundColor)
   end,
})

---@param backgroundColor table
function Appearance:new(backgroundColor)
   local this = {}

   this.backgroundColor = backgroundColor

   setmetatable(this, self)

   self.__index = self

   return this
end

-- ButtonAppearance

---@class ButtonAppearance : Appearance
---@field texture Texture
---@field textAttributes TextAttributes
local ButtonAppearance = {}
setmetatable(ButtonAppearance, {
   __index = Appearance,
   __call = function (t, backgroundColor, texture, textAttributes)
      return t:new(backgroundColor, texture, textAttributes)
   end,
})

---@param backgroundColor table
---@param texture Texture
---@param textAttributes TextAttributes
function ButtonAppearance:new(backgroundColor, texture, textAttributes)
   ---@type ButtonAppearance
   local this = Appearance(backgroundColor)

   this.texture = texture
   this.textAttributes = textAttributes

   setmetatable(this, self)

   self.__index = self

   return this
end


return {
   BASE = Appearance,
   BUTTON = ButtonAppearance,
}
