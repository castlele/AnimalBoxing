local LifeCycle = require("src.ui.interface.life_cycle")


---@class SceneFrame
---@field minX number
---@field maxX number


---@class Scene : LifeCycle
---@field name string
---@field backgroundImage love.Image
---@field playerSpawnPos table<integer, Vector2D>
---@field frame SceneFrame
---@field floor Frame
Scene = {
   className = "Scene",
}
setmetatable(Scene, { __index = LifeCycle })

-- Init

---@param name string
---@param image love.Image
---@param playerSpawnPos table<integer, Vector2D>
---@param frame SceneFrame
---@param floor Frame
---@return Scene
function Scene:new(name, image, playerSpawnPos, frame, floor)
   ---@type Scene
   local scene = {
      name = name,
      backgroundImage = image,
      playerSpawnPos = playerSpawnPos,
      frame = frame,
      floor = floor,
   }

   setmetatable(scene, self)

   self.__index = self

   return scene
end

-- Public methods

---@return Scene
function Scene:createDebug()
   local posPadding = 40
   local playerPos = {
      [1] = { x = posPadding, y = love.graphics.getHeight() - posPadding },
      [2] = {
         x = love.graphics.getWidth() - posPadding,
         y = love.graphics.getHeight() - posPadding,
      },
   }
   ---@type SceneFrame
   local frame = {
      minX = 0,
      maxX = love.graphics.getWidth(),
   }
   local floor = Frame:new(
      Vector2D:new(
         0,
         love.graphics.getHeight()
      ),
      Size:new(
         love.graphics.getWidth(),
         10
      )
   )

   return Scene:new(
      "debug",
      love.graphics.newImage("res/sprites/debug_background.png"),
      playerPos,
      frame,
      floor
   )
end

---@param index integer
---@return Vector2D
function Scene:getPlayerPos(index)
   return self.playerSpawnPos[index]
end

-- Life cycle

function Scene:load()
   self:createFrame()
   self:createFloor()
end

function Scene:update(dt)
end

function Scene:draw()
   ---@type Size
   local size = {
      width = self.backgroundImage:getWidth(),
      height = self.backgroundImage:getHeight(),
   }
   local screenWidth = love.graphics.getWidth()
   local screenHeight = love.graphics.getHeight()
   local sx = 1
   local sy = 1

   if size.width > screenWidth then
      sx = 1 / size.width / screenWidth
   elseif size.width < screenWidth then
      sx = screenWidth / size.width
   end

   if size.height > screenHeight then
      sy = 1 / size.height / screenWidth
   elseif size.height < screenHeight then
      sy = screenHeight / size.height
   end

   love.graphics.draw(
      self.backgroundImage,
      0,
      0,
      nil,
      sx,
      sy
   )
end

---@private
function Scene:createFrame()
   local minY = 0
   local maxY = love.graphics.getHeight()

   local leadingFrameCollider = World:newLineCollider(self.frame.minX, minY, self.frame.minX, maxY)
   local trailingFrameCollider = World:newLineCollider(self.frame.maxX, minY, self.frame.maxX, maxY)

   leadingFrameCollider:setType("static")
   trailingFrameCollider:setType("static")
end

---@private
function Scene:createFloor()
   self.floorCollider = World:newRectangleCollider(
      self.floor.origin.x,
      self.floor.origin.y,
      self.floor.size.width,
      self.floor.size.height
   )

   self.floorCollider:setType("static")
end


return Scene
