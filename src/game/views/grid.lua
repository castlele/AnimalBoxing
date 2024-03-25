local UI = require("src.ui.view.base_ui")

-- TODO: Move to src.ui.view.grid

---@class Grid: UI
---@field rows integer
---@field columns integer
---@field spacing number
---@field cellWidth number
---@field cellHeight number
---@field createCell? fun(cellFrame: Frame, column: integer, row: integer, columns: integer, rows: integer): UI
---@field cellTapHandler? fun(cell: UI)
local Grid = {
   className = "Grid"
}
setmetatable(Grid, { __index = UI })

-- Init

---@param pos Vector2D?
---@param cellSize Size
---@param rows integer
---@param columns integer
---@param spacing number
function Grid:new(pos, cellSize, rows, columns, spacing)
   local frame = Frame:new(
      pos or Vector2D:new(0, 0),
      Size:new(
         (spacing - 1 + cellSize.width) * columns,
         (spacing - 1 + cellSize.height) * rows
      )
   )
   ---@type Grid
   local this = UI:new(frame, Grid.className)

   this.rows = rows
   this.columns = columns
   this.spacing = spacing
   this.cellWidth = cellSize.width
   this.cellHeight = cellSize.height
   this.createCell = nil
   this.cellTapHandler = nil

   setmetatable(this, self)

   self.__index = self

   return this
end

-- Life cycle

function Grid:load()
   if not self.createCell then return end

   for row = 0, self.rows - 1 do
      for col = 0, self.columns - 1 do
         local originX = self.frame.origin.x
         local originY = self.frame.origin.y

         local cellFrame = Frame:new(
            Vector2D:new(
               originX + col * (self.cellWidth + self.spacing),
               originY + row * (self.cellHeight + self.spacing)
            ),
            Size:new(self.cellWidth, self.cellHeight)
         )

         local cell = self.createCell(
            cellFrame,
            col,
            row,
            self.columns,
            self.rows
         )
         cell:addTapGestureRecognizer(self.cellTapHandler)

         self:addSubview(cell)
      end
   end

   UI.load(self)
end


return Grid
