local Alert = require("src.ui.view.alert")
local Button = require("src.ui.view.button")
local ButtonState = require("src.ui.view.button_state")
local Colors = require("src.ui.view.colors")
local Grid = require("src.game.views.grid")
local Image = require("src.ui.view.image")
local Texture = require("src.ui.view.texture")
local UI = require("src.ui.view.base_ui")


local cellSize = Size:new(100, 60)
local rows = 1
local columns = 5 -- TODO: Use scenes amount for columns
local gridSpacing = 10


---@class SceneSelection : UI
---@field leftPlayerCharacter Image
---@field rightPlayerCharacter Image
---@field backButton Button
---@field startGameButton Button
---@field grid Grid
local SceneSelection = {
   className = "SceneSelection"
}
setmetatable(SceneSelection, { __index = UI })

-- Init

function SceneSelection:new(frame)
   ---@type SceneSelection
   local this = UI:new(frame, SceneSelection.className)

   -- TODO: Constants or change aproach to player previews
   local imageFrame = Frame:new(Vector2D:new(0, 0), Size:new(50, 50))

   this.leftPlayerCharacter = Image:new(
      imageFrame:copy(),
      Texture:new(Game.players.player1.character.spriteSheet)
   )
   this.rightPlayerCharacter = Image:new(
      imageFrame,
      Texture:new(Game.players.player2.character.spriteSheet)
   )
   this.backButton = Button:new()
   this.startGameButton = Button:new()
   this.grid = Grid:new(nil, cellSize, rows, columns, gridSpacing)

   setmetatable(this, self)

   self.__index = self

   return this
end

-- Life cycle

function SceneSelection:load()
   self:configureLayout()
   self:bind()
   self:configureAppearance()

   self:addSubview(self.leftPlayerCharacter)
   self:addSubview(self.rightPlayerCharacter)
   self:addSubview(self.grid)
   self:addSubview(self.backButton)
   self:addSubview(self.startGameButton)

   UI.load(self)
end

---@param dt number
function SceneSelection:update(dt)
   self:configureSelectedScene()

   UI.update(self, dt)
end

-- Private methods

---@private
function SceneSelection:configureLayout()
   self:configureGridLayout()
   self:configureBackButtonLayout()
   self:configureStartGameButtonLayout()
end

---@private
function SceneSelection:configureBackButtonLayout()
   -- TODO: Refactor
   -- TODO: Make back button a common view
   local spacing = 20

   self.backButton.frame = Frame:new(
      Vector2D:new(
         self.frame.origin.x + spacing,
         self.frame.origin.y + spacing
      ),
      Size:new(100, 50)
   )
end

---@private
function SceneSelection:configureStartGameButtonLayout()
   -- TODO: Refactor
   -- TODO: Make button a common view
   local spacing = 20
   local w, _ = love.window.getMode()
   local gridFrame= self.grid.frame
   local gridMaxY = gridFrame.origin.y + gridFrame.size.height
   local buttonSize = Size:new(100, 50)

   self.startGameButton.frame = Frame:new(
      Vector2D:new(
         w / 2 - buttonSize.width / 2,
         gridMaxY + spacing
      ),
      buttonSize
   )
end

---@private
function SceneSelection:configureGridLayout()
   local w, h = love.window.getMode()
   local gridSize = self.grid.frame.size
   -- Middle of the bottom half of the screen
   local yPos = (2 * h + h) / 4

   self.grid.frame.origin = Vector2D:new(
      w / 2 - gridSize.width / 2,
      yPos - gridSize.height / 2
   )

   self.grid.createCell = function (cellFrame, column, _, _, _)
      ---@type Button
      local b = Button:new(cellFrame)
      local scene = Game.scenes.scenes[column + 1]

      if scene then
         b.text = scene.name

         b:addTapGestureRecognizer(function (_)
            Game.scenes.currentScene = scene
         end)
      end

      return b
   end
end

---@private
function SceneSelection:bind()
   self.backButton:addTapGestureRecognizer(function (_) self:dismiss() end)
   self.startGameButton:addTapGestureRecognizer(function ()
      self:presentStartGameConfigurmationDialog()
   end)
end

---@private
function SceneSelection:configureAppearance()
   self.backgroundColor = UI.colors.background

   self:configureBackButtonAppearance()
   self:configureStartGameButtonAppearance()
end

---@private
function SceneSelection:configureBackButtonAppearance()
   self.backButton:setBackgroundColor(Colors.RED, ButtonState.NORMAL)
end

function SceneSelection:configureStartGameButtonAppearance()
   self.startGameButton:setBackgroundColor(Colors.RED, ButtonState.NORMAL)
end

---@private
function SceneSelection:configureSelectedScene()
   local isHidden = Game.scenes.currentScene == nil

   self.startGameButton.isHidden = isHidden
   self.leftPlayerCharacter.isHidden = isHidden
   self.rightPlayerCharacter.isHidden = isHidden

   if not Game.scenes.currentScene then return end

   self:configureScenePreview()
   self:configurePlayersPreview()
end

---@private
function SceneSelection:configureScenePreview()
   local w, h = love.window.getMode()
   local image = Game.scenes.currentScene.backgroundImage
   local scaleX, scaleY = w / image:getWidth(), h / image:getHeight()
   local texture = Texture:new(
      image,
      Vector2D:new(scaleX, scaleY)
   )

   self:updateTexture(texture)
end

---@private
function SceneSelection:configurePlayersPreview()
   local leftPlayerOrigin = Game.scenes.currentScene:getPlayerPos(1)
   local rightPlayerOrigin = Game.scenes.currentScene:getPlayerPos(2)

   self.leftPlayerCharacter.frame.origin = leftPlayerOrigin
   self.rightPlayerCharacter.frame.origin = rightPlayerOrigin
end

---@private
function SceneSelection:presentStartGameConfigurmationDialog()
   local alert = Alert:new()

   self:present(alert)
end


return SceneSelection
