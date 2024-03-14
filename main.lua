
-- Local functions

---@return MouseEvent
local function packMouseEvent(x, y, button, presses, type)
   ---@type EventType
   local sourceType

   if button == 1 then
      sourceType = "mouseLeftButton"
   else
      sourceType = "mouseRightButton"
   end

   local mouseEvent = MouseEvent:new(
      Vector2D:new(x, y),
      type,
      sourceType,
      presses
   )

   return mouseEvent
end

-- love methods

function love.load()
   love.graphics.setDefaultFilter("nearest", "nearest")

   require("src")

   Load()
end

function love.update(dt)
   Update(dt)
end

function love.mousepressed(x, y, button, _, presses)
   local mouseEvent = packMouseEvent(x, y, button, presses, "mousepressed")

   SendMouseEvent(mouseEvent)
end

function love.mousereleased(x, y, button, _, presses)
   local mouseEvent = packMouseEvent(x, y, button, presses, "mousereleased")

   SendMouseEvent(mouseEvent)
end

function love.draw()
   Draw()
end
