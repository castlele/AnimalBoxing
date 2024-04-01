---@alias EventType
---| '"mouseLeftButton"'
---| '"mouseRightButton"'


---@class Event : LuaClass
Event = {
   className = "Event",
}
Event.__index = Event


function Event:new()
   local event = {}
   setmetatable(event, self)

   return event
end


---@class MouseEvent : Event
---@field point Vector2D
---@field type string
---| "mousepressed"
---| "mousereleased"
---@field eventType EventType
---@field presses integer
MouseEvent = {
   className = "MouseEvent",
}
setmetatable(MouseEvent, { __index = Event })

---@param point Vector2D
---@param type string
---| "mousepressed"
---@param eventType EventType
---@param presses integer
function MouseEvent:new(point, type, eventType, presses)
   ---@type MouseEvent
   local event = Event:new()
   event.point = point
   event.type = type
   event.eventType = eventType
   event.presses = presses

   setmetatable(event, MouseEvent)

   self.__index = self

   return event
end


---@class KeyboardEvent : Event
---@field key string
KeyboardEvent = {
   classname = "KeyboardEvent",
}
setmetatable(KeyboardEvent, { __index = Event })

---@param key string
function KeyboardEvent:new(key)
   local this = Event:new()

   this.key = key

   setmetatable(this, self)

   self.__index = self

   return this
end

return {
   MOUSE = MouseEvent,
   KEYBOARD = KeyboardEvent,
}
