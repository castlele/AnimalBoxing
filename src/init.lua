require("src.foundation.math_types")
require("src.ui.view.event")


LuaClass = require("src.foundation.oop_helpers")
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

   if Config.isDebug and Config.debug.isFps then
      local fps = love.timer.getFPS()

      love.graphics.push()
      love.graphics.setColor(require("src.ui.view.colors").BLACK)
      love.graphics.print("FPS: " .. tostring(fps))
      love.graphics.pop()
   end
end
