local UI = require("src.ui.view.base_ui")
local colors = require("src.ui.view.colors")


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
---@param scale? Vector2D
---@param className? string
function Image:new(frame, scale, className)
   if className then
      Image.className = className
   end

   local this = UI:new(frame, Image.className)

   this.isInteractionsEnables = false
   this.scale = scale or Vector2D:new(1, 1)
   this._drawable = nil
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
