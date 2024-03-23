local UI = require("src.ui.view.base_ui")
local Texture = require("src.ui.view.texture")
local colors = require("src.ui.view.colors")


-- TODO: Refactor without anim8
---@class Image : UI
---@field scale Vector2D
---@field _drawable love.Drawable?
---@field _animatable Animation
local Image = {
   className = "Image",
}
setmetatable(Image, { __index = UI })

-- Init

---@param frame? Frame
---@param texture? Texture
---@param className? string
function Image:new(frame, texture, className)
   if className then
      Image.className = className
   end

   texture = texture or Texture:new()

   local this = UI:new(frame, Image.className)

   this.isInteractionsEnables = false
   this.scale = texture.scale
   this._drawable = texture.image
   this._animatable = nil

   setmetatable(this, self)

   self.__index = self

   return this
end

-- Public methods

---@param scale Vector2D
function Image:setScale(scale)
   self.scale = scale
end

---@param texture Texture
function Image:setTexture(texture)
   self._drawable = texture.image
   self.scale = texture.scale
end

---@param drawable love.Drawable
function Image:setDrawable(drawable)
   self._drawable = drawable
end

---@param animatable Animation
function Image:setAnimatable(animatable)
   self._animatable = animatable
end

-- Life cycle

function Image:load()
   self.backgroundColor = colors.CLEAR
end

-- TODO: Refactor with drawing texture
function Image:draw()
   UI.draw(self)

   if not self._drawable then return end

   love.graphics.push()

   -- TODO: Is it right???
   love.graphics.setColor(colors.WHITE)

   if self._animatable then
      self._animatable:draw(
         self._drawable,
         self.frame.origin.x,
         self.frame.origin.y
      )
   else
      love.graphics.draw(
         self._drawable,
         self.frame.origin.x,
         self.frame.origin.y,
         nil,
         self.scale.x,
         self.scale.y
      )
   end

   love.graphics.pop()
end


return Image
