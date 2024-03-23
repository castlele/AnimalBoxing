---@class Texture
---@field image? love.Image
---@field scale Vector2D
local Texture = {}

---@param image? love.Image
---@param scale? Vector2D
function Texture:new(image, scale)
   ---@type Texture
   local this = {
      image = image,
      scale = scale or Vector2D:new(1, 1),
   }

   setmetatable(this, self)

   self.__index = self

   return this
end


return Texture
