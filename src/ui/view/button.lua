local UI = require("src.ui.view.base_ui")
local Label = require("src.ui.view.label")
local Colors = require("src.ui.view.colors")
local Image = require("src.ui.view.image")


---@enum ControlState
ControlState = {
   NORMAL = 1,
   HIGHLIGHTED = 2,
   HOVERED = 3,
}


---@class Appearance
---@field backgroundColor table
---@field textColor table
---@field image love.Image?


---@class Button: UI
---@field isFocused boolean
---@field text string?
---@field isButtonPressed boolean
---@field align love.AlignMode
---@field stateAppearance table<ControlState, Appearance>
---@field state ControlState
---@field _label Label
---@field _image Image
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

   local this = UI:new(frame, Button.className)
   ---@type Appearance
   local appearance = {
      backgroundColor = Colors.CLEAR,
      textColor = Colors.BLACK,
      image = nil,
   }
   this.stateAppearance = {
      [ControlState.NORMAL] = appearance,
   }
   this.state = ControlState.NORMAL
   this.text = nil

   this._label = Label:new(frame)
   this._image = Image:new(frame)

   setmetatable(this, self)

   self.__index = self

   return this
end

-- Overrides

---@param event MouseEvent
function Button:processMouseEvent(event)
   if event.eventType ~= "mouseLeftButton" then return end

   if event.type == "mousepressed" then
      self.isButtonPressed = true
      self.state = ControlState.HIGHLIGHTED
      return
   end

   if self.isButtonPressed then
      self.state = ControlState.NORMAL
      self.isButtonPressed = false

      UI.processMouseEvent(self, event)
   end
end

-- Button specific

---@param color table
---@param state ControlState
function Button:setTextColor(color, state)
   local appearance = self.stateAppearance[state]

   -- TODO: How to remove copy-paste
   if appearance == nil then
      appearance = {
         backgroundColor = Colors.CLEAR,
         textColor = color,
         image = nil,
      }
   else
      appearance.textColor = color
   end

   self.stateAppearance[state] = appearance
end

---@param image love.Image
---@param state ControlState
function Button:setImage(image, state)
   local appearance = self.stateAppearance[state]

   -- TODO: How to remove copy-paste
   if appearance == nil then
      appearance = {
         backgroundColor = Colors.CLEAR,
         textColor = Colors.BLACK,
         image = image
      }
   else
      appearance.image = image
   end

   self.stateAppearance[state] = appearance
end

---@param color table
---@param state ControlState
function Button:setBackgroundColor(color, state)
   local appearance = self.stateAppearance[state]

   -- TODO: How to remove copy-paste
   if appearance == nil then
      appearance = {
         backgroundColor = color,
         textColor = Colors.BLACK,
         image = nil,
      }
   else
      appearance.backgroundColor = color
   end

   self.stateAppearance[state] = appearance
end

-- Life cycle

function Button:load()
   self:addSubview(self._image)
   self:addSubview(self._label)

   UI.load(self)
end

---@param dt number
function Button:update(dt)
   UI.update(self, dt)

   self:updateState()
   self:applyAppearance()
end

function Button:draw()
   UI.draw(self)

   if self.isFocused then
      self.borderColor = { 1, 0, 0 }
   else
      self.borderColor = { 1, 1, 1, 0 }
   end
end

-- Private methods

---@private
function Button:updateState()
   if love.mouse.isDown(1) then return end

   local pos = Vector2D:new(love.mouse.getPosition())

   local hovered = ControlState.HOVERED

   if self.frame:isPointInside(pos) and self.stateAppearance[hovered] then
      self.state = hovered
   else
      self.state = ControlState.NORMAL
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
   self._image:setDrawable(appearance.image)
end


return Button
