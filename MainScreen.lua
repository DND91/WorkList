
currentScreen = MainScreen.create()


MainScreen = {}
MainScreen.__index = MainScreen

function MainScreen.create()
   local self = setmetatable({},MainScreen)
   self.name = "KORWIN"
   return self
end

function MainScreen:draw()
  
end

function MainScreen:update()
  
end

function MainScreen:event(event, param1, param2, param3)
  
end