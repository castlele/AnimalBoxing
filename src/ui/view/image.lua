local UI = require("src.ui.view.base_ui")


---@class Image : UI
---@field _drawable love.Drawable?
---@field _animatable Animation
local Image = {
   className = "Image",
}
setmetatable(Image, { __index = UI })

-- Init

---@param frame Frame
---@param className? string
function Image:new(frame, className)
   if className then
      Image.className = className
   end

   local this = UI:new(frame, Image.className)

   this._drawable = nil
   this._animatable = nil

   setmetatable(this, self)

   self.__index = self

   return this
end

-- Public methods

---@param drawable love.Drawable
function Image:setDrawable(drawable)
   self._drawable = drawable
end

---@param animatable Animation
function Image:setAnimatable(animatable)
   self._animatable = animatable
end

-- Life cycle

function Image:draw()
   UI.draw(self)

   if not self._drawable then return end

   love.graphics.push()

   love.graphics.setColor({1, 1, 1})

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
         self.frame.size.width,
         self.frame.size.height
      )
   end

   love.graphics.pop()
end


return Image
