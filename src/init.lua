require("src.foundation")
require("src.ui.view.event")

Game = require("src.game")
Config = require("src.config")
World = require("src.world")


function Load()
   Game:load()
end


---@param dt number
function Update(dt)
   Game:update(dt)
end


---@param event MouseEvent
function SendMouseEvent(event)
   Game:processMouseEvent(event)
end


function Draw()
   Game:draw()

   if Config.isDebug then
      local fps = love.timer.getFPS()

      love.graphics.push()
      love.graphics.print("FPS: " .. tostring(fps))
      love.graphics.pop()
   end
end
