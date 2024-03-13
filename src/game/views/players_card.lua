local Button = require("src.ui.view.button")
local colors = require("src.ui.view.colors")


---@class PlayersCard: Button
---@field character Character?
local PlayersCard = {
   className = "PlayersCard",
}
setmetatable(PlayersCard, { __index = Button})

---@param frame Frame
---@param character Character?
function PlayersCard:new(frame, character)
   ---@type PlayersCard
   local this = Button:new(frame, PlayersCard.className)

   this.character = character
   if character then
      this.text = character.name
   end

   setmetatable(this, self)

   self.__index = self

   return this
end

function PlayersCard:load()
   if not self.character then
      self:setBackgroundColor(colors.BLACK, ControlState.NORMAL)
   end

   self:setBackgroundColor(colors.WHITE, ControlState.HOVERED)

   Button.load(self)
end


return PlayersCard
