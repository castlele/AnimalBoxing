local UI = require("src.ui.view.base_ui")
local Button = require("src.ui.view.button")
local PlayerSelection = require("src.game.views.player_selection")


---@class MainMenu: UI
---@field startButton Button
---@field quitButton Button
local mainMenu = {
   className = "MainMenu",
}
setmetatable(mainMenu, { __index = UI })

-- Actions

---@param self MainMenu
mainMenu.startGame = function (self, _)
   self._logger:log("'Start the game' button pressed")
   self:present(PlayerSelection:new(self.frame))
end

mainMenu.quit = function (self, _)
   self._logger:log("'Quit the game' button pressed")
   love.event.quit(0)
end

-- Init

---@param frame Frame
function mainMenu:new(frame)
   ---@type MainMenu
   local menu = UI:new(frame, mainMenu.className)
   menu.backgroundColor = UI.colors.background

   local w, h = love.window.getMode()
   local bw, bh = 100, 50
   local spacing = 40

   local startButton = Button:new(
      Frame:new(
         Vector2D:new(w / 2 - bw / 2, h / 2 - bh / 2),
         Size:new(bw, bh)
      )
   )
   startButton.text = "Start the game"
   startButton:setBackgroundColor(UI.colors.button.background, ControlState.NORMAL)
   startButton.align = "center"

   menu.startButton = startButton

   local quitButton = Button:new(
      Frame:new(
         Vector2D:new(w / 2 - bw / 2, h / 2 - bh / 2 + spacing + bh),
         Size:new(bw, bh)
      )
   )
   quitButton.text = "Quit"
   quitButton:setBackgroundColor(UI.colors.button.background, ControlState.NORMAL)
   quitButton.align = "center"

   menu.quitButton = quitButton

   setmetatable(menu, self)

   self.__index = self

   return menu
end

--- Life cycle

function mainMenu:load()
   self.startButton:addTapGestureRecognizer(function (_)
      self.startGame(self)
   end)
   self.quitButton:addTapGestureRecognizer(function (_)
      self.quit(self)
   end)

   self:addSubview(self.startButton)
   self:addSubview(self.quitButton)

   UI.load(self)
end


return mainMenu
