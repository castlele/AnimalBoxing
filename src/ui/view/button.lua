local UI = require("src.ui.view.base_ui")
local Label = require("src.ui.view.label")
local Colors = require("src.ui.view.colors")
local ButtonState = require("src.ui.view.button_state")
local Appearance = require("src.ui.view.ui_appearance")
local Texture = require("src.ui.view.texture")
local TextAttributes = require("src.ui.view.text_attributes")


---@class Button: UI
---@field isFocused boolean
---@field text string?
---@field isButtonPressed boolean
---@field align love.AlignMode
---@field stateAppearance table<ButtonState, ButtonAppearance>
---@field state ButtonState
---@field _label Label
local Button = {
   className = "Button"
}
setmetatable(Button, { __index = UI })

-- Init

---@param frame? Frame
---@param className? string
function Button:new(frame, className)
   if className then
      Button.className = className
   end

   local this = UI:new(frame, Button.className)
   ---@type ButtonAppearance
   local appearance = Appearance.BUTTON(
      Colors.CLEAR,
      Texture:new(),
      TextAttributes:new(nil)
   )

   this.stateAppearance = {
      [ButtonState.NORMAL] = appearance,
   }
   this.state = ButtonState.NORMAL
   this.text = nil

   this._label = Label:new(this.frame:copy())

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
      self.state = ButtonState.HIGHLIGHTED
      return
   end

   if self.isButtonPressed then
      self.state = ButtonState.NORMAL
      self.isButtonPressed = false

      UI.processMouseEvent(self, event)
   end
end

-- Button specific

---@param color table
---@param state ButtonState
function Button:setTextColor(color, state)
   local appearance = self.stateAppearance[state]

   if appearance then
      appearance.textAttributes.textColor = color
   else
      appearance = Appearance.BUTTON(
         Colors.CLEAR,
         Texture:new(),
         TextAttributes:new(nil, color)
      )
   end

   self.stateAppearance[state] = appearance
end

---@param texture Texture
---@param state ButtonState
function Button:setTexture(texture, state)
   local appearance = self.stateAppearance[state]

   if appearance then
      appearance.texture.image = texture.image
      appearance.texture.scale = texture.scale
   else
      appearance = Appearance.BUTTON(
         Colors.CLEAR,
         texture,
         TextAttributes:new(nil)
      )
   end

   self.stateAppearance[state] = appearance
end

---@param color table
---@param state ButtonState
function Button:setBackgroundColor(color, state)
   local appearance = self.stateAppearance[state]

   if appearance then
      appearance.backgroundColor = color
   else
      appearance = Appearance.BUTTON(
         color,
         Texture:new(),
         TextAttributes:new(nil)
      )
   end

   self.stateAppearance[state] = appearance
end

---@param padding string
---| "top"
---@param value number
function Button:setLabelPadding(padding, value)
   if padding == "top" then
      local currentY = self._label.frame.origin.y
      self._label.frame.origin.y = currentY + value
   end
end

-- Life cycle

function Button:load()
   self:addSubview(self._label)

   UI.load(self)
end

---@param dt number
function Button:update(dt)
   self:updateLabelLayout()
   self:updateState()
   self:applyAppearance()

   UI.update(self, dt)
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
function Button:updateLabelLayout()
   if not self._label.frame.size:isZero() then return end

   self._label.frame = self.frame:copy()
end

---@private
function Button:updateState()
   if love.mouse.isDown(1) then return end

   local pos = Vector2D:new(love.mouse.getPosition())

   local hovered = ButtonState.HOVERED

   if self.frame:isPointInside(pos) and self.stateAppearance[hovered] then
      self.state = hovered
   else
      self.state = ButtonState.NORMAL
   end
end

---@private
function Button:applyAppearance()
   self._label.text = self.text
   self._label.align = self.align

   local appearance = self.stateAppearance[self.state]

   if appearance == nil then return end

   self.backgroundColor = appearance.backgroundColor
   self._label.textColor = appearance.textAttributes.textColor

   self:updateTexture(appearance.texture)
end


return Button
