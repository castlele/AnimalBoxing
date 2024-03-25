local UI = require("src.ui.view.base_ui")
local MainMenu = require("src.game.views.main_menu")
local Players = require("src.entities")
local Scenes = require("src.game.scenes")


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
   if self.rootUIObject == nil then return end

   local view = self.rootUIObject:hitTest(event)

   if view then
      view:processMouseEvent(event)
   end
end

function Game:load()
   self.className = "Game"
   self:setupMainControl()
   self.players = Players:new()
   self.scenes = Scenes:new()

   if self.rootUIObject == nil then
      self.rootUIObject = MainMenu:new(self.frame)
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

function Game:setupMainControl()
   if love.joystick.getJoystickCount() == 0 then
      self.mainControl = "mouse"
      self.mainJoystick = nil
      return
   end

   self.mainControl = "joystick"
   self.mainJoystick =  love.joystick.getJoysticks()[1]
end


return Game

