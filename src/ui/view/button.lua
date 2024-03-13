local UI = require("src.ui.view.base_ui")
local Label = require("src.ui.view.label")
local Colors = require("src.ui.view.colors")


---@enum ControlState
ControlState = {
   NORMAL = 1,
   HIGHLIGHTED = 2,
   HOVERED = 3,
}


---@class Appearance
---@field backgroundColor table
---@field textColor table


---@class Button: UI
---@field text string?
---@field align love.AlignMode
---@field stateAppearance table<ControlState, Appearance>
---@field state ControlState
---@field _label Label
local Button = {
   className = "Button"
}
setmetatable(Button, { __index = UI })

-- Init

---@param frame Frame
---@param className? string
function Button:new(frame, className)
   if className ~= nil then
      Button.className = className
   end

   local _button = UI:new(frame, Button.className)
   ---@type Appearance
   local appearance = {
      backgroundColor = Colors.CLEAR,
      textColor = Colors.BLACK,
   }
   _button.stateAppearance = {
      [ControlState.NORMAL] = appearance,
   }
   _button.state = ControlState.NORMAL
   _button.text = nil

   local _label = Label:new(frame)
   _button._label = _label

   setmetatable(_button, self)

   self.__index = self

   return _button
end

-- Overrides

---@param event MouseEvent
function Button:processMouseEvent(event)
   if event.eventType ~= "mouseLeftButton" then return end

   if event.type == "mousepressed" then
      self.state = ControlState.HIGHLIGHTED
   else
      self.state = ControlState.NORMAL
   end

   UI.processMouseEvent(self, event)
end

-- Button specific

---@param color table
---@param state ControlState
function Button:setTextColor(color, state)
   local appearance = self.stateAppearance[state]

   if appearance == nil then
      appearance = {
         backgroundColor = Colors.CLEAR,
         textColor = color,
      }
   else
      appearance.textColor = color
   end

   self.stateAppearance[state] = appearance
end

---@param color table
---@param state ControlState
function Button:setBackgroundColor(color, state)
   local appearance = self.stateAppearance[state]

   if appearance == nil then
      appearance = {
         backgroundColor = color,
         textColor = Colors.BLACK,
      }
   else
      appearance.backgroundColor = color
   end

   self.stateAppearance[state] = appearance
end

-- Life cycle

function Button:load()
   self:addSubview(self._label)

   UI.load(self)
end

---@param dt number
function Button:update(dt)
   UI.update(self, dt)

   self:updateState()
   self:applyAppearance()
end

-- Private methods

---@private
function Button:updateState()
   if not love.mouse.isDown(1) then
      local pos = Vector2D:new(love.mouse.getPosition())

      local hovered = ControlState.HOVERED

      if self.frame:isPointInside(pos) and self.stateAppearance[hovered] then
         self.state = hovered
      else
         self.state = ControlState.NORMAL
      end
   end
end

---@private
function Button:applyAppearance()
   self._label.text = self.text
   self._label.align = self.align

   local appearance = self.stateAppearance[self.state]

   if appearance == nil then return end

   self.backgroundColor = appearance.backgroundColor
   self._label.textColor = appearance.textColor
end


return Button
