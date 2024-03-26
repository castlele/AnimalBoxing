---@class Size
---@field width number
---@field height number
Size = {}
setmetatable(Size, { __index = Size })

---@param width number
---@param height number
---@return Size
function Size:new(width, height)
   ---@type Size
   local size = {
      width = width,
      height = height,
   }
   setmetatable(size, Size)

   self.__index = self
   self.__tostring = function (s)
      return "[w: " .. tostring(s.width) .. ", h: " .. tostring(s.height) ..  "]"
   end

   return size
end

---@return boolean
function Size:isZero()
   return self.width == 0 and self.height == 0
end

---@param other Size
---@return boolean
function Size:equals(other)
   return self.width == other.width and self.height == other.height
end

---@return Size
function Size:copy()
   return Size:new(self.width, self.height)
end


---@class Vector2D
---@field x number
---@field y number
Vector2D = {}
setmetatable(Vector2D, { __index = Vector2D })

---@param x number
---@param y number
---@return Vector2D
function Vector2D:new(x, y)
   ---@type Vector2D
   local vec = {
      x = x,
      y = y,
   }
   setmetatable(vec, Vector2D)

   self.__index = self
   self.__tostring = function (v)
      return "(" .. tostring(v.x) .. "; " .. tostring(v.y) ..  ")"
   end

   return vec
end

---@param other Vector2D
---@return boolean
function Vector2D:equals(other)
   return self.x == other.x and self.y == other.y
end

---@return Vector2D
function Vector2D:copy()
   return Vector2D:new(self.x, self.y)
end

---@param v1 Vector2D
---@param v2 Vector2D
---@return Vector2D
function Vector2D.vector(v1, v2)
   return Vector2D:new(
      v2.x - v1.x,
      v2.y - v1.y
   )
end

---@param v1 Vector2D
---@param v2 Vector2D
---@return number
function Vector2D.dot(v1, v2)
   return v1.x * v2.x + v1.y + v2.y
end


---@class Frame
---@field origin Vector2D
---@field size Size
Frame = {}
setmetatable(Frame, { __index = Frame })

---@param origin Vector2D
---@param size Size
---@return Frame
function Frame:new(origin, size)
   ---@type Frame
   local frame = {
      origin = origin,
      size = size,
   }
   setmetatable(frame, Frame)

   self.__index = self
   self.__tostring = function (f)
      return "[" .. "origin: " .. tostring(f.origin) .. ", size: " .. tostring(f.size) .. "]"
   end

   return frame
end

-- TODO: No translation here
---@param point Vector2D
---@return boolean
function Frame:isPointInside(point)
   local minX = self.origin.x
   local maxX = self.origin.x + self.size.width
   local minY = self.origin.y
   local maxY = self.origin.y + self.size.height

   local isInsideWidth = minX <= point.x and maxX >= point.x
   local isInsideHeight = minY <= point.y and maxY >= point.y

   return isInsideWidth and isInsideHeight
end

---@return Frame
function Frame:copy()
   return Frame:new(self.origin:copy(), self.size:copy())
end

---@return Frame
function Frame.screenSize()
   return Frame:new(
      Vector2D:new(0, 0),
      Size:new(love.window.getMode())
   )
end

---@return Frame
function Frame.frameZero()
   return Frame:new(
      Vector2D:new(0, 0),
      Size:new(0, 0)
   )
end
