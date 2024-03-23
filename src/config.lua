---@class Gravity
---@field x number
---@field y number
---@class Config
---@field gravity Gravity
---@field isDebug boolean
---@field debug table
local Config = {
   gravity = { x=0, y=500 },
   isDebug = true,
   debug = {
      isFps = true,
      isClassName = false,
      isBorder = true,
   }
}


return Config
