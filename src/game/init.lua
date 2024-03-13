local UI = require("src.ui.view.base_ui")
local MainMenu = require("src.game.views.main_menu")
local Players = require("src.entities")


---@class Game: UI
---@field rootUIObject UI?
---@field players Players
---@field scenes Scenes
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

   if view ~= nil then
      view:processMouseEvent(event)
   end
end

function Game:load()
   self.className = "Game"
   self.players = Players:new()

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


return Game

