local UI = require("src.ui.view.base_ui")
local Stack = require("src.ui.view.stack")
local Button = require("src.ui.view.button")
local ButtonState = require("src.ui.view.button_state")
local Texture = require("src.ui.view.texture")
local PlayerSelection = require("src.game.views.player_selection")
local colors = require("src.ui.view.colors")


---@class MainMenu: UI
---@field focusedButton string
---@field _focuseDelay number
---| "none"
---| "start"
---| "quit"
---@field buttonsStack Stack
---@field startButton Button
---@field settingsButton Button
---@field quitButton Button
local mainMenu = { -- TODO: Make raneme to MainMenu
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
   menu.buttonsStack = Stack:new()
   menu.startButton = Button:new()
   menu.settingsButton = Button:new()
   menu.quitButton = Button:new()
   menu._focuseDelay = 0

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

   self:configureLayout()
   self:configureAppearance()

   self.startButton:addTapGestureRecognizer(function (_) self.startGame(self) end)
   -- TODO: Needed a better way of handling gamepad events
   -- self.startButton:addListener(gamepadTapListener)

   self.quitButton:addTapGestureRecognizer(function (_) self.quit(self) end)
   -- TODO: Needed a better way of handling gamepad events
   -- self.quitButton:addListener(gamepadTapListener)

   self:addSubview(self.buttonsStack)
   self.buttonsStack:addArrangedSubview(self.startButton)
   self.buttonsStack:addArrangedSubview(self.settingsButton)
   self.buttonsStack:addArrangedSubview(self.quitButton)

   UI.load(self)
end

---@param dt number
function mainMenu:update(dt)
   if Game.mainControl == "joystick" and Game.mainJoystick then
      if self.focusedButton == "none" then
         self.focusedButton = "start"
      end

      local y = Game.mainJoystick:getGamepadAxis("lefty")

      -- TODO: Remove magic numbers
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

   -- self:focusButton()

   UI.update(self, dt)
end

-- Private methods

-- TODO: Good point to create StackView to space buttons evenly?
---@private
function mainMenu:configureLayout()
   self:configureStackLayout()

   local bw, bh = 200, 80
   local bSize = Size:new(bw, bh)

   self.startButton.frame.size = bSize
   self.settingsButton.frame.size = bSize
   self.quitButton.frame.size = bSize
end

---@private
function mainMenu:configureStackLayout()
   -- TODO: Constants???
   local w, h = love.window.getMode()
   local bw, bh = 200, 80
   local spacing = 20
   local buttonsAmount = 3

   self.buttonsStack.spacing = spacing
   self.buttonsStack.frame.origin = Vector2D:new(
      w / 2 - bw / 2, -- Center of the screen
      h / 2 - bh / 2
   )
end

---@private
function mainMenu:configureAppearance()
   self.buttonsStack.backgroundColor = colors.CLEAR

   local bSize = self.startButton.frame.size
   local bw, bh = bSize.width, bSize.height
   -- TODO: Needed to creaate something like resources object to store imgs and other staff
   local buttonImgNormal = love.graphics.newImage("res/ui/button_yellow_normal.png")
   local buttonImgHighlighted = love.graphics.newImage("res/ui/button_yellow_highlighted.png")
   local imgW, imgH = buttonImgNormal:getWidth(), buttonImgNormal:getHeight()
   local scale = Vector2D:new(bw / imgW, bh / imgH)
   -- TODO: Localize
   local buttons = {
      ["Start the game"] = self.startButton,
      ["Quit"] = self.quitButton,
      ["Settings"] = self.settingsButton,
   }

   for label, button in pairs(buttons) do
      button:setTextColor(colors.WHITE, ButtonState.NORMAL)
      button:setTextColor(colors.WHITE, ButtonState.HIGHLIGHTED)
      button.text = label
      button.align = "center"

      button:setTexture(
         Texture:new(buttonImgNormal, scale),
         ButtonState.NORMAL
      )
      button:setTexture(
         Texture:new(buttonImgHighlighted, scale),
         ButtonState.HIGHLIGHTED
      )
   end
end

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

---@private
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
