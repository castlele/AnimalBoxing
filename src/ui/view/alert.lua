Button = require("src.ui.view.button")
Colors = require("src.ui.view.colors")
UI = require("src.ui.view.base_ui")


---@class Alert : UI
---@field dialogView UI
---@field dimmedView UI
local Alert = {
   className = "Alert",
}
setmetatable(Alert, { __index = UI })

---@param className? string
function Alert:new(className)
   if className then
      Alert.className = className
   end

   ---@type Alert
   local this = UI:new(Frame.screenSize(), className)

   -- TODO: Consider moving to a standard UI component
   this.dialogView = UI:new(nil, "DialogView")
   this.dimmedView = UI:new(Frame.screenSize(), "DimmedView")

   setmetatable(this, self)

   self.__index = self

   return this
end

-- Life Cycle

function Alert:load()
   self:configureLayout()
   self:configureAppearance()

   self:addSubview(self.dimmedView)
   self.dimmedView:addSubview(self.dialogView)

   UI.load(self)
end

-- Private methods

---@private
function Alert:configureLayout()
   self:configureDialogLayout()
end

---@private
function Alert:configureDialogLayout()
   local dw, dh = 300, 200

   self.dialogView.frame = Frame:new(
      Vector2D:new(
         self.frame.origin.x + self.frame.size.width / 2 - dw / 2,
         self.frame.origin.y + self.frame.size.height / 2 - dh / 2
      ),
      Size:new(dw, dh)
   )

   local buttonSize = Size:new(dw / 2, 50)

   -- TODO: Add configuration from outside
   ---@type Button
   local closeButton = Button:new(
      Frame:new(
         Vector2D:new(
            self.dialogView.frame.origin.x,
            self.dialogView.frame.origin.y + dh - buttonSize.height
         ),
         buttonSize
      )
   )
   closeButton.text = "Close"
   closeButton:addTapGestureRecognizer(function (_)
      self:dismiss()
   end)

   ---@type Button
   local confirmationButton = Button:new(
      Frame:new(
         Vector2D:new(
            self.dialogView.frame.origin.x + buttonSize.width,
            self.dialogView.frame.origin.y + dh - buttonSize.height
         ),
         buttonSize:copy()
      )
   )
   confirmationButton.text = "Start the Boxing"
   confirmationButton:addTapGestureRecognizer(function (_)
      print("STARTING....")
      love.window.close()
   end)

   self.dialogView:addSubview(closeButton)
   self.dialogView:addSubview(confirmationButton)
end

---@private
function Alert:configureAppearance()
   self.backgroundColor = Colors.CLEAR

   self:configureDimmedViewAppearance()
end

---@private
function Alert:configureDimmedViewAppearance()
   self.dimmedView.backgroundColor = Colors.DIMMED
end

return Alert
