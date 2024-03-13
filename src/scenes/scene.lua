require("src.utils.math_types")

---@class Scene
---@field backgroundImage love.Image
---@field playerSpawnPos table<integer, Vector2D>
---@field frame SceneFrame
---@field floor Frame
Scene = {}

---@class SceneFrame
---@field minX number
---@field maxX number

---@param image love.Image
---@param playerSpawnPos table<integer, Vector2D>
---@param frame SceneFrame
---@param floor Frame
---@return Scene
function Scene:new(image, playerSpawnPos, frame, floor)
   ---@type Scene
   local scene = {
      backgroundImage = image,
      playerSpawnPos = playerSpawnPos,
      frame = frame,
      floor = floor,
   }

   setmetatable(scene, self)

   self.__index = self

   return scene
end

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
   ---@type Frame
   local floor = {
      origin = {
         x = 0,
         y = love.graphics.getHeight(),
      },
      size = {
         width = love.graphics.getWidth(),
         height = 10,
      }
   }

   return Scene:new(
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
