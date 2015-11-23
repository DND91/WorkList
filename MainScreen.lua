os.loadAPI("dnd_util")

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
  printCenterCon(" === MENU === ")
  printCenterCon("1. Tasks")
  printCenterCon("2. Workers")
  printCenterCon("3. Exit")
  printCenterCon("Answer: " .. answer)
  printCenterCon("- Choose menu -")
  printCenterCon(input)
end