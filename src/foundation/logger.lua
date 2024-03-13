---@class Logger
---@field _identifier string
local logger = {}
setmetatable(logger, { __index = logger })

---@param className string
---@return Logger
function logger:new(className)
   ---@type Logger
   local _logger = {
      _identifier=className
   }

   setmetatable(_logger, self)

   self.__index = self

   return _logger
end

---@param message string
function logger:log(message)
   print(self._identifier .. ": " .. message)
end


return logger
