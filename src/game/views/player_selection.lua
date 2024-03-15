local UI = require("src.ui.view.base_ui")
local Button = require("src.ui.view.button")
local Grid = require("src.game.views.grid")
local PlayersCard = require("src.game.views.players_card")
local SceneSelection = require("src.game.views.scene_selection")
local characters = require("src.entities.characters")
local colors = require("src.ui.view.colors")


---@class PlayerSelection: UI
---@field backButton Button
---@field continueButton Button
---@field numberOfPlayers integer
---@field characters Characters
---@field selectedLeft Character?
---@field selectedRight Character?
local PlayerSelection = {
   className = "PlayerSelection"
}
setmetatable(PlayerSelection, { __index = UI })

-- Private properties

---@param self PlayerSelection
---@param cellFrame Frame
---@param column integer
---@param row integer
---@param columns integer
---@param _ integer
---@return UI
PlayerSelection._createCell = function (self, cellFrame, column, row, columns, _)
   ---@type Character?
   local character = nil
   local characterIndex = (row * columns) + column + 1

   if self.characters:getLen() >= characterIndex then
      character = self.characters:getByIndex(characterIndex)
   end

   local playersCard = PlayersCard:new(cellFrame, character)
   playersCard:setBackgroundColor(colors.RED, ControlState.NORMAL)

   return playersCard
end

---@param self PlayerSelection
---@param cell PlayersCard
PlayerSelection._handleLeftSelection = function (self, cell)
   if not cell.character then return end

   self.selectedLeft = cell.character
   Game.players:selectCharacterForPlayer1(cell.character)
end

---@param self PlayerSelection
---@param cell PlayersCard
PlayerSelection._handleRightSelection = function (self, cell)
   if not cell.character then return end

   self.selectedRight = cell.character
   Game.players:selectCharacterForPlayer2(cell.character)
end

-- Init

---@param frame Frame
function PlayerSelection:new(frame)
   ---@type PlayerSelection
   local ps = UI:new(frame, PlayerSelection.className)
   -- TODO: Make it dynamic
   ps.numberOfPlayers = 2
   ps.characters = characters
   ps.selectedLeft = Game.players.player1.character
   ps.selectedRight = nil

   ps.backgroundColor = UI.colors.background

   setmetatable(ps, self)

   self.__index = self

   return ps
end

-- Life Cycle

function PlayerSelection:load()
   self:configureBackButton()
   self:configureContinueButton()
   self:layoutPlayerSelectionGrids()

   UI.load(self)
end

---@param dt number
function PlayerSelection:update(dt)
   UI.update(self, dt)

   self:showContinueButtonIfPossible()
end

function PlayerSelection:draw()
   UI.draw(self)

   love.graphics.push()

   if self.selectedLeft then
      -- TODO: move to Image subview
      love.graphics.setColor({0,0,0})
      love.graphics.draw(
         self.selectedLeft.spriteSheet,
         100,
         50
      )
   end

   if self.selectedRight then
      -- TODO: move to Image subview
      love.graphics.setColor({0,0,0})
      love.graphics.draw(
         self.selectedRight.spriteSheet,
         300,
         50
      )
   end

   love.graphics.pop()
end

-- Private methods

---@private
function PlayerSelection:configureBackButton()
   local spacing = 20
   local backButtonFrame = Frame:new(
      Vector2D:new(
         self.frame.origin.x + spacing,
         self.frame.origin.y + spacing
      ),
      Size:new(100, 50)
   )
   ---@type Button
   local backButton = Button:new(backButtonFrame)

   backButton:setBackgroundColor(colors.RED, ControlState.NORMAL)
   backButton:addTapGestureRecognizer(function (_) self:dismiss() end)

   self.backButton = backButton
   self:addSubview(self.backButton)
end

---@private
function PlayerSelection:configureContinueButton()
   local bw, bh = 100, 50

   local continueButtonFrame = Frame:new(
      Vector2D:new(
         self.frame.size.width / 2 - bw / 2,
         self.frame.size.height / 2 - bh / 2
      ),
      Size:new(bw, bh)
   )
   ---@type Button
   local continueButton = Button:new(continueButtonFrame)

   continueButton:setBackgroundColor(colors.RED, ControlState.NORMAL)
   continueButton:addTapGestureRecognizer(function (_)
      self:present(SceneSelection:new(self.frame))
   end)

   self.continueButton = continueButton
   self.continueButton.isHidden = false
   self:addSubview(self.continueButton)
end

---@private
---@param self PlayerSelection
function PlayerSelection:layoutPlayerSelectionGrids()
   -- TODO: update without padding and with the autolayout
   local padding = 50
   local spacing = 5
   local cellSize = 50
   local rowWidth = 6
   local columnHeight = 2
   local hSpacing = spacing * columnHeight - 1
   local vSpacing = spacing * rowWidth - 1
   local createCellMethod = function (cellFrame, column, row, columns, rows)
      -- TODO: can be refactored with self:createCell???
      return self._createCell(self, cellFrame, column, row, columns, rows)
   end
   local handleLeftSelection = function (cell)
      -- TODO: can be refactored with self:handleLeftSelection???
      self._handleLeftSelection(self, cell)
   end
   local handleRightSelection = function (cell)
      -- TODO: can be refactored with self:handleRightSelection???
      self._handleRightSelection(self, cell)
   end

   -- TODO: refactor without Frames ???
   -- TODO: refactor with different methods
   if self.numberOfPlayers == 2 then
      local lFrame = Frame:new(
         Vector2D:new(
            self.frame.origin.x + padding,
            self.frame.size.height / 2 - columnHeight * cellSize - hSpacing
         ),
         Size:new(
            cellSize * rowWidth + vSpacing,
            cellSize * columnHeight + hSpacing
         )
      )
      local rFrame = Frame:new(
         Vector2D:new(
            self.frame.size.width - padding - lFrame.size.width,
            lFrame.origin.y
         ),
         lFrame.size
      )

      local lGrid = Grid:new(
         lFrame.origin,
         Size:new(cellSize, cellSize),
         columnHeight,
         rowWidth,
         spacing
      )
      lGrid.createCell = createCellMethod
      lGrid.cellTapHandler = handleLeftSelection

      local rGrid = Grid:new(
         rFrame.origin,
         Size:new(cellSize, cellSize),
         columnHeight,
         rowWidth,
         spacing
      )
      rGrid.createCell = createCellMethod
      rGrid.cellTapHandler = handleRightSelection

      lGrid.spacing = spacing
      rGrid.spacing = spacing

      self:addSubview(lGrid)
      self:addSubview(rGrid)
   end
end

---@private
function PlayerSelection:showContinueButtonIfPossible()
   self.continueButton.isHidden = not Game.players:isCharactersSelected()
end


return PlayerSelection
