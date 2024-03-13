local playersRes = "res/sprites/player_"
local extension = ".png"
local charactersNames = {
   "baton",
   "javie",
}


---@class Characters
---@field collection table<Character>
local Characters = {
   collection = {},
}

---@class Character
---@field name string
---@field spriteSheet love.Image

for _, name in pairs(charactersNames) do
   local character = {
      name = name,
      spriteSheet = love.graphics.newImage(playersRes .. name .. extension),
   }
   table.insert(Characters.collection, character)
end

---@return integer
function Characters:getLen()
   return #self.collection
end

---@param index integer
---@return Character?
function Characters:getByIndex(index)
   return self.collection[index]
end

---@param name string
---@return Character?
function Characters:getByName(name)
   for _, character in pairs(self.collection) do
      if character.name == name then
         return character
      end
   end

   return nil
end


return Characters
