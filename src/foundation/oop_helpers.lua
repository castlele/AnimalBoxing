---@class LuaClass
local LuaClass = {
   className = "LuaClass",
}
LuaClass.__index = LuaClass

---@param name string
---@return LuaClass
function LuaClass:new(name)
   ---@type LuaClass
   local class = {
      className = name,
   }
   setmetatable(class, LuaClass)

   return class
end

---@param obj table
---@param class LuaClass
---@return boolean
function IsInstance(obj, class)
   local name = obj["className"]

   if name == nil then return false end

   return name == class.className
end


return LuaClass
