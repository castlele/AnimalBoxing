require("src.foundation")
require("src.entities.player")
local LifeCycle = require("src.ui.interface.life_cycle")


---@class Players: LifeCycle
---@field player1 Player
---@field player2 Player
local Players = {
   className = "Players"
}
setmetatable(Players, { __index = LifeCycle })

function Players:new()
   ---@type Players
   local this = {
      player1 = Player:new(Vector2D:new(0, 0)),
      player2 = Player:new(Vector2D:new(100, 0)),
   }

   setmetatable(this, self)

   self.__index = self

   return this
end

-- Publich methods

---@param character Character
function Players:selectCharacterForPlayer1(character)
   self.player1.character = character
   self.player1:configure(character.spriteSheet, "left")
end

---@param character Character
function Players:selectCharacterForPlayer2(character)
   self.player2.character = character
   self.player2:configure(character.spriteSheet, "right")
end

---@return boolean
function Players:isCharactersSelected()
   return self.player1.character ~= nil and self.player2.character ~= nil
end

function Players:isPlayersReady()
   return self:isMainPlayerReady() and self:isOpponentConnected()
end

---@return boolean
function Players:isOpponentConnected()
   return self.player2:hasJoystick()
end

---@return boolean
function Players:isMainPlayerReady()
   return self.player1:hasJoystick()
end

-- Life cycle

function Players:update(dt)
   local joysticks = love.joystick.getJoysticks()

   table.foreach(joysticks, function (index, joystick)
      --TODO: Allow to select controllers
      -- if index == 1 then
      --    self.player1.joystick = joystick
      -- end
      --
      -- if index == 2 then
      --    if self.secondPlayer == nil then
      --       self.secondPlayer = Player:new(Vector2D:new(100, 0))
      --    end
      --
      --    self.secondPlayer.joystick = joystick
      -- end
   end)

   self.player1:update(dt)
   self.player2:update(dt)
end

function Players:draw()
   self.player1:draw()
   self.player2:draw()
end


return Players
