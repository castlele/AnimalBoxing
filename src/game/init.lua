local Button = require("src.ui.view.button")
local ButtonState = require("src.ui.view.button_state")
local Colors = require("src.ui.view.colors")
local MainMenu = require("src.game.views.main_menu")
local Players = require("src.entities")
local Scenes = require("src.game.scenes")
local UI = require("src.ui.view.base_ui")


-- TODO: Refactor rootUIObject with presentedUI in base UI
---@class Game: UI
---@field rootUIObject UI?
---@field players Players
---@field scenes Scenes
---@field mainControl string
---| "mouse"
---| "joystick"
---@field mainJoystick love.Joystick?
local Game = UI:new(
   Frame:new(
      Vector2D:new(0, 0),
      Size:new(love.window.getMode())
   ),
   "Game"
)
setmetatable(Game, { __index = UI })

---@param event MouseEvent
function Game:processMouseEvent(event)
   if not self.rootUIObject then return end

   self.rootUIObject:processMouseEvent(event)
end

---@param event KeyboardEvent
function Game:processKeyboardEvent(event)
   if not self.rootUIObject then return end

   self.rootUIObject:processKeyboardEvent(event)
end

function Game:startTheGame()
   self.rootUIObject = self.scenes:initLevel()
   self.rootUIObject:load()
end

-- Life cycle

function Game:load()
   self:setupMainControl()
   self.players = Players:new()
   self.scenes = Scenes:new()

   if self.rootUIObject == nil then
      self:initMainMenu()
   end

   self.rootUIObject:load()
end

function Game:update(dt)
   assert(self.rootUIObject ~= nil, "Root UI object can't be nil")

   self.rootUIObject:update(dt)
end

function Game:draw()
   assert(self.rootUIObject ~= nil, "Root UI object can't be nil")

   UI.draw(self)

   self.rootUIObject:draw()
end

--Private methods

---@private
function Game:setupMainControl()
   if love.joystick.getJoystickCount() == 0 then
      self.mainControl = "mouse"
      self.mainJoystick = nil
      return
   end

   self.mainControl = "joystick"
   self.mainJoystick =  love.joystick.getJoysticks()[1]
end

---@private
function Game:initMainMenu()
   self.rootUIObject = MainMenu:new(self.frame)
   self:setupDebugMode()
end

---@private
function Game:setupDebugMode()
   if not Config.isDebug then return end

   self.rootUIObject:addKeyboardeventListener(function (view, event)
      if not view:isPresenting() and event.key == "\\" then
         self:startTheGame()
         return true
      end

      return false
   end)
end


return Game

