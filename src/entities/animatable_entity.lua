local anim8 = require("libs.anim8")
local playerConfig = require("src.entities.player_config")
local LifeCycle = require("src.ui.interface.life_cycle")


---@class AnimationType
---@field idle Animation


---@class AnimatableEntity : LifeCycle
---@field spriteSheet love.Image
---@field animations AnimationType
---@field animation Animation?
local AnimatableEntity = {
   className = "AnimatableEntity"
}
setmetatable(AnimatableEntity, { __index = LifeCycle })

---@param className? string
function AnimatableEntity:new(className)
   if className then
      AnimatableEntity.className = className
   end

   local entity = {
      animation = nil,
   }

   setmetatable(entity, self)

   self.__index = self

   return entity
end

-- Public methods

---@param spriteSheet love.Image
---@param direction string
---| "left"
---| "right"
function AnimatableEntity:configure(spriteSheet, direction)
   self.spriteSheet = spriteSheet
   self.animationGrid = anim8.newGrid(
      playerConfig.size.width,
      playerConfig.size.height,
      spriteSheet:getWidth(),
      spriteSheet:getHeight()
   )
   ---@type AnimationType
   self.animations = {
      idle = anim8.newAnimation {
         frames = self.animationGrid("1-1", 1),
         durations = 0.2,
      }
   }
   self.animation = self.animations.idle

   if direction == "right" then
      self.animation:flipH()
   end
end

-- Life cycle

---@param dt number
function AnimatableEntity:update(dt)
   self.animation:update(dt)
end

---@param pos Vector2D
function AnimatableEntity:draw(pos)
   self.animation:draw(
      self.spriteSheet,
      pos.x,
      pos.y,
      nil,
      playerConfig.scale.x,
      playerConfig.scale.y
   )
end


return AnimatableEntity
