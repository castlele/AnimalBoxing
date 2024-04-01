local Events = require("src.ui.view.event")

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

   local mouseEvent = Events.MOUSE:new(
      Vector2D:new(x, y),
      type,
      sourceType,
      presses
   )

   return mouseEvent
end

---@param key string
---@return KeyboardEvent
local function packKeyboardEvent(key)
   return Events.KEYBOARD:new(key)
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

function love.keypressed(key, _, _)
   local keyboardEvent = packKeyboardEvent(key)

   SendKeyboardEvent(keyboardEvent)
end

function love.draw()
   Draw()
end
