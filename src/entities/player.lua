local AnimatableEntity = require("src.entities.animatable_entity")


---@class Player: AnimatableEntity
---@field character Character?
---@field pos Vector2D
---@field collider table
---@field joystick love.Joystick?
Player = {
   className = "Player"
}
setmetatable(Player, { __index = AnimatableEntity })

-- Init

---@param initialPos Vector2D
function Player:new(initialPos)
   local player = AnimatableEntity:new(Player.className)

   player.pos = initialPos
   player.joystick = nil
   player.character = nil

   setmetatable(player, self)

   self.__index = self

   return player
end

-- Public methods

---@return boolean
function Player:hasJoystick()
   return self.joystick ~= nil
end

---@return string?
function Player:getJoystickName()
   return self.joystick:getName()
end

---@return Vector2D
function Player:getDirection()
   if self.joystick == nil then return { x=1, y=1 } end

   local x = self.joystick:getAxis(1)
   local y = self.joystick:getAxis(2)

   return { x=x, y=y }
end

function Player:setupCollider()
   -- TODO: get width and height of the collider automatically
   self.collider = World:newRectangleCollider(
      self.pos.x,
      self.pos.y,
      50,
      50
   )
   self.collider:setFixedRotation(true)
end

-- Life cycle

function Player:update(dt)
   local delta = self:getDirection()

   -- TODO: Create constants
   self.collider:applyForce(
      delta.x * 5000,
      delta.y * 5000
   )

   self.pos.x = (self.collider:getX() - 16 * 6 / 2)
   self.pos.y = (self.collider:getY() - 16 * 6 / 2)

   AnimatableEntity.update(self, dt)
end

function Player:draw()
   AnimatableEntity.draw(self, self.pos)
end


return Player
