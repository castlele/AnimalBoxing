local LifeCycle = require("src.ui.interface.life_cycle")
local Texture = require("src.ui.view.texture")
local Logger = require("src.foundation.logger")
local colors = require("src.ui.view.colors")


---@class UI: LifeCycle
---@field texture Texture
---@field isHidden boolean
---@field subviews table<UI>
---@field frame Frame
---@field backgroundColor table
---@field borderColor table
---@field isInteractionsEnables boolean
---@field tapGestureRecognizers table<fun(view: UI)>
---@field keyboardEventListeners table<fun(view: UI, event: KeyboardEvent): boolean>
---@field presentedUI UI?
---@field presentingUI UI?
---@field _logger Logger
local UI = {
   className = "UI",
}

--TODO: Temporary solution. as in UIKit every UI should have background color and etc
---@deprecated
UI.colors = {
   background = { 102/255, 255/255, 255/255, 1 },
   button = {
      background = { 255/255, 242/255, 204/255 },
      font = { 0, 0, 0 },
   }
}
setmetatable(UI, { __index = LifeCycle })

-- Init

---@param frame? Frame
---@param className? string
function UI:new(frame, className)
   if className ~= nil then
      UI.className = className
   end

   local uiElement = {
      frame = frame or Frame.frameZero(),
      texture = Texture:new(),
      isHidden = false,
      subviews = {},
      backgroundColor = {1, 1, 1},
      borderColor = {1, 1, 1, 0},
      isInteractionsEnables = true,
      tapGestureRecognizers = {},
      keyboardEventListeners = {},
      presentedUI = nil,
      presentingUI = nil,
   }

   uiElement._logger = Logger:new(UI.className)

   setmetatable(uiElement, self)

   self.__index = self

   return uiElement
end

-- Presentation

---@return boolean
function UI:isPresenting()
   return self.presentedUI ~= nil
end

---@param view UI
function UI:present(view)
   self.presentedUI = view
   self.presentedUI.presentingUI = self
   self:addSubview(self.presentedUI)
   self.presentedUI:load()
end

function UI:dismiss()
   if not self.presentingUI then return end

   self.presentingUI:pop()
end

function UI:pop()
   if not self.presentedUI then return end

   self.presentedUI.presentingUI = nil
   self.presentedUI = nil
   table.remove(self.subviews, #self.subviews)
end

-- Subviews manipulations

---@param subview UI
function UI:addSubview(subview)
   table.insert(self.subviews, subview)
end

---@param texture Texture
function UI:updateTexture(texture)
   self.texture = texture
end

-- Events handling

---@generic T : UI
---@param callback fun(view: T)
function UI:addTapGestureRecognizer(callback)
   table.insert(self.tapGestureRecognizers, callback)
end

---@generic T : UI
---@param callback fun(view: T, event: KeyboardEvent): boolean
function UI:addKeyboardeventListener(callback)
   table.insert(self.keyboardEventListeners, callback)
end

---@param event MouseEvent
function UI:processMouseEvent(event)
   local ui = self:hitTest(event)

   if not ui then return end

   for _, tapRecognizer in pairs(ui.tapGestureRecognizers) do
      tapRecognizer(self)
   end
end

---@param event KeyboardEvent
---@return boolean
function UI:canHandleKeyboardEvent(event)
   for _, listener in pairs(self.keyboardEventListeners) do
      if listener(self, event) then
         return true
      end
   end

   return false
end

---@param event KeyboardEvent
function UI:processKeyboardEvent(event)
   if self:canHandleKeyboardEvent(event) then return end

   self:iterateSubviews(function (subview)
      -- WARN: don't know if this return will break iteration
      if subview:canHandleKeyboardEvent(event) then return end
   end)
end

---@param event MouseEvent
---@return UI?
function UI:hitTest(event)
   if not self.isInteractionsEnables then
      self._logger:log("Interactions disabled for " .. self.className)
      return nil
   end

   if not self:isHitInsideBounds(event.point) then
      self._logger:log("Hit was outside the " .. self.className)
      return nil
   end

   if self.presentedUI and self.presentedUI:isHitInsideBounds(event.point) then
      self._logger:log("Hit was inside the presented UI: " .. self.className)
      return self.presentedUI:hitTest(event)
   end

   for _, subview in pairs(self.subviews) do
      local hittedView = subview:hitTest(event)

      if hittedView ~= nil then
         self._logger:log(hittedView.className .. " is hitted")
         return hittedView
      end
   end

   self._logger:log(self.className .. " is hitted")

   return self
end

---@param point Vector2D
---@return boolean
function UI:isHitInsideBounds(point)
   return self.frame:isPointInside(point) and not self.isHidden
end

-- Life cycle

function UI:load()
   self:iterateSubviews(function (subview)
      subview:load()
   end)
end

---@param dt number
function UI:update(dt)
   self:iterateSubviews(function (subview)
      subview:update(dt)
   end)
end

function UI:draw()
   if self.isHidden then return end

   love.graphics.push()

   love.graphics.setColor(self.backgroundColor)
   love.graphics.rectangle(
      "fill",
      self.frame.origin.x,
      self.frame.origin.y,
      self.frame.size.width,
      self.frame.size.height
   )

   love.graphics.setColor(self.borderColor)
   love.graphics.rectangle(
      "line",
      self.frame.origin.x,
      self.frame.origin.y,
      self.frame.size.width,
      self.frame.size.height
   )

   self:drawDebugInfoIfNeeded()

   love.graphics.pop()

   self:drawTexture()

   self:iterateSubviews(function (subview)
      subview:draw()
   end)
end

-- Private

---@private
---@param callback fun(subview: UI)
function UI:iterateSubviews(callback)
   for _, subview in pairs(self.subviews) do
      callback(subview)
   end
end

---@private
function UI:drawTexture()
   love.graphics.push()

   love.graphics.setColor(colors.WHITE)

   if self.texture.image then
      love.graphics.draw(
         self.texture.image,
         self.frame.origin.x,
         self.frame.origin.y,
         nil,
         self.texture.scale.x,
         self.texture.scale.y
      )
   end

   love.graphics.pop()
end

---@private
function UI:drawDebugInfoIfNeeded()
   local alpha = self.borderColor[4] or 1

   if not Config.isDebug or alpha == 1 then return end

   love.graphics.setColor(colors.BLACK)

   if Config.debug.isClassName then
      love.graphics.printf(
         self.className,
         self.frame.origin.x,
         self.frame.origin.y,
         self.frame.size.width
      )
   end

   if Config.debug.isBorder then
      love.graphics.rectangle(
         "line",
         self.frame.origin.x,
         self.frame.origin.y,
         self.frame.size.width,
         self.frame.size.height
      )
   end
end


return UI
