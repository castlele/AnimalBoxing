local UI = require("src.ui.view.base_ui")


---@class Stack : UI
---@field spacing number
---@field arrangedSubviews table<UI>
---@field alignment string
---| "horizontal"
---| "vertical"
local Stack = {
   className = "Stack"
}
setmetatable(Stack, { __index = UI})

-- Init

---@param frame? Frame
---@param className? string
function Stack:new(frame, className)
   ---@type Stack
   local this = UI:new(frame, className)

   this.alignment= "vertical"
   this.arrangedSubviews = {}
   this.spacing = 0

   setmetatable(this, self)

   self.__index = self

   return this
end

-- Public methods

---@param subview UI
function Stack:addArrangedSubview(subview)
   table.insert(self.arrangedSubviews, subview)
   self:addSubview(subview)
end

-- LifeCycle

---@param dt number
function Stack:update(dt)
   self:updateLayout()

   UI.update(self, dt)
end

-- Private methods

---@private
function Stack:updateLayout()
   local stackPos = self.frame.origin
   local maxWidth = 0
   local maxHeight = 0

   if self.alignment == "vertical" then
      self:iterateArrangedSubviews(function (index, subview)
         local subviewSize = subview.frame.size
         local shift = (index - 1) * (self.spacing + subviewSize.height)
         local y = stackPos.y + shift
         local origin = Vector2D:new(stackPos.x, y)

         if not subview.frame.origin:equals(origin) then
            subview.frame.origin = origin
         end

         maxWidth = math.max(subviewSize.width, maxWidth)
         maxHeight = maxHeight + shift
      end)

   elseif self.alignment == "horizontal" then
      -- TODO: Implement
   end

   local newSize = Size:new(maxWidth, maxHeight)

   if not self.frame.size:equals(newSize) then
      self.frame.size = newSize
   end
end

---@private
---@param callback fun(index: integer, subview: UI)
function Stack:iterateArrangedSubviews(callback)
   for index, subview in ipairs(self.arrangedSubviews) do
      callback(index, subview)
   end
end


return Stack
