function love.load()
   love.graphics.setDefaultFilter("nearest", "nearest")

   require("src")

   Load()
end

function love.update(dt)
   Update(dt)
end

function love.mousepressed(x, y, button, _, presses)
   ---@type EventType
   local sourceType = {}

   if button == 1 then
      sourceType = "mouseLeftButton"
   else
      sourceType = "mouseRightButton"
   end

   local mouseEvent = MouseEvent:new(
      Vector2D:new(x, y),
      "mousepressed",
      sourceType,
      presses
   )

   SendMouseEvent(mouseEvent)
end

function love.draw()
   Draw()
end
