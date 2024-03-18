local UI = require("src.ui.view.base_ui")
local Button = require("src.ui.view.button")
local PlayerSelection = require("src.game.views.player_selection")


---@class MainMenu: UI
---@field focusedButton string
---@field _focuseDelay number
---| "none"
---| "start"
---| "quit"
---@field startButton Button
---@field settingsButton Button
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
   menu.focusedButton = "none"
   menu._focuseDelay = 0

   local w, h = love.window.getMode()
   local bw, bh = 100, 50
   local spacing = 40

   -- TODO: Move views configuration to MainMenu:load
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

   local settingsButton = Button:new(
      Frame:new(
         Vector2D:new(w / 2 - bw / 2, h / 2 - bh / 2 + spacing + bh),
         Size:new(bw, bh)
      )
   )

   settingsButton:setImage(love.graphics.newImage("res/ui/toggle_button_on.png"), ControlState.NORMAL)
   settingsButton:setImage(love.graphics.newImage("res/ui/toggle_button_off.png"), ControlState.HIGHLIGHTED)

   menu.settingsButton = settingsButton

   local quitButton = Button:new(
      Frame:new(
         Vector2D:new(w / 2 - bw / 2, h / 2 - bh / 2 + (spacing + bh) * 2),
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

-- Life cycle

function mainMenu:load()
   local gamepadTapListener = function (_)
      -- TODO: Move to event handling???
      if Game.mainControl == "joystick" and Game.mainJoystick then
         if Game.mainJoystick:isGamepadDown("a") then
            if self.focusedButton == "start" then
               self.startGame(self)
            elseif self.focusedButton == "quit" then
               self.quit(self)
            end
         end
      end
   end

   self.startButton:addTapGestureRecognizer(function (_) self.startGame(self) end)
   self.startButton:addListener(gamepadTapListener)

   self.quitButton:addTapGestureRecognizer(function (_) self.quit(self) end)
   self.quitButton:addListener(gamepadTapListener)

   self:addSubview(self.startButton)
   self:addSubview(self.settingsButton)
   self:addSubview(self.quitButton)

   UI.load(self)
end

---@param dt number
function mainMenu:update(dt)
   if Game.mainControl == "joystick" and Game.mainJoystick then
      if self.focusedButton == "none" then
         self.focusedButton = "start"
      end

      local y = Game.mainJoystick:getGamepadAxis("lefty")

      if love.timer.getTime() - self._focuseDelay > 0.2 or self._focuseDelay == 0 then
         if y > 0.3 then
            self:nextButton()
            self._focuseDelay = love.timer.getTime()
         elseif y < -0.3 then
            self:previousButton()
            self._focuseDelay = love.timer.getTime()
         end
      end
   else
      local mousePos = Vector2D:new(love.mouse.getPosition())

      if self.startButton.frame:isPointInside(mousePos) then
         self.focusedButton = "start"
      elseif self.quitButton.frame:isPointInside(mousePos) then
         self.focusedButton = "quit"
      else
         self.focusedButton = "none"
      end
   end

   self:focusButton()

   UI.update(self, dt)
end

-- Private methods

---@private
function mainMenu:nextButton()
   if self.focusedButton == "start" then
      self.focusedButton = "quit"
   elseif self.focusedButton == "quit" then
      self.focusedButton = "start"
   end
end

---@private
function mainMenu:previousButton()
   if self.focusedButton == "start" then
      self.focusedButton = "quit"
   elseif self.focusedButton == "quit" then
      self.focusedButton = "start"
   end
end

function mainMenu:focusButton()
   if self.focusedButton == "start" then
      self.startButton.isFocused = true
      self.quitButton.isFocused = false
   elseif self.focusedButton == "quit" then
      self.startButton.isFocused = false
      self.quitButton.isFocused = true
   else
      self.startButton.isFocused = false
      self.quitButton.isFocused = false
   end
end


return mainMenu
